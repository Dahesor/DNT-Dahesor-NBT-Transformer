# Runs on a fresh tick if the converter or validator exhausted its command budget.
execute unless data storage dnt:ram asnbt_test.state{running:1b} run return 0
data modify storage dnt:ram asnbt_test.state.outputs set value [{result:0,value:"DNT TEST ERROR: COMMAND EXECUTION INTERRUPTED"}]
function dnt:private/asnbt/__test__/failure
tellraw @a {"text":"[get_snbt_array_safe] 单个用例执行被中断，请检查命令链上限和游戏日志；继续下一项。","color":"red"}
scoreboard players add #batch_fail dnt.asnbt.test 1
scoreboard players add #tests dnt.asnbt.test 1
data remove storage dnt:ram asnbt_test.state.pending[0]
data modify storage dnt:ram asnbt_test.state.outputs set value []
data remove storage dnt:ram asnbt
scoreboard objectives remove asnbt.dnt
function dnt:private/asnbt/__test__/continue
