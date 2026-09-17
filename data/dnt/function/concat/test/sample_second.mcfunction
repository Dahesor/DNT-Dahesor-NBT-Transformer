execute if score #order dnt.concat.test matches 0 run function dnt:concat/test/nbt
execute if score #order dnt.concat.test matches 1 run function dnt:concat/test/char
scoreboard players add #order dnt.concat.test 1
execute if score #order dnt.concat.test matches 2 run scoreboard players set #order dnt.concat.test 0
function dnt:concat/test/report
