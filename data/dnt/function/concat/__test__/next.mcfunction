execute unless data storage dnt:zconcat_test state.cases[0] run return run function dnt:concat/__test__/finish
data modify storage dnt:zconcat_test state.case set from storage dnt:zconcat_test state.cases[0]
data remove storage dnt:zconcat_test state.cases[0]
scoreboard players set #char_fail dnt.concat.test 0
scoreboard players set #nbt_fail dnt.concat.test 0
scoreboard players set #concat_fail dnt.concat.test 0
schedule function dnt:concat/__test__/sample 1t replace
