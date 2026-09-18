# A missing output, failed parse, different NBT type/value or wrong return fails.
scoreboard players set #failed dnt.asnbt.test 0
execute unless data storage dnt:ram asnbt_test.state.outputs[0].value run scoreboard players set #failed dnt.asnbt.test 1
data modify storage dnt:ram asnbt_test.state.check set from storage dnt:ram asnbt_test.state.pending[0].result
execute store success score #changed dnt.asnbt.test run data modify storage dnt:ram asnbt_test.state.check set from storage dnt:ram asnbt_test.state.outputs[0].result
execute if score #changed dnt.asnbt.test matches 1 run scoreboard players set #failed dnt.asnbt.test 1
# Exact text assertions where the output spelling is fixed.
execute if data storage dnt:ram asnbt_test.state.pending[0].expected run function dnt:private/asnbt/__test__/exact
# Round-trip assertions preserve numeric types, list order, strings and nested tags.
execute if data storage dnt:ram asnbt_test.state.pending[0].input run function dnt:private/asnbt/__test__/roundtrip
execute if score #failed dnt.asnbt.test matches 1 run function dnt:private/asnbt/__test__/failure
scoreboard players operation #batch_fail dnt.asnbt.test += #failed dnt.asnbt.test
scoreboard players add #tests dnt.asnbt.test 1
data remove storage dnt:ram asnbt_test.state.pending[0]
data remove storage dnt:ram asnbt_test.state.outputs[0]
