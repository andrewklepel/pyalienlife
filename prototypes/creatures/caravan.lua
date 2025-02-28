local util = require('util')
local collision_mask_util = require '__core__/lualib/collision-mask-util'

_G.caravan_collision_mask = collision_mask_util.get_first_unused_layer()

RECIPE {
    type = 'recipe',
    name = 'caravan',
    energy_required = 50,
    category = 'creature-chamber',
    enabled = false,
    ingredients = {
        {type = 'item', name = 'cocoon', amount = 10},
        {type = 'item', name = 'bio-sample', amount = 20},
        --{type = 'item', name = 'auog', amount = 1},
		--{type = 'item', name = 'animal-sample-01', amount = 2},
        {type = 'item', name = 'moss-gen', amount = 15},
        {type = 'item', name = 'earth-generic-sample', amount = 5},
        {type = 'fluid', name = 'water-saline', amount = 100}
    },
    result = 'caravan'
}:add_unlock('zoology')

ITEM {
    type = 'item-with-tags',
    name = 'caravan',
    icon = '__pyalienlifegraphics2__/graphics/icons/caravan.png',
    icon_size = 64,
    subgroup = 'py-alienlife-special-creatures',
    order = 'a',
    place_result = 'caravan',
    stack_size = 1,
	flags = {'not-stackable'}
}

data:extend{{
	type = 'unit',
	additional_pastable_entities = {'caravan'},
	name = 'caravan',
	can_open_gates = true,
	map_color = {1, 1, 1},
	icon = '__pyalienlifegraphics2__/graphics/icons/caravan.png',
	icon_size = 64,
	flags = {'placeable-player', 'placeable-off-grid', 'not-repairable', 'breaths-air', 'building-direction-8-way'},
	minable = {mining_time = 0.1, result = 'caravan'},
	max_health = 3125,
	order = 'b-b-a',
	collision_mask = {caravan_collision_mask},
	subgroup = 'enemies',
	healing_per_tick = 0.03,
	collision_box = {{-0.6, -0.6}, {0.6, 0.6}},
	selection_priority = 51,
	selection_box = {{-1.1, -1.1}, {1.1, 1.1}},
	attack_parameters = {
		type = 'projectile',
		range = 0,
		cooldown = 0,
		ammo_type = _G.make_unit_melee_ammo_type(0),
		--sound = make_biter_roars(0.4),
		animation = {
			layers = {
				{
					filenames = {
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-01.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-02.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-03.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-04.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-05.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-06.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-07.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-08.png'
					},
					slice = 8,
					lines_per_file = 8,
					line_length = 8,
					width = 256,
					height = 224,
					frame_count = 30,
					direction_count = 16,
					shift = util.mul_shift(util.by_pixel(-0, -0), 0.5)
				},
				{
					filenames = {
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-01-mask.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-02-mask.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-03-mask.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-04-mask.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-05-mask.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-06-mask.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-07-mask.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-08-mask.png'
					},
					slice = 8,
					tint = {r = 1.0, g = 1.0, b = 0.0, a = 1.0},
					lines_per_file = 8,
					line_length = 8,
					width = 256,
					height = 224,
					frame_count = 30,
					direction_count = 16,
					shift = util.mul_shift(util.by_pixel(-0, -0), 0.5)
				},
				{
					filenames = {
						'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-01.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-02.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-03.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-04.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-05.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-06.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-07.png',
						'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-08.png'
					},
					slice = 8,
					lines_per_file = 8,
					line_length = 8,
					width = 256,
					height = 224,
					frame_count = 30,
					shift = util.mul_shift(util.by_pixel(0, 48)),
					direction_count = 16,
					--scale = scale,
					draw_as_shadow = true
				}
			}
		}
	},
	vision_distance = 30,
	movement_speed = 0.1,
	distance_per_frame = 0.13,
	pollution_to_join_attack = 4,
	distraction_cooldown = 300,
	min_pursue_time = 10 * 60,
	max_pursue_distance = 50,
	dying_explosion = 'blood-explosion-small',
	has_belt_immunity = true,
	affected_by_tiles = true,
	run_animation = {
		layers = {
			{
				filenames = {
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-01.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-02.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-03.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-04.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-05.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-06.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-07.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-08.png'
				},
				slice = 8,
				lines_per_file = 8,
				line_length = 8,
				width = 256,
				height = 224,
				frame_count = 30,
				direction_count = 16,
				shift = util.mul_shift(util.by_pixel(-0, -0)),
				scale = _G.scale
			},
			{
				filenames = {
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-01-mask.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-02-mask.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-03-mask.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-04-mask.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-05-mask.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-06-mask.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-07-mask.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/caravan-walk-08-mask.png'
				},
				slice = 8,
				tint = {r = 1.0, g = 1.0, b = 0.0, a = 1.0},
				lines_per_file = 8,
				line_length = 8,
				width = 256,
				height = 224,
				frame_count = 30,
				direction_count = 16,
				shift = util.mul_shift(util.by_pixel(-0, -0), 0.5),
				scale = _G.scale
			},
			{
				filenames = {
					'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-01.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-02.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-03.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-04.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-05.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-06.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-07.png',
					'__pyalienlifegraphics2__/graphics/entity/caravan/sh-caravan-walk-08.png'
				},
				slice = 8,
				lines_per_file = 8,
				line_length = 8,
				width = 256,
				height = 224,
				frame_count = 30,
				shift = util.mul_shift(util.by_pixel(-0, 48)),
				direction_count = 16,
				draw_as_shadow = true
			}
		}
	}
}}

data:extend{{
	type = 'ammo-category',
	name = 'caravan-control',
	localised_name = ''
}}

ITEM {
    type = 'item',
    name = 'caravan-control',
    icon = '__pyalienlifegraphics2__/graphics/icons/carrot-on-a-stick.png',
    icon_size = 64,
    order = 'a',
    stack_size = 1,
	flags = {'hidden', 'not-stackable', 'only-in-cursor'},
}

data:extend{{
	type = 'tips-and-tricks-item',
	name = 'caravans',
	category = 'wiki-py',
	indent = 1,
	trigger = {
		type = 'or',
		triggers = {
			{
				type = 'build-entity',
				entity = 'caravan'
			},
			{
				type = 'build-entity',
				entity = 'outpost'
			}
		}
	},
	starting_status = 'unlocked',
	tag = '[item=caravan]',
	order = 'a-a'
}}

data:extend{{
	type = 'virtual-signal',
	icon = '__pyalienlifegraphics2__/graphics/icons/caravan-map-tag.png',
	name = 'caravan-map-tag',
	subgroup = 'py-alienlife-special-creatures',
	icon_size = 64
}}