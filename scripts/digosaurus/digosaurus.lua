Digosaurus = {}
Digosaurus.events = {}

require 'digosaurus-prototypes'
require 'digosaurus-gui'
local Table = require('__stdlib__/stdlib/utils/table')

Digosaurus.events.init = function(event)
    global.dig_sites = global.dig_sites or {}
    global.digosaurs = global.digosaurs or {}
end

function Digosaurus.validity_check(dig_data)
    if not dig_data then return false end

    for i = 1, #dig_data.digosaur_inventory do
        local digosaur_data = dig_data.active_digosaurs[i]
        if digosaur_data and not digosaur_data.entity.valid then dig_data.active_digosaurs[i] = nil end
    end

	if
        not dig_data.entity.valid or
        not dig_data.inventory.valid or
        not dig_data.food_input.valid or
        not dig_data.food_inventory.valid or
        not dig_data.digosaur_inventory.valid
    then
        if dig_data.entity.valid then dig_data.entity.destroy() end
        if dig_data.food_input.valid then dig_data.food_input.destroy() end
        if dig_data.digosaur_inventory.valid then dig_data.digosaur_inventory.destroy() end

		global.dig_sites[dig_data.unit_number] = nil
		return false
	end
	return true
end

local function draw_error_sprite(dig_data, sprite)
    rendering.draw_sprite{
        sprite = sprite,
        x_scale = 0.5,
        y_scale = 0.5,
        target = dig_data.entity,
        surface = dig_data.entity.surface,
        time_to_live = 30
    }
end

function Digosaurus.find_random_scanned_ore(dig_data)
    local scanned_ores = dig_data.scanned_ores
    local max_index = 0
    for i, _ in pairs(scanned_ores) do max_index = math.max(max_index, i) end

    while table_size(scanned_ores) ~= 0 do
        local rng = math.random(1, max_index)
        local ore = scanned_ores[rng]
        if ore and ore.valid then return ore, rng end
        scanned_ores[rng] = nil
    end
    return nil
end

function Digosaurus.start_mining_command(dig_data, i)
    local ore, rng = Digosaurus.find_random_scanned_ore(dig_data)
    if not ore then return false end

    local entity = dig_data.entity
    local spawn_point = Digosaurus.digosaurus_spawn_point[entity.direction]
    local digosaur = entity.surface.create_entity{
        name = dig_data.digosaur_inventory[i].name,
        position = {entity.position.x + spawn_point.x, entity.position.y + spawn_point.y},
        force = entity.force,
        create_build_effect_smoke = false,
        direction = entity.direction
    }
    local proxy = entity.surface.create_entity{
        name = Digosaurus.mining_proxies[digosaur.name],
        position = ore.position,
        force = entity.force,
        create_build_effect_smoke = false
    }

    digosaur.set_command{
        type = defines.command.attack,
        target = proxy,
        distraction = defines.distraction.none
    }

    local digosaur_data = {i = i, entity = digosaur, proxy = proxy, ore_id = rng, ore = ore, parent = entity.unit_number, state = 'mining'}
    dig_data.active_digosaurs[i] = digosaur_data
    global.digosaurs[digosaur.unit_number] = digosaur_data
    return digosaur_data
end

function Digosaurus.has_food(food_inventory_contents)
    for food, _ in pairs(Digosaurus.favorite_foods) do
        if food_inventory_contents[food] then return true end
    end
    return false
end

function Digosaurus.eat(food_inventory, food_inventory_contents)
    for food, _ in pairs(food_inventory_contents) do
        if Digosaurus.favorite_foods[food] then
            food_inventory.remove{name = food, count = 1}
            return food
        end
    end
end

Digosaurus.events[60] = function(event)
    for _, dig_data in pairs(global.dig_sites) do
        if not Digosaurus.validity_check(dig_data) then goto continue end
        local entity = dig_data.entity
        local food_inventory_contents = dig_data.food_inventory.get_contents()

        if table_size(dig_data.scanned_ores) == 0 then
            draw_error_sprite(dig_data, 'utility.warning_icon')
        elseif not Digosaurus.has_food(food_inventory_contents) then
            draw_error_sprite(dig_data, 'utility.fuel_icon')
        elseif entity.energy == 0 then
            draw_error_sprite(dig_data, 'utility.electricity_icon_unplugged')
        elseif dig_data.digosaur_inventory.is_empty() then
            draw_error_sprite(dig_data, 'no_module_animal')
        elseif entity.energy < entity.electric_buffer_size * 0.9 then
            draw_error_sprite(dig_data, 'utility.electricity_icon')
        else
            if dig_data.inventory.get_item_count() > 1000 then
                goto continue -- only mine until 1000 ores
            end

            for i = 1, #dig_data.digosaur_inventory do
                local digosaur_data = dig_data.active_digosaurs[i]
                if not digosaur_data and dig_data.digosaur_inventory[i].valid_for_read then
                    digosaur_data = Digosaurus.start_mining_command(dig_data, i)
                    if digosaur_data then
                        digosaur_data.ores_gained_per_trip = Digosaurus.favorite_foods[Digosaurus.eat(dig_data.food_inventory, food_inventory_contents)]
                        goto continue
                    end
                end
            end
        end

        ::continue::
    end
end

Digosaurus.events.on_ai_command_completed = function(event)
    local unit_number = event.unit_number
    local digosaur_data = global.digosaurs[unit_number]
    if not digosaur_data then return end
    local digosaur = digosaur_data.entity
    if digosaur_data.proxy.valid then digosaur_data.proxy.destroy() end

    if digosaur_data.state == 'mining' then
        digosaur_data.state = 'returning'
        digosaur.set_command{
            type = defines.command.go_to_location,
            destination_entity = global.dig_sites[digosaur_data.parent].entity,
            distraction = defines.distraction.none,
            radius = -1.2,
            pathfind_flags = {
                allow_paths_through_own_entities = true,
                low_priority = true
            }
        }
    elseif digosaur_data.state == 'returning' then
        local creature_bonus = Digosaurus.valid_creatures[digosaur.name]
        digosaur.destroy()
        global.digosaurs[unit_number] = nil
        local dig_data = global.dig_sites[digosaur_data.parent]
        dig_data.active_digosaurs[digosaur_data.i] = nil

        local ore = digosaur_data.ore
        if not ore or not ore.valid then return end

        for _, product in pairs(ore.prototype.mineable_properties.products) do
            if product.type == 'item' then
                local to_insert = math.min(ore.amount, digosaur_data.ores_gained_per_trip or 1) * product.amount * creature_bonus
                if to_insert == 0 then return end
                local ore_removed = dig_data.inventory.insert{name = product.name, count = to_insert} / product.amount / creature_bonus
                if not dig_data.inventory[1].valid_for_read or ore_removed == 0 then return end
                if ore.amount > ore_removed then
                    ore.amount = ore.amount - ore_removed
                else
                    ore.deplete()
                    dig_data.scanned_ores[digosaur_data.ore_id] = nil
                end
                dig_data.entity.products_finished = dig_data.entity.products_finished + 1
                return
            end
        end
    end
end

Digosaurus.events.on_built = function(event)
    local entity = event.created_entity or event.entity
    if entity.name ~= 'dino-dig-site' then return end
    entity.active = false
    local surface = entity.surface
    local force = force
    local position = entity.position

    local food_input = surface.create_entity{name = 'dino-dig-site-food-input', force = force, position = position}
    local food_inventory = food_input.get_inventory(defines.inventory.chest)

    global.dig_sites[entity.unit_number] = {
        unit_number = entity.unit_number,
        entity = entity,
        inventory = entity.get_inventory(defines.inventory.assembling_machine_output),
        food_input = food_input,
        food_inventory = food_inventory,
        digosaur_inventory = entity.get_module_inventory(),
        active_digosaurs = {},
        scanned_ores = {}
    }

    Digosaurus.scan_ores(global.dig_sites[entity.unit_number])
end

Digosaurus.events.on_destroyed = function(event)
    local entity = event.entity
	if entity.name ~= 'dino-dig-site' then return end

	local dig_data = global.dig_sites[entity.unit_number]
	global.dig_sites[entity.unit_number] = nil

    local buffer = event.buffer
    if buffer then
        for _, inventory in pairs{dig_data.food_inventory, dig_data.digosaur_inventory} do
            for i = 1, #inventory do
                local slot = inventory[i]
                if slot then buffer.insert(slot) end
            end
        end
    end

    for i = 1, #dig_data.digosaur_inventory do
        local digosaur_data = dig_data.active_digosaurs[i]
        if digosaur_data then
            if digosaur_data.entity and digosaur_data.entity.valid then digosaur_data.entity.destroy() end
            if digosaur_data.proxy and digosaur_data.proxy.valid then digosaur_data.proxy.destroy() end
        end
    end

	dig_data.food_input.destroy()
	dig_data.digosaur_inventory.destroy()
end

gui_events[defines.events.on_gui_click]['dig_food_.'] = function(event)
	local player = game.get_player(event.player_index)
	local element = event.element
	local tags = element.tags
	local dig_data = global.dig_sites[tags.unit_number]
	local cursor_stack = player.cursor_stack
    if not stack then return end

	if cursor_stack.valid_for_read and not Digosaurus.favorite_foods[cursor_stack.name] then return end

	cursor_stack.swap_stack(dig_data.food_inventory[tags.i])
	Digosaurus.update_gui(player.gui.relative.digosaurus_gui)
end

function Digosaurus.scan_ores(dig_data)
    local entity = dig_data.entity
    local position = entity.position
    local range = Digosaurus.mining_range
    local offset = Digosaurus.mining_range_offset[entity.direction]

    local area = {
        {position.x - range + offset.x, position.y - range + offset.y},
        {position.x + range + offset.x, position.y + range + offset.y}
    }

    dig_data.scanned_ores = Table.filter(
        entity.surface.find_entities_filtered{area = area, type = 'resource'},
        function(ore) return Digosaurus.minable_categories[ore.prototype.resource_category] end
    )

    --rendering.clear('pyalienlife')
    --for _, ore in pairs(dig_data.scanned_ores) do rendering.draw_circle{color = {1, 1, 1}, radius = 0.2, filled = true, target = ore, surface = ore.surface} end
end