execute unless data storage dnt:concat_test state.cases[0] run return run function dnt:concat/test/finish
data modify storage dnt:concat_test state.case set from storage dnt:concat_test state.cases[0]
data remove storage dnt:concat_test state.cases[0]
scoreboard players set #char_fail dnt.concat.test 0
scoreboard players set #nbt_fail dnt.concat.test 0
scoreboard players set #concat_fail dnt.concat.test 0
schedule function dnt:concat/test/sample 1t replace
