# Copy the batch before timing. Measure one uninterrupted pass over all its inputs.
data modify storage dnt:zconcat_test state.pending set from storage dnt:zconcat_test state.case.tests
data modify storage dnt:zconcat_test state.outputs set value []
stopwatch restart dnt:concat/test
function dnt:concat/__test__/concat_loop
execute store result score #concat_time dnt.concat.test run stopwatch query dnt:concat/test 1000
# Validate only after the timer has been read.
data modify storage dnt:zconcat_test state.pending set from storage dnt:zconcat_test state.case.tests
scoreboard players set #batch_fail dnt.concat.test 0
function dnt:concat/__test__/validate
scoreboard players operation #concat_fail dnt.concat.test = #batch_fail dnt.concat.test
