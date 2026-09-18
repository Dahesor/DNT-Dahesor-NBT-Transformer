# Arm recovery before running anything that could exhaust the command budget.
schedule function dnt:private/asnbt/__test__/watchdog 2t replace
stopwatch restart dnt:asnbt/test
data remove storage dnt:ram in
data modify storage dnt:ram in set from storage dnt:ram asnbt_test.state.pending[0].input
data remove storage dnt:ram out
data modify storage dnt:ram asnbt_test.state.outputs append value {}
execute store result storage dnt:ram asnbt_test.state.outputs[-1].result int 1 run function dnt:get_snbt_array_safe
data modify storage dnt:ram asnbt_test.state.outputs[-1].value set from storage dnt:ram out
execute store result score #elapsed dnt.asnbt.test run stopwatch query dnt:asnbt/test 1000
scoreboard players operation #time dnt.asnbt.test += #elapsed dnt.asnbt.test
function dnt:private/asnbt/__test__/validate
schedule clear dnt:private/asnbt/__test__/watchdog
function dnt:private/asnbt/__test__/continue
