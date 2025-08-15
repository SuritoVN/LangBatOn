tag @s[tag=do_tuto0] remove black_room_func
tp @s[tag=loop_stopMove] ~~-5.5~-3 0 5


inputpermission set @s[tag=do_tuto] camera disabled
inputpermission set @s[tag=do_tuto] movement disabled
tag @s[tag=do_tuto] add do_tuto0
tag @s[tag=do_tuto] add doing_mining_wood
clear @s[tag=do_tuto] hfrlc:system_level
tp @s[tag=do_tuto] ~~-4~-3 0 5
tag @s[tag=do_tuto] add active_tuto0
execute if entity @s[tag=do_tuto] run summon hfrlc:guide_texts ~~-4.5~1 ~~ minecraft:entity_spawned "Try mining wood."
gamemode a @s[tag=do_tuto]
stopsound @s[tag=do_tuto] tutorial.dialogue.intro2
playsound tutorial.dialogue.1 @s[tag=do_tuto] ~ ~ ~ 9
tellraw @s[tag=do_tuto] {"rawtext": [{"translate": "tutorial.dialogue.subtitles1"}]}
inputpermission set @s[tag=do_tuto] camera enabled
inputpermission set @s[tag=do_tuto] movement enabled
tag @s[tag=do_tuto] remove do_tuto


execute if entity @s[tag=do_tuto2] run event entity @e[r=15,family=guide] hfrlc:entity_death
tag @s[tag=do_tuto2] remove doing_mining_wood
tag @s[tag=do_tuto2] remove active_tuto0
tag @s[tag=do_tuto2] add active_tuto2
inputpermission set @s[tag=do_tuto2] camera disabled
inputpermission set @s[tag=do_tuto2] movement disabled
tag @s[tag=do_tuto2] add loop_stopMove
effect @s[tag=do_tuto2] blindness 1 255 true
tp @s[tag=do_tuto2] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto2] run structure load mystructure:wood_only ~-6~-6~-6
stopsound @s[tag=do_tuto2] tutorial.dialogue.1
playsound tutorial.dialogue.2 @s[tag=do_tuto2] ~ ~ ~ 9
tellraw @s[tag=do_tuto2] {"rawtext": [{"translate": "tutorial.dialogue.subtitles2"}]}
event entity @s[tag=do_tuto2] hfrlc:tuto_cooldown
tag @s[tag=do_tuto2] remove do_tuto2


execute if entity @s[tag=do_tuto3] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto3] camera disabled
inputpermission set @s[tag=do_tuto3] movement disabled
tag @s[tag=do_tuto3] remove active_tuto2
tag @s[tag=do_tuto3] add active_tuto3
effect @s[tag=do_tuto3] blindness 1 255 true
tp @s[tag=do_tuto3] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto3] run summon hfrlc:guide_texts ~~-4~1 ~~ minecraft:entity_spawned "Mine gravel to get flint."
execute if entity @s[tag=do_tuto3] run structure load mystructure:gravel_test ~-3~-7~
stopsound @s[tag=do_tuto3] tutorial.dialogue.2
playsound tutorial.dialogue.3 @s[tag=do_tuto3] ~ ~ ~ 9
tellraw @s[tag=do_tuto3] {"rawtext": [{"translate": "tutorial.dialogue.subtitles3"}]}
inputpermission set @s[tag=do_tuto3] camera enabled
inputpermission set @s[tag=do_tuto3] movement enabled
tag @s[tag=do_tuto3] remove do_tuto3


execute if entity @s[tag=do_tuto4] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto4] camera disabled
inputpermission set @s[tag=do_tuto4] movement disabled
tag @s[tag=do_tuto4] remove active_tuto3
tag @s[tag=do_tuto4] add active_tuto4
give @s[tag=do_tuto4, hasitem={item=flint, quantity=0}] minecraft:flint
effect @s[tag=do_tuto4] blindness 1 255 true
tp @s[tag=do_tuto4] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto4] run summon hfrlc:guide_texts ~~-4~1 ~~ minecraft:entity_spawned "Strike stone with flint"
execute if entity @s[tag=do_tuto4] run summon hfrlc:guide_texts ~~-4.25~1 ~~ minecraft:entity_spawned "to get flint shards."
execute if entity @s[tag=do_tuto4] run structure load mystructure:stone_test ~-3~-7~
stopsound @s[tag=do_tuto4] tutorial.dialogue.3
playsound tutorial.dialogue.4 @s[tag=do_tuto4] ~ ~ ~ 9
tellraw @s[tag=do_tuto4] {"rawtext": [{"translate": "tutorial.dialogue.subtitles4"}]}
inputpermission set @s[tag=do_tuto4] camera enabled
inputpermission set @s[tag=do_tuto4] movement enabled
tag @s[tag=do_tuto4] remove do_tuto4


execute if entity @s[tag=do_tuto5] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto5] camera disabled
inputpermission set @s[tag=do_tuto5] movement disabled
clear @s[tag=do_tuto5, hasitem={item=hfrlc:flint_shard, quantity=0}] flint
give @s[tag=do_tuto5, hasitem={item=hfrlc:flint_shard, quantity=0}] hfrlc:flint_shard 3
tag @s[tag=do_tuto5] remove active_tuto4
tag @s[tag=do_tuto5] add active_tuto5
effect @s[tag=do_tuto5] blindness 1 255 true
tp @s[tag=do_tuto5] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto5] run summon hfrlc:guide_texts ~~-4.5~1 ~~ minecraft:entity_spawned "Break leaves to get sticks."
execute if entity @s[tag=do_tuto5] run structure load mystructure:leaves_test ~-3~-7~
stopsound @s[tag=do_tuto5] tutorial.dialogue.4
playsound tutorial.dialogue.5 @s[tag=do_tuto5] ~ ~ ~ 9
tellraw @s[tag=do_tuto5] {"rawtext": [{"translate": "tutorial.dialogue.subtitles5"}]}
inputpermission set @s[tag=do_tuto5] camera enabled
inputpermission set @s[tag=do_tuto5] movement enabled
tag @s[tag=do_tuto5] remove do_tuto5


execute if entity @s[tag=do_tuto6] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto6] camera disabled
inputpermission set @s[tag=do_tuto6] movement disabled
give @s[tag=do_tuto6, hasitem={item=minecraft:stick, quantity=0}] minecraft:stick 2
give @s[tag=do_tuto6, hasitem={item=minecraft:stick, quantity=1}] minecraft:stick 1
tag @s[tag=do_tuto6] remove active_tuto5
tag @s[tag=do_tuto6] add active_tuto6
effect @s[tag=do_tuto6] blindness 1 255 true
tp @s[tag=do_tuto6] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto6] run summon hfrlc:guide_texts ~~-4.25~1 ~~ minecraft:entity_spawned "Craft a Flint Knife in your inventory."
execute if entity @s[tag=do_tuto6] run structure load mystructure:flintDagger_test ~-3~-7~
stopsound @s[tag=do_tuto6] tutorial.dialogue.5
playsound tutorial.dialogue.6 @s[tag=do_tuto6] ~ ~ ~ 9
tellraw @s[tag=do_tuto6] {"rawtext": [{"translate": "tutorial.dialogue.subtitles6"}]}
inputpermission set @s[tag=do_tuto6] camera enabled
inputpermission set @s[tag=do_tuto6] movement enabled
tag @s[tag=do_tuto6] remove do_tuto6


execute if entity @s[tag=do_tuto7] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto7] camera disabled
inputpermission set @s[tag=do_tuto7] movement disabled
clear @s[tag=do_tuto7, hasitem={item=hfrlc:flint_dagger, quantity=0}] stick 0 1
clear @s[tag=do_tuto7, hasitem={item=hfrlc:flint_dagger, quantity=0}] hfrlc:flint_shard 0 1
give @s[tag=do_tuto7, hasitem={item=hfrlc:flint_dagger, quantity=0}] hfrlc:flint_dagger
tag @s[tag=do_tuto7] remove active_tuto6
tag @s[tag=do_tuto7] add active_tuto7
effect @s[tag=do_tuto7] blindness 1 255 true
tp @s[tag=do_tuto7] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto7] run summon hfrlc:guide_texts ~~-3.5~1 ~~ minecraft:entity_spawned "Use your Flint Knife to harvest"
execute if entity @s[tag=do_tuto7] run summon hfrlc:guide_texts ~~-3.75~1 ~~ minecraft:entity_spawned "3 plant fibers from grass,"
execute if entity @s[tag=do_tuto7] run summon hfrlc:guide_texts ~~-4~1 ~~ minecraft:entity_spawned "then craft a Fiber Rope in your inventory."
execute if entity @s[tag=do_tuto7] run structure load mystructure:tallgrass_test ~-3~-7~
stopsound @s[tag=do_tuto7] tutorial.dialogue.6
playsound tutorial.dialogue.7 @s[tag=do_tuto7] ~ ~ ~ 9
tellraw @s[tag=do_tuto7] {"rawtext": [{"translate": "tutorial.dialogue.subtitles7"}]}
inputpermission set @s[tag=do_tuto7] camera enabled
inputpermission set @s[tag=do_tuto7] movement enabled
tag @s[tag=do_tuto7] remove do_tuto7


execute if entity @s[tag=do_tuto8] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto8] camera disabled
inputpermission set @s[tag=do_tuto8] movement disabled
tag @s[tag=do_tuto8] remove active_tuto7
tag @s[tag=do_tuto8] add active_tuto8
effect @s[tag=do_tuto8] blindness 1 255 true
give @s[tag=do_tuto8, hasitem={item=stick, quantity=0}] stick 1
give @s[tag=do_tuto8, hasitem={item=hfrlc:plant_fibers_rope, quantity=0}] hfrlc:plant_fibers_rope 1
clear @s[tag=do_tuto8, hasitem={item=hfrlc:plant_fibers}] hfrlc:plant_fibers 0 3
tp @s[tag=do_tuto8] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto8] run summon hfrlc:guide_texts ~~-4.5~1 ~~ minecraft:entity_spawned "Craft a Flint Axe in your inventory."
execute if entity @s[tag=do_tuto8] run structure load mystructure:flintAxe_test ~-3~-7~
stopsound @s[tag=do_tuto8] tutorial.dialogue.7
playsound tutorial.dialogue.8 @s[tag=do_tuto8] ~ ~ ~ 9
tellraw @s[tag=do_tuto8] {"rawtext": [{"translate": "tutorial.dialogue.subtitles8"}]}
inputpermission set @s[tag=do_tuto8] camera enabled
inputpermission set @s[tag=do_tuto8] movement enabled
tag @s[tag=do_tuto8] remove do_tuto8


execute if entity @s[tag=do_tuto9] run event entity @e[r=15,family=guide] hfrlc:entity_death
give @s[tag=do_tuto9, hasitem={item=hfrlc:flint_axe, quantity=0}] hfrlc:flint_axe
inputpermission set @s[tag=do_tuto9] camera disabled
inputpermission set @s[tag=do_tuto9] movement disabled
tag @s[tag=do_tuto9] remove active_tuto7
tag @s[tag=do_tuto9] remove active_tuto8
tag @s[tag=do_tuto9] add active_tuto9
clear @s[tag=do_tuto9] hfrlc:plant_fibers_rope
clear @s[tag=do_tuto9] hfrlc:flint_shard
clear @s[tag=do_tuto9] minecraft:stick
effect @s[tag=do_tuto9] blindness 1 255 true
tp @s[tag=do_tuto9] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto9] run structure load mystructure:wood_test ~-3~-7~
stopsound @s[tag=do_tuto9] tutorial.dialogue.8
playsound tutorial.dialogue.9 @s[tag=do_tuto9] ~ ~ ~ 9
tellraw @s[tag=do_tuto9] {"rawtext": [{"translate": "tutorial.dialogue.subtitles9"}]}
inputpermission set @s[tag=do_tuto9] camera enabled
inputpermission set @s[tag=do_tuto9] movement enabled
tag @s[tag=do_tuto9] remove do_tuto9


execute if entity @s[tag=do_tuto10] run event entity @e[r=15,family=guide] hfrlc:entity_death
give @s[tag=do_tuto10, hasitem={item=hfrlc:flint_axe, quantity=0}] hfrlc:flint_axe
inputpermission set @s[tag=do_tuto10] camera disabled
inputpermission set @s[tag=do_tuto10] movement disabled
clear @s[tag=do_tuto10] oak_log
give @s[tag=do_tuto10] oak_log 3
tag @s[tag=do_tuto10] remove active_tuto9
tag @s[tag=do_tuto10] add active_tuto10
effect @s[tag=do_tuto10] blindness 1 255 true
tp @s[tag=do_tuto10] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto10] run summon hfrlc:guide_texts ~~-4~1 ~~ minecraft:entity_spawned "Craft a Wooden Pickaxe"
execute if entity @s[tag=do_tuto10] run structure load mystructure:wood_tools ~-3~-7~
stopsound @s[tag=do_tuto10] tutorial.dialogue.9
playsound tutorial.dialogue.10 @s[tag=do_tuto10] ~ ~ ~ 9
tellraw @s[tag=do_tuto10] {"rawtext": [{"translate": "tutorial.dialogue.subtitles10"}]}
inputpermission set @s[tag=do_tuto10] camera enabled
inputpermission set @s[tag=do_tuto10] movement enabled
tag @s[tag=do_tuto10] remove do_tuto10


execute if entity @s[tag=do_tuto11] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto11] camera disabled
inputpermission set @s[tag=do_tuto11] movement disabled
tag @s[tag=do_tuto11] remove active_tuto25
tag @s[tag=do_tuto11] add active_tuto11
effect @s[tag=do_tuto11] blindness 1 255 true
tag @s[tag=do_tuto11] add loop_stopMove
tp @s[tag=do_tuto11] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto11] run summon hfrlc:guide_texts ~~-3.5~1 ~~ minecraft:entity_spawned "Let's save your progress!"
execute if entity @s[tag=do_tuto11] run summon hfrlc:guide_texts ~~-3.75~1 ~~ minecraft:entity_spawned "Spawn points are random"
execute if entity @s[tag=do_tuto11] run summon hfrlc:guide_texts ~~-4~1~~ minecraft:entity_spawned "each time you respawn"
execute if entity @s[tag=do_tuto11] run summon hfrlc:guide_texts ~~-4.5~1 ~~ minecraft:entity_spawned "Unless you have a bed!"
execute if entity @s[tag=do_tuto11] run summon hfrlc:guide_texts ~~-4.75~1 ~~ minecraft:entity_spawned "Interact with the bed"
execute if entity @s[tag=do_tuto11] run summon hfrlc:guide_texts ~~-5~1 ~~ minecraft:entity_spawned "to set your Spawn Point."
execute if entity @s[tag=do_tuto11] run structure load mystructure:bed_test ~-3~-7~
stopsound @s[tag=do_tuto11] tutorial.dialogue.18
playsound tutorial.dialogue.19 @s[tag=do_tuto11] ~ ~ ~ 9
tellraw @s[tag=do_tuto11] {"rawtext": [{"translate": "tutorial.dialogue.subtitles19"}]}
inputpermission set @s[tag=do_tuto11] camera enabled
inputpermission set @s[tag=do_tuto11] movement enabled
tag @s[tag=do_tuto11] remove do_tuto11


execute if entity @s[tag=do_tuto12] run event entity @e[r=15,family=guide] hfrlc:entity_death
tag @s[tag=do_tuto12] remove desactive_temp
tag @s[tag=do_tuto12] add active_temp
title @s[tag=do_tuto12] title tempnormal_sphere;
title @s[tag=do_tuto12] subtitle thermometer_normal;
inputpermission set @s[tag=do_tuto12] camera disabled
inputpermission set @s[tag=do_tuto12] movement disabled
tag @s[tag=do_tuto12] remove active_tuto11
tag @s[tag=do_tuto12] add active_tuto12
effect @s[tag=do_tuto12] blindness 1 255 true
tag @s[tag=do_tuto12] add loop_stopMove
tp @s[tag=do_tuto12] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto12] run structure load mystructure:void_test ~-3~-7~
execute if entity @s[tag=do_tuto12] run summon hfrlc:temperature ~~-4.75~1 ~~
title @s[tag=do_tuto12] title tempnormal_sphere;
stopsound @s[tag=do_tuto12] tutorial.dialogue.19
playsound tutorial.dialogue.20 @s[tag=do_tuto12] ~ ~ ~ 9
tellraw @s[tag=do_tuto12] {"rawtext": [{"translate": "tutorial.dialogue.subtitles20"}]}
event entity @s[tag=do_tuto12] hfrlc:tuto_cooldown13
tag @s[tag=do_tuto12] remove do_tuto12


execute if entity @s[tag=do_tuto13] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto13] camera disabled
inputpermission set @s[tag=do_tuto13] movement disabled
tag @s[tag=do_tuto13] remove active_tuto12
tag @s[tag=do_tuto13] add active_tuto13
effect @s[tag=do_tuto13] blindness 1 255 true
tag @s[tag=do_tuto13] add loop_stopMove
tp @s[tag=do_tuto13] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto13] run summon hfrlc:guide_texts ~~-3.25~1 ~~ minecraft:entity_spawned "You're overheating!"
execute if entity @s[tag=do_tuto13] run summon hfrlc:guide_texts ~~-3.5~1 ~~ minecraft:entity_spawned "Jump into this water source to "
execute if entity @s[tag=do_tuto13] run summon hfrlc:guide_texts ~~-3.75~1~~ minecraft:entity_spawned "cool off!"
execute if entity @s[tag=do_tuto13] run structure load mystructure:water_test ~-3~-7~
stopsound @s[tag=do_tuto13] tutorial.dialogue.20
playsound tutorial.dialogue.21 @s[tag=do_tuto13] ~ ~ ~ 9
tellraw @s[tag=do_tuto13] {"rawtext": [{"translate": "tutorial.dialogue.subtitles21"}]}
inputpermission set @s[tag=do_tuto13] movement enabled
inputpermission set @s[tag=do_tuto13] camera enabled
tag @s[tag=do_tuto13] remove do_tuto13


execute if entity @s[tag=do_tuto14] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto14] camera disabled
inputpermission set @s[tag=do_tuto14] movement disabled
tag @s[tag=do_tuto14] remove active_tuto13
tag @s[tag=do_tuto14] add active_tuto14
effect @s[tag=do_tuto14] blindness 1 255 true
tag @s[tag=do_tuto14] add loop_stopMove
tp @s[tag=do_tuto14] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto14] run summon hfrlc:guide_texts ~~-3.25~1 ~~ minecraft:entity_spawned "You're freezing!"
execute if entity @s[tag=do_tuto14] run summon hfrlc:guide_texts ~~-3.5~1 ~~ minecraft:entity_spawned "Stay close to a heat source to warm up!"
execute if entity @s[tag=do_tuto14] run structure load mystructure:fire_test ~-3~-7~
stopsound @s[tag=do_tuto14] tutorial.dialogue.21
playsound tutorial.dialogue.22 @s[tag=do_tuto14] ~ ~ ~ 9
tellraw @s[tag=do_tuto14] {"rawtext": [{"translate": "tutorial.dialogue.subtitles22"}]}
inputpermission set @s[tag=do_tuto14] movement enabled
inputpermission set @s[tag=do_tuto14] camera enabled
tag @s[tag=do_tuto14] remove do_tuto14


execute if entity @s[tag=do_tuto16] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto16] camera disabled
inputpermission set @s[tag=do_tuto16] movement disabled
clear @s[tag=do_tuto16, hasitem={item=oak_log}] oak_log
clear @s[tag=do_tuto16, hasitem={item=stick}] stick
clear @s[tag=do_tuto16, hasitem={item=oak_planks}] oak_planks
give @s[tag=do_tuto16, hasitem={item=wooden_pickaxe, quantity=0}] wooden_pickaxe
tag @s[tag=do_tuto16] remove active_tuto10
tag @s[tag=do_tuto16] add active_tuto16
effect @s[tag=do_tuto16] blindness 1 255 true
tp @s[tag=do_tuto16] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto16] run summon hfrlc:guide_texts ~~-4~1 ~~ minecraft:entity_spawned "Hover over the Wooden Pickaxe's item"
execute if entity @s[tag=do_tuto16] run summon hfrlc:guide_texts ~~-4.25~1 ~~ minecraft:entity_spawned "description in your inventory or try using it."
execute if entity @s[tag=do_tuto16] run structure load mystructure:stone_tools ~-3~-7~-1
stopsound @s[tag=do_tuto16] tutorial.dialogue.10
playsound tutorial.dialogue.11 @s[tag=do_tuto16] ~ ~ ~ 9
tellraw @s[tag=do_tuto16] {"rawtext": [{"translate": "tutorial.dialogue.subtitles11"}]}
inputpermission set @s[tag=do_tuto16] camera enabled
inputpermission set @s[tag=do_tuto16] movement enabled
tag @s[tag=do_tuto16] remove do_tuto16


execute if entity @s[tag=do_tuto19] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto19] camera disabled
inputpermission set @s[tag=do_tuto19] movement disabled
tag @s[tag=do_tuto19] remove active_tuto16
tag @s[tag=do_tuto19] add active_tuto19
effect @s[tag=do_tuto19] blindness 1 255 true
tp @s[tag=do_tuto19] ~~-4~-3 0 5
tag @s[tag=do_tuto19] add active_do_tuto19
execute if entity @s[tag=do_tuto19] run summon hfrlc:guide_texts ~~-4~1 ~~ minecraft:entity_spawned "Kill Ants to get 6 levels of experience."
execute if entity @s[tag=do_tuto19] run structure load mystructure:void_test ~-3~-7~
execute if entity @s[tag=do_tuto19] run function summon_tuto_little_ant
stopsound @s[tag=do_tuto19] tutorial.dialogue.11
playsound tutorial.dialogue.12 @s[tag=do_tuto19] ~ ~ ~ 9
tellraw @s[tag=do_tuto19] {"rawtext": [{"translate": "tutorial.dialogue.subtitles12"}]}
inputpermission set @s[tag=do_tuto19] camera enabled
inputpermission set @s[tag=do_tuto19] movement enabled
tag @s[tag=do_tuto19] remove do_tuto19


tag @s[tag=do_tuto20] add system_level_item
execute if entity @s[tag=do_tuto20] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto20] camera disabled
inputpermission set @s[tag=do_tuto20] movement disabled
tag @s[tag=do_tuto20] remove active_tuto19
tag @s[tag=do_tuto20] add active_tuto20
tag @s[tag=do_tuto20] remove active_do_tuto19
effect @s[tag=do_tuto20] blindness 1 255 true
tp @s[tag=do_tuto20] ~~-4~-3 0 5
execute as @s[tag=do_tuto20] at @s run scriptevent "hfrlc:levelTuto"
execute if entity @s[tag=do_tuto20] run summon hfrlc:guide_texts ~~-3.5~1 ~~ minecraft:entity_spawned "Use the Level Up item on your hotbar"
execute if entity @s[tag=do_tuto20] run summon hfrlc:guide_texts ~~-3.75~1 ~~ minecraft:entity_spawned "to open the leveling menu and"
execute if entity @s[tag=do_tuto20] run summon hfrlc:guide_texts ~~-4~1 ~~ minecraft:entity_spawned "invest your experience into Mining"
execute if entity @s[tag=do_tuto20] run structure load mystructure:void_test ~-3~-7~
execute if entity @s[tag=do_tuto20] run summon hfrlc:system_level_item ~1~-4.5~1 ~~
execute if entity @s[tag=do_tuto20] run summon hfrlc:system_level_ui ~-0.35~-5~1 ~~
stopsound @s[tag=do_tuto20] tutorial.dialogue.12
playsound tutorial.dialogue.13 @s[tag=do_tuto20] ~ ~ ~ 9
tellraw @s[tag=do_tuto20] {"rawtext": [{"translate": "tutorial.dialogue.subtitles13"}]}
inputpermission set @s[tag=do_tuto20] camera enabled
inputpermission set @s[tag=do_tuto20] movement enabled
tag @s[tag=do_tuto20] remove do_tuto20


tag @s[tag=do_tuto22] remove tuto_openSystemLevel
tag @s[tag=do_tuto22] remove active_tuto20
execute if entity @s[tag=do_tuto22] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto22] camera disabled
inputpermission set @s[tag=do_tuto22] movement disabled
scoreboard players set @s[tag=do_tuto22] mining 3
event entity @s[tag=do_tuto22,has_property={hfrlc:mining_unlock=0}] agility_unlock
tag @s[tag=do_tuto22] remove active_tuto21
tag @s[tag=do_tuto22] remove active_tuto20
tag @s[tag=do_tuto22] add active_tuto22
tag @s[tag=do_tuto22] add only_level_mining
xp -6L @s[tag=do_tuto22]
tp @s[tag=do_tuto22] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto22] run summon hfrlc:guide_texts ~~-4~1~~ minecraft:entity_spawned "Try using your Wooden Pickaxe now!"
execute if entity @s[tag=do_tuto22] run structure load mystructure:zombie_test ~-3~-7~
stopsound @s[tag=do_tuto22] tutorial.dialogue.14
playsound tutorial.dialogue.15 @s[tag=do_tuto22] ~ ~ ~ 9
tellraw @s[tag=do_tuto22] {"rawtext": [{"translate": "tutorial.dialogue.subtitles15"}]}
inputpermission set @s[tag=do_tuto22] camera enabled
inputpermission set @s[tag=do_tuto22] movement enabled
tag @s[tag=do_tuto22] remove do_tuto22


execute if entity @s[tag=do_tuto23] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto23] camera disabled
inputpermission set @s[tag=do_tuto23] movement disabled
xp -6L @s[tag=do_tuto23]
tag @s[tag=do_tuto23] remove active_tuto22
tag @s[tag=do_tuto23] add active_tuto23
tag @s[tag=do_tuto23] add loop_stopMove
tp @s[tag=do_tuto23] ~~-4~-3 0 5
clear @s[tag=do_tuto23] log
clear @s[tag=do_tuto23] stick
clear @s[tag=do_tuto23] planks
clear @s[tag=do_tuto23] cobblestone
execute if entity @s[tag=do_tuto23] run structure load mystructure:black_test ~-3~-7~
stopsound @s[tag=do_tuto23] tutorial.dialogue.15
playsound tutorial.dialogue.16 @s[tag=do_tuto23] ~ ~ ~ 9
tellraw @s[tag=do_tuto23] {"rawtext": [{"translate": "tutorial.dialogue.subtitles16"}]}
event entity @s[tag=do_tuto23] hfrlc:tuto_cooldown23
tag @s[tag=do_tuto23] remove do_tuto23


execute if entity @s[tag=do_tuto24] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto24] camera disabled
inputpermission set @s[tag=do_tuto24] movement disabled
tag @s[tag=do_tuto24] remove active_tuto23
tag @s[tag=do_tuto24] add active_bodypart
tag @s[tag=do_tuto24] add active_tuto24
tag @s[tag=do_tuto24] add loop_stopMove
tp @s[tag=do_tuto24] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto24] run structure load mystructure:void_test ~-3~-7~
execute if entity @s[tag=do_tuto24] run summon hfrlc:bodyparts ~~-5.5~1 ~~
stopsound @s[tag=do_tuto24] tutorial.dialogue.16
playsound tutorial.dialogue.17 @s[tag=do_tuto24] ~ ~ ~ 9
tellraw @s[tag=do_tuto24] {"rawtext": [{"translate": "tutorial.dialogue.subtitles17"}]}
event entity @s[tag=do_tuto24] hfrlc:tuto_cooldown24
tag @s[tag=do_tuto24] remove do_tuto24


execute if entity @s[tag=do_tuto25] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto25] camera disabled
inputpermission set @s[tag=do_tuto25] movement disabled
tag @s[tag=do_tuto25] remove active_tuto24
tag @s[tag=do_tuto25] add active_tuto25
tp @s[tag=do_tuto25] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto25] run summon hfrlc:guide_texts ~~-3.75~1 ~~ minecraft:entity_spawned "Heal yourself with the bandages"
execute if entity @s[tag=do_tuto25] run summon hfrlc:guide_texts ~~-4~1 ~~ minecraft:entity_spawned "inside the chest."
execute if entity @s[tag=do_tuto25] run structure load mystructure:heal_chest_test ~-3~-7~
execute if entity @s[tag=do_tuto25] run summon hfrlc:heal_items ~~-4.25~1 ~~
stopsound @s[tag=do_tuto25] tutorial.dialogue.17
playsound tutorial.dialogue.18 @s[tag=do_tuto25] ~ ~ ~ 9
tellraw @s[tag=do_tuto25] {"rawtext": [{"translate": "tutorial.dialogue.subtitles18"}]}
inputpermission set @s[tag=do_tuto25] camera enabled
inputpermission set @s[tag=do_tuto25] movement enabled
tag @s[tag=do_tuto25] remove do_tuto25


execute if entity @s[tag=do_tuto26_2] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto26_2] camera disabled
inputpermission set @s[tag=do_tuto26_2] movement disabled
scoreboard players set @s[tag=do_tuto26_2] thermometer 6000
scoreboard players set @s[tag=do_tuto26_2] temperature 0
event entity @s[tag=do_tuto26_2] hfrlc:thermometer_normal
fill ~-5~-7~-3 ~5~-4~-3 air replace barrier
title @s[tag=do_tuto26_2] title tempnormal_sphere;
title @s[tag=do_tuto26_2] subtitle thermometer_normal;
tag @s[tag=do_tuto26_2] remove active_tuto14
tag @s[tag=do_tuto26_2] add active_tuto26_2
tp @s[tag=do_tuto] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto26_2] run summon hfrlc:guide_texts ~~-4~1 ~~ minecraft:entity_spawned "Grab the trinket from the chest."
execute if entity @s[tag=do_tuto26_2] run structure load mystructure:trinket_chest_test ~-3~-6~
execute if entity @s[tag=do_tuto26_2] run summon hfrlc:goat_horn ~~-4.25~1 ~~
stopsound @s[tag=do_tuto26_2] tutorial.dialogue.23
playsound tutorial.dialogue.24 @s[tag=do_tuto26_2] ~ ~ ~ 9
tellraw @s[tag=do_tuto26_2] {"rawtext": [{"translate": "tutorial.dialogue.subtitles24"}]}
inputpermission set @s[tag=do_tuto26_2] movement enabled
inputpermission set @s[tag=do_tuto26_2] camera enabled
tag @s[tag=do_tuto26_2] remove do_tuto26_2


execute if entity @s[tag=do_tuto27] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto27] camera disabled
inputpermission set @s[tag=do_tuto27] movement disabled
tag @s[tag=do_tuto27] remove active_tuto26_2
tag @s[tag=do_tuto27] add active_tuto27
tag @s[tag=do_tuto27] add trinket_item
tp @s[tag=do_tuto27] ~~-4~-3 0 5
give @s[tag=do_tuto27, hasitem={item=hfrlc:goat_horns, quantity=0}] hfrlc:goat_horns
execute if entity @s[tag=do_tuto27] run summon hfrlc:guide_texts ~~-4~1 ~~ minecraft:entity_spawned "Read the Goat Horns trinket lore"
execute if entity @s[tag=do_tuto27] run summon hfrlc:guide_texts ~~-4.25~1 ~~ minecraft:entity_spawned "and follow it's instructions."
execute if entity @s[tag=do_tuto27] run structure load mystructure:void_test ~-3~-7~
execute if entity @s[tag=do_tuto27] run summon hfrlc:trinket_ui ~-1.85~-4.6~1 ~~
execute if entity @s[tag=do_tuto27] run summon hfrlc:trinket_bag ~~-4.75~1 ~~
execute if entity @s[tag=do_tuto27] run summon hfrlc:trinket_lore ~1.5~-4.75~1 ~~
stopsound @s[tag=do_tuto27] tutorial.dialogue.24
playsound tutorial.dialogue.25 @s[tag=do_tuto27] ~ ~ ~ 9
tellraw @s[tag=do_tuto27] {"rawtext": [{"translate": "tutorial.dialogue.subtitles25"}]}
inputpermission set @s[tag=do_tuto27] camera enabled
inputpermission set @s[tag=do_tuto27] movement enabled
tag @s[tag=do_tuto27] remove do_tuto27


execute if entity @s[tag=do_tuto29] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto29] camera disabled
inputpermission set @s[tag=do_tuto29] movement disabled
tag @s[tag=do_tuto29] remove desactive_trinketItem
execute as @s[tag=do_tuto29, hasitem={item=hfrlc:goat_horns}] at @s run scriptevent "hfrlc:trinketMenuTuto"
clear @s[tag=do_tuto29, hasitem={item=hfrlc:goat_horns}] hfrlc:goat_horns
tag @s[tag=do_tuto29] remove desactive_thirst
tag @s[tag=do_tuto29] add active_thirts
tag @s[tag=do_tuto29] remove active_tuto27
tag @s[tag=do_tuto29] add active_tuto29
tp @s[tag=do_tuto29] ~~-4~-3 0 5
execute if entity @s[tag=do_tuto29] run summon hfrlc:guide_texts ~~-3.75~1 ~~ minecraft:entity_spawned "Grab something from the chest"
execute if entity @s[tag=do_tuto29] run summon hfrlc:guide_texts ~~-4~1 ~~ minecraft:entity_spawned "and replenish your thirst bar!"
execute if entity @s[tag=do_tuto29] run structure load mystructure:thirts_chest_test ~-3~-7~
execute if entity @s[tag=do_tuto29] run summon hfrlc:thirts_items ~~-4.5~1 ~~
scoreboard players set @s[tag=do_tuto29] thirst 29201
event entity @s[tag=do_tuto29] hfrlc:thirstbar19
stopsound @s[tag=do_tuto29] tutorial.dialogue.25
playsound tutorial.dialogue.26 @s[tag=do_tuto29] ~ ~ ~ 9
tellraw @s[tag=do_tuto29] {"rawtext": [{"translate": "tutorial.dialogue.subtitles26"}]}
inputpermission set @s[tag=do_tuto29] camera enabled
inputpermission set @s[tag=do_tuto29] movement enabled
tag @s[tag=do_tuto29] remove do_tuto29


execute if entity @s[tag=do_tuto31] run event entity @e[r=15,family=guide] hfrlc:entity_death
inputpermission set @s[tag=do_tuto31] camera disabled
tp @s[tag=do_tuto31] ~~-4~-3 0 5
tag @s[tag=do_tuto31] remove active_tuto29
tag @s[tag=do_tuto31] add active_tuto31
execute as @s[tag=do_tuto31] run time set day
inputpermission set @s[tag=do_tuto31] movement disabled
tag @s[tag=do_tuto31] add loop_stopMove
clear @s[tag=do_tuto31] cobblestone
scoreboard players set @s[tag=do_tuto31] thirst 37800
execute if entity @s[tag=do_tuto31] run structure load mystructure:black_test ~-3~-7~
stopsound @s[tag=do_tuto31] tutorial.dialogue.26
playsound tutorial.dialogue.27 @s[tag=do_tuto31] ~ ~ ~ 9
tellraw @s[tag=do_tuto31] {"rawtext": [{"translate": "tutorial.dialogue.subtitles27"}]}
event entity @s[tag=do_tuto31] hfrlc:tuto_cooldown31
tag @s[tag=do_tuto31] remove do_tuto31