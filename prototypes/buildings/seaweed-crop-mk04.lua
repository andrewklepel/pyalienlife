RECIPE {
    type = "recipe",
    name = "seaweed-crop-mk04",
    energy_required = 0.5,
    enabled = false,
    ingredients = {
        {"metallic-glass", 30},
        {"seaweed-crop-mk03", 1},
        {"low-density-structure", 20},
        {"control-unit", 10},
        {"nenbit-matrix", 50},
    },
    results = {
        {"seaweed-crop-mk04", 1}
    }
}:add_unlock("botany-mk04")

ITEM {
    type = "item",
    name = "seaweed-crop-mk04",
    icon = "__pyalienlifegraphics__/graphics/icons/seaweed-crop-mk04.png",
    icon_size = 64,
    flags = {},
    subgroup = "py-alienlife-farm-buildings-mk04",
    order = "e",
    place_result = "seaweed-crop-mk04",
    stack_size = 10
}

ENTITY {
    type = "assembling-machine",
    name = "seaweed-crop-mk04",
    icon = "__pyalienlifegraphics__/graphics/icons/seaweed-crop-mk04.png",
	icon_size = 64,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = "seaweed-crop-mk04"},
    fast_replaceable_group = "seaweed-crop",
    max_health = 100,
    corpse = "medium-remnants",
    dying_explosion = "big-explosion",
    collision_box = {{-6.2, -6.2}, {6.2, 6.2}},
    selection_box = {{-6.5, -6.5}, {6.5, 6.5}},
    match_animation_speed_to_activity = false,
    module_specification = {
        module_slots = 40
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    crafting_categories = {"seaweed"},
    crafting_speed = 0.1,
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = -35,
    },
    energy_usage = "2300kW",
    animation = {
        layers = {
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/base.png",
                width = 416,
                height = 50,
                line_length = 4,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(0, 183)
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/base-mask.png",
                width = 416,
                height = 50,
                line_length = 4,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(0, 183),
                tint = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a1.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(-176, -34)
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a1-mask.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(-176, -34),
                tint = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a2.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(-112, -34)
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a2-mask.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(-112, -34),
                tint = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a3.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(-48, -34)
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a3-mask.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(-48, -34),
                tint = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a4.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(16, -34)
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a4-mask.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(16, -34),
                tint = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a5.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(80, -34)
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a5-mask.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(80, -34),
                tint = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a6.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(144, -34)
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a6-mask.png",
                width = 64,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(144, -34),
                tint = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a7.png",
                width = 32,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(192, -34)
            },
            {
                filename = "__pyalienlifegraphics2__/graphics/entity/seaweed-crop/a7-mask.png",
                width = 32,
                height = 384,
                line_length = 25,
                frame_count = 100,
                animation_speed = 0.4,
                shift = util.by_pixel(192, -34),
                tint = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
            },
        }
    },

    fluid_boxes = {
        --1
        {
            production_type = "input",
            pipe_covers = DATA.Pipes.covers(false, true, true, true),
            pipe_picture = DATA.Pipes.pictures("assembling-machine-3", nil, {0.0, -0.88}, nil, nil),
            base_area = 10,
            base_level = -1,
            pipe_connections = {{type = "input", position = {4.0, -7.0}}}
        },
        {
            production_type = "input",
            pipe_covers = DATA.Pipes.covers(false, true, true, true),
            pipe_picture = DATA.Pipes.pictures("assembling-machine-3", nil, {0.0, -0.88}, nil, nil),
            base_area = 10,
            base_level = -1,
            pipe_connections = {{type = "input", position = {2.0, -7.0}}}
        },
        {
            production_type = "input",
            pipe_covers = DATA.Pipes.covers(false, true, true, true),
            pipe_picture = DATA.Pipes.pictures("assembling-machine-3", nil, {0.0, -0.88}, nil, nil),
            base_area = 10,
            base_level = -1,
            pipe_connections = {{type = "input", position = {-2.0, -7.0}}}
        },
        {
            production_type = "input",
            pipe_covers = DATA.Pipes.covers(false, true, true, true),
            pipe_picture = DATA.Pipes.pictures("assembling-machine-3", nil, {0.0, -0.88}, nil, nil),
            base_area = 10,
            base_level = -1,
            pipe_connections = {{type = "input", position = {-4.0, -7.0}}}
        },
        {
            production_type = "output",
            pipe_covers = DATA.Pipes.covers(false, true, true, true),
            pipe_picture = DATA.Pipes.pictures("assembling-machine-3", nil, {0.0, -0.88}, nil, nil),
            base_level = 1,
            pipe_connections = {{type = "output", position = {2.0, 7.0}}}
        },
        {
            production_type = "output",
            pipe_covers = DATA.Pipes.covers(false, true, true, true),
            pipe_picture = DATA.Pipes.pictures("assembling-machine-3", nil, {0.0, -0.88}, nil, nil),
            base_level = 1,
            pipe_connections = {{type = "output", position = {-2.0, 7.0}}}
        },
        off_when_no_fluid_recipe = true
    },
    vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    working_sound = {
        sound = {filename = "__pyalienlifegraphics__/sounds/seaweed-crop.ogg", volume = 1.5},
        idle_sound = {filename = "__pyalienlifegraphics__/sounds/seaweed-crop.ogg", volume = 0.3},
        audible_distance_modifier = 0.22,
    }
}
