inputpermission set @a[tag=!start_game,r=15] movement enabled
tag @a[tag=!start_game,r=15] add spawn_protection
fog @a[tag=!start_game,r=15] remove custom_fog_dragon
structure load mystructure:wood_only ~-9 -62 ~-2
tp @a[tag=!start_game,r=15] ~ -60 ~
event entity @a[tag=!start_game,r=15] hfrlc:do_tuto
event entity @a[tag=!start_game,r=15] hfrlc:black_room
event entity @e[family=guide,r=10] hfrlc:entity_death
structure load mystructure:tuto_skip_delete ~-15~-13~-15 0_degrees none layer_by_layer 12