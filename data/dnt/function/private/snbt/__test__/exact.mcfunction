data modify storage dnt:zsnbt_test state.check set from storage dnt:zsnbt_test state.pending[0].expected
execute store success score #changed dnt.snbt.test run data modify storage dnt:zsnbt_test state.check set from storage dnt:zsnbt_test state.outputs[0].value
execute if score #changed dnt.snbt.test matches 1 run scoreboard players set #failed dnt.snbt.test 1
