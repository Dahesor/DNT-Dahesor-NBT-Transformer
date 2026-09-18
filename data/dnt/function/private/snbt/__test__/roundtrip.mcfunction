data remove storage dnt:zsnbt_test state.parsed
execute if data storage dnt:zsnbt_test state.outputs[0].value run function dnt:private/snbt/__test__/parse with storage dnt:zsnbt_test state.outputs[0]
execute unless data storage dnt:zsnbt_test state.parsed run scoreboard players set #failed dnt.snbt.test 1
data modify storage dnt:zsnbt_test state.check set from storage dnt:zsnbt_test state.pending[0].input
execute store success score #changed dnt.snbt.test run data modify storage dnt:zsnbt_test state.check set from storage dnt:zsnbt_test state.parsed
execute if score #changed dnt.snbt.test matches 1 run scoreboard players set #failed dnt.snbt.test 1
