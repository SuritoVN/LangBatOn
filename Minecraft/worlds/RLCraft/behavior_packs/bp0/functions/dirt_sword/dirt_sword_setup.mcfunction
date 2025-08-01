tag @a remove dirt_sword
execute as @a if block ~~2~ air run tag @s add dirt_sword
execute as @a[tag=dirt_sword] run function dirt_sword/mountain
execute as @a[tag=!dirt_sword] run function dirt_sword/failure_dirt_sword