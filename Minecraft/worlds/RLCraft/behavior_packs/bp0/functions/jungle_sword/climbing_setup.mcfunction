execute as @s[tag=!detected_air] run effect @s levitation 2 1 true
execute as @s[tag=!detected_air] run particle hfrlc:leafs ~~1~
tag @s remove detected_air