scoreboard objectives add random dummy
scoreboard players random @s random 1 3
execute as @s[scores={random=1}] run summon minecraft:lightning_bolt ^^^2.5
execute as @s[scores={random=2}] run summon minecraft:lightning_bolt ^^^4
execute as @s[scores={random=3}] run summon minecraft:lightning_bolt ^^^12