# A missing output, failed parse, different NBT type/value or wrong return fails.
scoreboard players set #failed dnt.snbt.test 0
execute unless data storage dnt:zsnbt_test state.outputs[0].value run scoreboard players set #failed dnt.snbt.test 1
data modify storage dnt:zsnbt_test state.check set from storage dnt:zsnbt_test state.pending[0].result
execute store success score #changed dnt.snbt.test run data modify storage dnt:zsnbt_test state.check set from storage dnt:zsnbt_test state.outputs[0].result
execute if score #changed dnt.snbt.test matches 1 run scoreboard players set #failed dnt.snbt.test 1
# Exact text assertions where the output spelling is fixed.
execute if data storage dnt:zsnbt_test state.pending[0].expected run function dnt:private/snbt/__test__/exact
# Round-trip assertions preserve numeric types, list order, strings and nested tags.
execute if data storage dnt:zsnbt_test state.pending[0].input run function dnt:private/snbt/__test__/roundtrip
execute if score #failed dnt.snbt.test matches 1 run tellraw @a [{"text":"  FAIL: ","color":"red"},{"nbt":"state.pending[0].name","storage":"dnt:zsnbt_test"},{"text":"; output: "},{"nbt":"state.outputs[0]","storage":"dnt:zsnbt_test"}]
scoreboard players operation #batch_fail dnt.snbt.test += #failed dnt.snbt.test
scoreboard players add #tests dnt.snbt.test 1
data remove storage dnt:zsnbt_test state.pending[0]
data remove storage dnt:zsnbt_test state.outputs[0]
execute if data storage dnt:zsnbt_test state.pending[0] run function dnt:private/snbt/__test__/validate
