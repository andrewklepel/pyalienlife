require('__stdlib__/stdlib/data/data').Util.create_data_globals()
local table = require('__stdlib__/stdlib/utils/table')
local FUN = require('__pycoalprocessing__/prototypes/functions/functions')

require('prototypes/updates/autoplace-fish')
require('prototypes/updates/base-updates')
local collision_mask_util = require '__core__/lualib/collision-mask-util'

if mods['pycoalprocessing'] then
    require('prototypes/updates/pycoalprocessing-updates')
    ITEM('automation-science-pack', 'tool'):set('icon', '__pyalienlifegraphics3__/graphics/icons/automation-science-pack.png')
end

if mods['pyfusionenergy'] then
    require('prototypes/updates/pyfusionenergy-updates')
end

if mods['pyrawores'] then
    require('prototypes/updates/pyrawores-updates')
end

if mods['pyhightech'] then
    require('prototypes/technologies/kicalk')
    require('prototypes/technologies/schrodinger-antelope')
    require('prototypes/buildings/antelope-enclosure-mk01')
    require('prototypes/updates/pyhightech-updates')
end

if mods['pypetroleumhandling'] then
    require('prototypes/updates/pypetroleumhandling-updates')
end

TECHNOLOGY('ralesia'):add_pack('py-science-pack-1')

--ADAPTATIONS

data.raw.item.fawogae = nil

-- table.insert(data.raw.character.character.mining_categories, 'ore-bioreserve')

table.insert(data.raw.character.character.crafting_categories, 'wpu-handcrafting')
table.insert(data.raw.character.character.crafting_categories, 'research-handcrafting')

for _, recipe in pairs(data.raw.recipe) do
    local r = RECIPE(recipe)
    r:replace_ingredient('py-fertilizer', 'fertilizer')
    r:replace_ingredient('organics', 'biomass')
    FUN.results_replacer(r.name, 'organics', 'biomass')
    r:replace_ingredient('ralesia', 'ralesias')
    r:replace_ingredient('raw-fish', 'fish')
    r:replace_ingredient('xyhiphoe-blood', 'arthropod-blood')
end

--local sap1_limits = data.raw.module['sap-tree'].limitation_blacklist
--local sap2_limits = data.raw.module['sap-tree-mk02'].limitation_blacklist
--local sap3_limits = data.raw.module['sap-tree-mk03'].limitation_blacklist
--local sap4_limits = data.raw.module['sap-tree-mk04'].limitation_blacklist
----------------------------------------------------------------------------------------------------
-- MODULE LIMITATION SETUP
----------------------------------------------------------------------------------------------------
local function get_allowed_module_categories(recipe)
    local allowed_module_categories = recipe.allowed_module_categories
    if not allowed_module_categories then
        local cat = data.raw['recipe-category'][recipe.category or 'crafting']
        if cat and cat.allowed_module_categories then
            allowed_module_categories = cat.allowed_module_categories
        end
    end
    return allowed_module_categories or {}
end

local module_categories = {}

for _, type in pairs{'recipe-category', 'recipe'} do
    for _, cat in pairs(data.raw[type]) do
        if cat.allowed_module_categories then
            for _, module_category in pairs(cat.allowed_module_categories) do
                module_categories[module_category] = true
            end
        end
    end
end

for _, module in pairs(data.raw.module) do
    if module_categories[module.category] and not module.limitation then
        module.limitation = {}
    end

    if module.limitation then
        module.dict_limitation = table.array_to_dictionary(module.limitation, true)
    end
end

for _, recipe in pairs(data.raw.recipe) do
    for _, module_category in pairs(get_allowed_module_categories(recipe)) do
        for _, module in pairs(data.raw.module) do
            if module.category == module_category then
                module.dict_limitation[recipe.name] = true
            end
        end
    end
end

for _, recipe in pairs(data.raw.recipe) do
    for _, module_category in pairs(get_allowed_module_categories(recipe)) do
        for _, module in pairs(data.raw.module) do
            if module.category ~= module_category then
                if not module.dict_limitation or table.is_empty(module.dict_limitation) then
                    if module.limitation_blacklist == nil then
                        module.limitation_blacklist = {}
                    end
                    table.insert(module.limitation_blacklist, recipe.name)
                else
                    module.dict_limitation[recipe.name] = nil
                end
            end
        end
    end
end

for _, module in pairs(data.raw.module) do
    if module.dict_limitation then
        module.limitation = table.keys(module.dict_limitation)
        module.dict_limitation = nil
    end
end

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--data.raw.module['sap-tree'].limitation_blacklist = sap1_limits
data.raw.module['sap-tree'].limitation = {'sap-01'}

--data.raw.module['sap-tree-mk02'].limitation_blacklist = sap2_limits
data.raw.module['sap-tree-mk02'].limitation = {'sap-01', 'sap-mk02'}

--data.raw.module['sap-tree-mk03'].limitation_blacklist = sap3_limits
data.raw.module['sap-tree-mk03'].limitation = {'sap-01', 'sap-mk02', 'sap-mk03'}

--data.raw.module['sap-tree-mk04'].limitation_blacklist = sap4_limits
data.raw.module['sap-tree-mk04'].limitation = {'sap-01', 'sap-mk02', 'sap-mk03', 'sap-mk04'}

--remove steel barrel based milk
data.raw.item['milk-barrel'] = nil
--data.raw.recipe['fill-milk-barrel'] = nil
--data.raw.recipe['empty-milk-barrel'] = nil

--FUN.global_item_replacer('fawogae', 'fawogae-mk01')

--RECIPES UPDATES

--Updating base milk barrel with icons. replacing base recipes with py copies to use the right barrel

RECIPE {
    type = 'recipe',
    name = 'fill-milk-barrel',
    category = 'py-barreling',
    enabled = false,
    energy_required = 1,
    ingredients = {
        {type = 'item', name = 'empty-barrel-milk', amount = 1},
        {type = 'fluid', name = 'milk', amount = 50},
    },
    results = {
        {type = 'item', name = 'barrel-milk', amount = 1},
    },
}:remove_unlock('fluid-handling'):add_unlock('korlex')

RECIPE {
    type = 'recipe',
    name = 'empty-milk-barrel',
    category = 'py-unbarreling',
    enabled = false,
    energy_required = 1,
    ingredients = {
        {type = 'item', name = 'barrel-milk', amount = 1},
    },
    results = {
        {type = 'item', name = 'empty-barrel-milk', amount = 1},
        {type = 'fluid', name = 'milk', amount = 50},
    },
    main_product = 'milk',
    icon = '__pyalienlifegraphics__/graphics/icons/empty-barrel-milk-recipe.png',
    icon_size = 64,
}:remove_unlock('fluid-handling'):add_unlock('korlex')

--copy`s of combustion recipes with biomass
for _,recipe in pairs(data.raw.recipe) do
    --log('hit')
    if recipe.category == 'combustion' and string.match(recipe.name, 'biomass') == nil then
        --log('hit')
        local recipe_copy = table.deepcopy(recipe)
        local name = recipe_copy.name
        if recipe_copy.ingredients ~= nil then
            for i, ing in pairs(recipe_copy.ingredients) do
                --log('hit')
                if ing.name == 'coke' then
                    ing.name = 'biomass'
                    local locale
                    local type
                    local temp
                    for _, ingred in pairs(recipe.ingredients) do
                        if ingred.name ~= 'water' and ingred.name ~= 'coke' then
                            locale = ingred.name
                            type = ingred.type
                        end
                    end
                    --log(serpent.block(recipe.ingredients))
                    --log(locale)
                    for _, result in pairs(recipe.results) do
                        if result.name == 'combustion-mixture1' then
                            temp = result.temperature
                        end
                    end
                    RECIPE {
                        type = 'recipe',
                        name = name .. '-biomass',
                        category = 'combustion',
                        enabled = false,
                        energy_required = 3,
                        ingredients = recipe_copy.ingredients,
                        results = recipe_copy.results,
                        icon = recipe_copy.icon,
                        icon_size = recipe_copy.icon_size,
                        --main_product = 'combustion-mixture1',
                        subgroup = recipe_copy.subgroup,
                        order = recipe_copy.order,
                        localised_name = {'recipe-name.biomass-combustion', {type .. '-name.' ..locale}, temp}
                    }
                    -- log(serpent.block(data.raw.recipe[name .. '-biomass']))
                    --log('hit')
                    for _, tech in pairs(data.raw.technology) do
                        --log('hit')
                        --log(serpent.block(tech))
                        if tech.effects ~= nil then
                            for _, effect in pairs(tech.effects) do
                                --log('hit')
                                --log(serpent.block(effect))
                                --log(serpent.block(effect.type))
                                --log(serpent.block(effect.recipe))
                                --log(serpent.block(name))
                                if effect.type == 'unlock-recipe' and effect.recipe == name then
                                    --log('hit')
                                    RECIPE(name .. '-biomass'):add_unlock(tech.name)
                                    --log(serpent.block(data.raw.technology[tech.name]))
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
        --log(serpent.block(data.raw.recipe[name .. '-biomass']))
    end
end

--Tech upgrade stuff--
--require('prototypes/upgrades/hidden-beacon')
--require('prototypes/upgrades/tech-upgrades')

if data.data_crawler then
	  data.script_enabled = {
		{type = 'entity', name = 'tar-patch'},
        {type = 'item', name = 'earth-generic-sample'}
	  }
  end

TECHNOLOGY('filtration-mk02'):remove_prereq('lithium-processing')

--RECIPES UPDATES

-- Add our next upgrades
local searchtypes = {
    'turret',
    'fluid-turret',
    'electric-turret',
    'ammo-turret',
    'accumulator',
    'burner-generator',
    'electric-energy-interface',
    'artillery-turret',
    'generator',
    'lab',
    'solar-panel',
    'pump',
    'lamp',
    'heat-interface',
    'gate',
    'boiler',
    'power-switch',
    'pipe-to-ground',
    'reactor',
    'storage-tank',
    'assembling-machine',
    'rocket-silo',
    'furnace',
    'simple-entity-with-owner',
    'linked-container',
    'wall',
    'simple-entity-with-force',
    'simple-entity',
    'inserter',
    'constant-combinator',
    'mining-drill',
    'train-stop',
    'underground-belt',
    'splitter',
    'loader',
    'loader-1x1',
    'linked-belt',
    'transport-belt',
    'decider-combinator',
    'arithmetic-combinator',
    'radar',
    'pipe',
    'container',
    'logistic-container',
    'infinity-container',
    'electric-pole',
    'roboport',
    'beacon',
    'offshore-pump',
    'heat-pipe'
}

local function next_tier(prototype_name, prototype_category)
    local tier_num = prototype_name:match('%-mk(%d%d)$')
    if tier_num then
        tier_num = tonumber(tier_num)
        if tier_num then
            tier_num = tier_num + 1
            tier_num = string.format('%02d', tier_num)
            return (prototype_category[prototype_name:gsub('%d%d$', tier_num)] or {}).name
        end
    end
end

for _, category in pairs(searchtypes) do
    local raw_cat = data.raw[category]
    if raw_cat then
        for name, prototype in pairs(raw_cat) do
            if not prototype.next_upgrade and prototype.minable and prototype.minable.result
                and data.raw.item[prototype.minable.result]
                and not ITEM(prototype.minable.result):has_flag('hidden')
                and data.raw.item[prototype.minable.result].place_result == name
            then
                prototype.next_upgrade = next_tier(name, raw_cat)
                if prototype.next_upgrade and raw_cat[prototype.next_upgrade].minable
                    and raw_cat[prototype.next_upgrade].minable.result
                    and data.raw.item[raw_cat[prototype.next_upgrade].minable.result]
                    and not ITEM(raw_cat[prototype.next_upgrade].minable.result):has_flag('hidden')
                    and data.raw.item[raw_cat[prototype.next_upgrade].minable.result].place_result == prototype.next_upgrade
                then
                    --log(name .. ' -> ' .. prototype.next_upgrade)
                    if serpent.block(prototype.collision_box) ~= serpent.block(raw_cat[prototype.next_upgrade].collision_box) then
                        --log('Cancelled upgrade: ' .. name .. ' -> ' .. prototype.next_upgrade)
                        prototype.next_upgrade = nil
                    else
                        local next_proto = raw_cat[prototype.next_upgrade]
                        if not prototype.fast_replaceable_group or prototype.fast_replaceable_group ~= next_proto.fast_replaceable_group then
                            prototype.fast_replaceable_group = prototype.name:gsub('%-mk%d%d$', '')
                            next_proto.fast_replaceable_group = prototype.fast_replaceable_group
                        end
                    end
                else
                    prototype.next_upgrade = nil
                end
            end
        end
    else
        --log('Category ' .. category .. ' is empty!')
    end
end

RECIPE('tar-quenching'):remove_unlock('separation'):add_unlock('tar-processing')

RECIPE('concrete'):remove_unlock('separation'):add_unlock('concrete')

RECIPE('hazard-concrete'):remove_unlock('separation'):add_unlock('concrete')

RECIPE('quenching-tower'):remove_unlock('machines-mk01'):remove_unlock('separation'):add_unlock('tar-processing'):remove_ingredient('electronic-circuit')

RECIPE('lime'):remove_unlock('separation'):add_unlock('concrete')

RECIPE('extract-sulfur'):remove_unlock('fluid-processing-machines-1'):add_unlock('tar-processing')

RECIPE('evaporator'):remove_unlock('fluid-processing-machines-1'):add_unlock('tar-processing')

RECIPE('tailings-dust'):remove_unlock('fluid-processing-machines-1'):add_unlock('tar-processing')

RECIPE('sand-brick'):remove_unlock('concrete'):add_unlock('tar-processing')

RECIPE('ball-mill-mk01'):remove_unlock('crusher'):add_unlock('crusher-2')

local farm_building_order = {
	['antelope-enclosure'] = 'c[animal]',
	['arqad-hive'] = 'c[animal]',
	['arthurian-pen'] = 'c[animal]',
	['auog-paddock'] = 'c[animal]',
	['cridren-enclosure'] = 'c[animal]',
	['dhilmos-pool'] = 'd[aquatic]',
	['dingrits-pack'] = 'c[animal]',
	['fish-farm'] = 'd[aquatic]',
	['kmauts-enclosure'] = 'c[animal]',
	['mukmoux-pasture'] = 'c[animal]',
	['phadai-enclosure'] = 'c[animal]',
	['phagnot-corral'] = 'c[animal]',
	['prandium-lab'] = 'c[animal]',
	['ez-ranch'] = 'c[animal]-zz[other]',
	['scrondrix-pen'] = 'c[animal]',
	['simik-den'] = 'c[animal]',
	['trits-reef'] = 'd[aquatic]',
	['ulric-corral'] = 'c[animal]',
	['vonix-den'] = 'c[animal]',
	['vrauks-paddock'] = 'c[animal]',
	['xenopen'] = 'c[animal]',
	['xyhiphoe-pool'] = 'd[aquatic]',
	['zipir-reef'] = 'd[aquatic]',
	['cadaveric-arum'] = 'a[plant]',
	['fwf'] = 'a[plant]-ab[other]',
	['grods-swamp'] = 'a[plant]',
	['guar-gum-plantation'] = 'a[plant]-aa[other]',
	['kicalk-plantation'] = 'a[plant]',
	['moondrop-greenhouse'] = 'a[plant]',
	['moss-farm'] = 'd[aquatic]-zy[other]',
	['ralesia-plantation'] = 'a[plant]',
	['rennea-plantation'] = 'a[plant]',
	['sap-extractor'] = 'a[plant]',
	['seaweed-crop'] = 'd[aquatic]-zx[other]',
	['sponge-culture'] = 'd[aquatic]-zz[other]',
	['tuuphra-plantation'] = 'a[plant]',
	['yotoi-aloe-orchard'] = 'a[plant]',
	['bhoddos-culture'] = 'b[fungi]',
	['fawogae-plantation'] = 'b[fungi]',
	['navens-culture'] = 'b[fungi]',
	['yaedols-culture'] = 'b[fungi]',
    ['zungror-lair'] = 'c[animal]',
    ['numal-reef'] = 'd[aquatic]'
}

for building, order in pairs(farm_building_order) do
    for _, name in pairs{building, building .. '-mk01', building .. '-mk02', building .. '-mk03', building .. '-mk04'} do
        if data.raw.item[name] then
            data.raw.item[name].order = order .. '-b[' .. building .. ']'
        end
        if data.raw.recipe[name] then
            data.raw.recipe[name].order = nil
        end
    end
end

for _, prototype in pairs(collision_mask_util.collect_prototypes_with_layer('object-layer')) do
    if prototype.type ~= 'tree' and prototype.type ~= 'simple-entity' then
        prototype.collision_mask = collision_mask_util.get_mask(prototype)
        if not collision_mask_util.mask_contains_layer(prototype.collision_mask, 'floor-layer') then
            collision_mask_util.add_layer(prototype.collision_mask, caravan_collision_mask)
        end
    end
end

for _, tile in pairs(data.raw.tile) do
    if tile.name == 'out-of-map' or tile.name:find('water') then
        tile.collision_mask = collision_mask_util.get_mask(tile)
        collision_mask_util.add_layer(tile.collision_mask, caravan_collision_mask)
    end
end