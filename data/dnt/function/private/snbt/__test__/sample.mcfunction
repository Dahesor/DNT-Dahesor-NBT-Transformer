# Time one uninterrupted batch; validate after reading the stopwatch.
data modify storage dnt:zsnbt_test state.pending set from storage dnt:zsnbt_test state.case.tests
data modify storage dnt:zsnbt_test state.outputs set value []
stopwatch restart dnt:snbt/test
function dnt:private/snbt/__test__/loop
execute store result score #time dnt.snbt.test run stopwatch query dnt:snbt/test 1000
data modify storage dnt:zsnbt_test state.pending set from storage dnt:zsnbt_test state.case.tests
scoreboard players set #batch_fail dnt.snbt.test 0
function dnt:private/snbt/__test__/validate
function dnt:private/snbt/__test__/report
