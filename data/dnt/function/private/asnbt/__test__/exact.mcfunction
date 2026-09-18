data modify storage dnt:ram asnbt_test.state.check set from storage dnt:ram asnbt_test.state.pending[0].expected
execute store success score #changed dnt.asnbt.test run data modify storage dnt:ram asnbt_test.state.check set from storage dnt:ram asnbt_test.state.outputs[0].value
execute if score #changed dnt.asnbt.test matches 1 run scoreboard players set #failed dnt.asnbt.test 1
