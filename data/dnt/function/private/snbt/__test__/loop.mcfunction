# Input preparation, return-value capture and loop overhead are included.
data remove storage dnt:ram in
data modify storage dnt:ram in set from storage dnt:zsnbt_test state.pending[0].input
data remove storage dnt:ram out
data modify storage dnt:zsnbt_test state.outputs append value {}
execute store result storage dnt:zsnbt_test state.outputs[-1].result int 1 run function dnt:get_snbt
data modify storage dnt:zsnbt_test state.outputs[-1].value set from storage dnt:ram out
data remove storage dnt:zsnbt_test state.pending[0]
execute if data storage dnt:zsnbt_test state.pending[0] run function dnt:private/snbt/__test__/loop
