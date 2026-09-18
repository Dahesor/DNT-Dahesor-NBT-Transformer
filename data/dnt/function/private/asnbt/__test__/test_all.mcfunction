# Run with /function dnt:private/asnbt/__test__/test_all
# Uses dnt:ram as scratch space, like the public function and concat tests.
execute if data storage dnt:ram asnbt_test.state{running:1b} run tellraw @a {"text":"[get_snbt_array_safe] 清理上次测试状态，重新开始。","color":"yellow"}
schedule clear dnt:private/asnbt/__test__/next
schedule clear dnt:private/asnbt/__test__/sample
schedule clear dnt:private/asnbt/__test__/loop
schedule clear dnt:private/asnbt/__test__/watchdog
data remove storage dnt:ram asnbt
scoreboard objectives remove asnbt.dnt
stopwatch remove dnt:asnbt/test
scoreboard objectives add dnt.asnbt.test dummy
data modify storage dnt:ram asnbt_test.state set value {running:1b,cases:[]}
data modify storage dnt:ram asnbt_test.failures set value []
scoreboard players set #failures dnt.asnbt.test 0
scoreboard players set #cases dnt.asnbt.test 0
scoreboard players set #tests dnt.asnbt.test 0
stopwatch create dnt:asnbt/test
function dnt:private/asnbt/__test__/cases
# All six fixture functions must load; missing groups are test failures.
execute store result score #loaded dnt.asnbt.test run data get storage dnt:ram asnbt_test.state.cases
execute unless score #loaded dnt.asnbt.test matches 6 run tellraw @a {"text":"[get_snbt_array_safe] 用例加载不完整：应有 6 组，请检查游戏日志。","color":"red"}
execute unless score #loaded dnt.asnbt.test matches 6 run scoreboard players add #failures dnt.asnbt.test 1
execute unless score #loaded dnt.asnbt.test matches 6 run return run function dnt:private/asnbt/__test__/finish
tellraw @a {"text":"[get_snbt_array_safe] started","color":"aqua"}
function dnt:private/asnbt/__test__/next
