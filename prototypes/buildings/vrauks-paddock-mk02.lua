local FUN = require("__pycoalprocessing__/prototypes/functions/functions")
local MODULE_SLOTS = 30

RECIPE {
    type = "recipe",
    name = "vrauks-paddock-mk02",
    energy_required = 1,
    enabled = false,
    ingredients = {
        {"vrauks-paddock-mk01", 1},
        {"plastic-bar", 20},
        {"advanced-circuit", 10},
        {"neuroprocessor", 30},
        {"latex", 30},
        {"niobium-plate", 20},
    },
    results = {
        {"vrauks-paddock-mk02", 1}
    }
}:add_unlock("land-animals-mk02"):add_ingredient({type = "item", name = "small-parts-02", amount = 30})

ITEM {
    type = "item",
    name = "vrauks-paddock-mk02",
    icon = "__pyalienlifegraphics__/graphics/icons/vrauks-paddock-mk02.png",
    icon_size = 64,
    flags = {},
    subgroup = "py-alienlife-farm-buildings-mk02",
    order = "d",
    place_result = "vrauks-paddock-mk02",
    stack_size = 10
}

ENTITY {
    type = "assembling-machine",
    name = "vrauks-paddock-mk02",
    icon = "__pyalienlifegraphics__/graphics/icons/vrauks-paddock-mk02.png",
	icon_size = 64,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = "vrauks-paddock-mk02"},
    fast_replaceable_group = "vrauks-paddock",
    max_health = 100,
    corpse = "medium-remnants",
    dying_explosion = "big-explosion",
    collision_box = {{-6.1, -6.1}, {6.1, 6.1}},
    selection_box = {{-6.5, -6.5}, {6.5, 6.5}},
    match_animation_speed_to_activity = false,
    module_specification = {
        module_slots = MODULE_SLOTS
    },
    allowed_effects = {"speed","productivity",'consumption','pollution'},
    crafting_categories = {"vrauks"},
    crafting_speed = FUN.farm_speed_derived(MODULE_SLOTS, "vrauks-paddock-mk01"),
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = 1,
    },
    energy_usage = "450kW",
    animation = {
        layers = {
            {
                filename = "__pyalienlifegraphics3__/graphics/entity/vrauks-paddock/vrauks-paddock-mk02.png",
                width = 448,
                height = 448,
                --line_length = 5,
                frame_count = 1,
                --animation_speed = 0.3,
                shift = util.by_pixel(16, -16)
            },
        }
    },
    working_visualisations = {
        {
            north_position = {-2.0, -2.0},
            west_position = {-2.0, -2.0},
            south_position = {-2.0, -2.0},
            east_position = {-2.0, -2.0},
            animation = {
                filename = "__pyalienlifegraphics3__/graphics/entity/vrauks-paddock/alpha.png",
                frame_count = 90,
                line_length = 9,
                width = 128,
                height = 160,
                animation_speed = 0.4
            }
        },
        {
            north_position = {3.0, -3.0},
            west_position = {3.0, -3.0},
            south_position = {3.0, -3.0},
            east_position = {3.0, -3.0},
            animation = {
                filename = "__pyalienlifegraphics3__/graphics/entity/vrauks-paddock/beta.png",
                frame_count = 90,
                line_length = 9,
                width = 128,
                height = 128,
                animation_speed = 0.4
            }
        },
        {
            north_position = {0.0, 3.1},
            west_position = {0.0, 3.1},
            south_position = {0.0, 3.1},
            east_position = {0.0, 3.1},
            animation = {
                filename = "__pyalienlifegraphics3__/graphics/entity/vrauks-paddock/midbottom.png",
                frame_count = 90,
                line_length = 9,
                width = 160,
                height = 128,
                animation_speed = 0.4
            }
        },
        {
            north_position = {2.2, 0.7},
            west_position = {2.2, 0.7},
            south_position = {2.2, 0.7},
            east_position = {2.2, 0.7},
            animation = {
                filename = "__pyalienlifegraphics3__/graphics/entity/vrauks-paddock/right.png",
                frame_count = 90,
                line_length = 10,
                width = 128,
                height = 128,
                animation_speed = 0.4
            }
        },
        {
            north_position = {-4.0, 1.7},
            west_position = {-4.0, 1.7},
            south_position = {-4.0, 1.7},
            east_position = {-4.0, 1.7},
            animation = {
                filename = "__pyalienlifegraphics3__/graphics/entity/vrauks-paddock/small-01.png",
                frame_count = 90,
                line_length = 10,
                width = 96,
                height = 64,
                animation_speed = 0.4
            }
        },
        {
            north_position = {-2.5, 1.6},
            west_position = {-2.5, 1.6},
            south_position = {-2.5, 1.6},
            east_position = {-2.5, 1.6},
            animation = {
                filename = "__pyalienlifegraphics3__/graphics/entity/vrauks-paddock/small-02.png",
                frame_count = 180,
                line_length = 18,
                width = 64,
                height = 96,
                animation_speed = 0.4
            }
        },
    },

    vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    working_sound = {
        sound = {filename = "__pyalienlifegraphics__/sounds/vrauks-paddock.ogg", volume = 0.8},
        idle_sound = {filename = "__pyalienlifegraphics__/sounds/vrauks-paddock.ogg", volume = 0.3},
        apparent_volume = 2.5
    }
}
