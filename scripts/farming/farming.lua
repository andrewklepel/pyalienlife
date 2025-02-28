Farming = {}
Farming.events = {}

local farm_buildings = require 'farm-building-list'

function Farming.draw_error(kingdom, entity)
	return rendering.draw_sprite{
        sprite = 'no_module_' .. kingdom,
		x_scale = 0.5,
		y_scale = 0.5,
        target = entity.position,
        surface = entity.surface,
		time_to_live = 30
    }
end

-- animal, plant, or fungi?
function Farming.get_kingdom(entity)
	local name = entity.name:gsub('%-mk..$', '')
	return farm_buildings[name]
end

function Farming.disable_machine(entity)
    local signtype = Farming.get_kingdom(entity)
	if not signtype then return end
    entity.active = false
	global.disabled_farm_buildings[entity.unit_number] = entity
	script.register_on_entity_destroyed(entity)
	entity.crafting_progress = 0
	entity.bonus_progress = 0
	Farming.draw_error(signtype, entity)
end

Farming.events.on_init = function()
	global.disabled_farm_buildings = global.disabled_farm_buildings or {}
	global.enabled_farm_buildings = global.enabled_farm_buildings or {}
	global.next_farm_index = global.next_farm_index or 1
end

Farming.events.on_built = function(event)
	local entity = event.created_entity or event.entity
	if entity.type == 'assembling-machine' then Farming.disable_machine(entity) end
end

Farming.events.on_entity_destroyed = function(event)
	local unit_number = event.unit_number
	if not unit_number then return end
	global.disabled_farm_buildings[unit_number] = nil
end

-- render warning icons
Farming.events[30] = function(event)
	if event.tick % 60 == 0 then return end
	for _, farm in pairs(global.disabled_farm_buildings) do
		if farm.get_module_inventory().is_empty() then
			Farming.draw_error(Farming.get_kingdom(farm), farm)
		else
			global.disabled_farm_buildings[farm.unit_number] = nil
			farm.active = true
			global.enabled_farm_buildings[#global.enabled_farm_buildings + 1] = farm
		end
	end
end

-- every 2 seconds, check up to 60 farm buildings for empty module inventory
Farming.events[121] = function()
	if #global.enabled_farm_buildings == 0 then return end
	local first_index_checked_this_tick = global.next_farm_index
	for i = 1, 60 do
		local farm = global.enabled_farm_buildings[global.next_farm_index]
		if not farm.valid then
			table.remove(global.enabled_farm_buildings, global.next_farm_index)
		elseif farm.get_module_inventory().is_empty() then
			Farming.disable_machine(farm)
			table.remove(global.enabled_farm_buildings, global.next_farm_index)
		else
			global.next_farm_index = global.next_farm_index + 1
		end

		if global.next_farm_index > #global.enabled_farm_buildings then global.next_farm_index = 1 end
		if global.next_farm_index == first_index_checked_this_tick then return end
	end
end