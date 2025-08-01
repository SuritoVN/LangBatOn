execute if score skyspires settings matches 0 run setblock ~~~ air
execute if entity @e[type=hfrlc:boss_tower,r=150] run setblock ~~~ air
scoreboard objectives add boss_tower dummy
execute unless score skyspires settings matches 0 unless entity @e[type=hfrlc:boss_tower,r=150] run summon hfrlc:boss_tower ~~~ ~~
scoreboard players set @e[type=hfrlc:boss_tower,r=15] boss_tower 0