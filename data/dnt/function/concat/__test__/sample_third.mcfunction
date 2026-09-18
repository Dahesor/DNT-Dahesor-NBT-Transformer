# One complete batch per tick; rotate all three implementations across cases.
# Each implementation sees identical inputs once. Shared macro caches are not cleared.
execute if score #order dnt.concat.test matches 0 run function dnt:concat/__test__/concat
execute if score #order dnt.concat.test matches 1 run function dnt:concat/__test__/char
execute if score #order dnt.concat.test matches 2 run function dnt:concat/__test__/nbt
scoreboard players add #order dnt.concat.test 1
execute if score #order dnt.concat.test matches 3 run scoreboard players set #order dnt.concat.test 0
function dnt:concat/__test__/report
