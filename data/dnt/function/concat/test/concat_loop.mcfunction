# Per-input preparation and output capture are included in the batch time.
data modify storage dnt:ram in set from storage dnt:concat_test state.pending[0].input
data remove storage dnt:ram out
function dnt:concat
data modify storage dnt:concat_test state.outputs append value {}
data modify storage dnt:concat_test state.outputs[-1].value set from storage dnt:ram out
data remove storage dnt:concat_test state.pending[0]
execute if data storage dnt:concat_test state.pending[0] run function dnt:concat/test/concat_loop
