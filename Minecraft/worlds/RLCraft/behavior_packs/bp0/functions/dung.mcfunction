execute if score dungeons settings matches 0 run setblock ~~~ air
execute if entity @e[type=hfrlc:dungeon,r=150] run setblock ~~~ air
execute unless score dungeons settings matches 0 unless entity @e[type=hfrlc:dungeon,r=150] run summon hfrlc:dungeon ~-7~~-7 ~~
scoreboard objectives add dungeon dummy
execute unless score dungeons settings matches 0 unless entity @e[type=hfrlc:dungeon,r=150] run tag @p add dungeon
scoreboard players set @e[type=hfrlc:dungeon,r=15] dungeon 0