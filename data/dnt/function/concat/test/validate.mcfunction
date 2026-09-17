# Missing outputs fail; unchanged expected strings pass. Outside the measured interval.
data modify storage dnt:concat_test state.check set from storage dnt:concat_test state.pending[0].expected
scoreboard players set #changed dnt.concat.test 1
execute if data storage dnt:concat_test state.outputs[0].value store success score #changed dnt.concat.test run data modify storage dnt:concat_test state.check set from storage dnt:concat_test state.outputs[0].value
execute if score #changed dnt.concat.test matches 1 run scoreboard players add #batch_fail dnt.concat.test 1
data remove storage dnt:concat_test state.pending[0]
data remove storage dnt:concat_test state.outputs[0]
execute if data storage dnt:concat_test state.pending[0] run function dnt:concat/test/validate
