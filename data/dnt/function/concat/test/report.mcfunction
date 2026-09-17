# Stopwatch readings are integer milliseconds (1 ms resolution).
# Batch totals include input preparation, output capture and loop overhead; exclude validation.
tellraw @a [{"nbt":"state.case.name","storage":"dnt:concat_test"},{"text":"§b|§r char: "},{"score":{"name":"#char_time","objective":"dnt.concat.test"},color:"yellow"},{"text":" §b|§r nbt: "},{"score":{"name":"#nbt_time","objective":"dnt.concat.test"},color:"yellow"},{"text":" §b|§r auto: "},{"score":{"name":"#concat_time","objective":"dnt.concat.test"},color:"yellow"}]
execute if score #char_fail dnt.concat.test matches 1.. run tellraw @a {"text":"  char: test failed","color":"red"}
execute if score #nbt_fail dnt.concat.test matches 1.. run tellraw @a {"text":"  nbt: test failed","color":"red"}
execute if score #concat_fail dnt.concat.test matches 1.. run tellraw @a {"text":"  auto: test failed","color":"red"}
scoreboard players operation #failures dnt.concat.test += #char_fail dnt.concat.test
scoreboard players operation #failures dnt.concat.test += #nbt_fail dnt.concat.test
scoreboard players operation #failures dnt.concat.test += #concat_fail dnt.concat.test
scoreboard players add #cases dnt.concat.test 1
schedule function dnt:concat/test/next 1t replace
