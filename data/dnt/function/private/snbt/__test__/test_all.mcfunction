# Run with /function dnt:private/snbt/__test__/test_all
# Uses dnt:ram as scratch space, like the public function and concat tests.
execute if data storage dnt:zsnbt_test state{running:1b} run return run tellraw @a {"text":"[get_snbt] 测试正在运行，请等待完成。","color":"yellow"}
scoreboard objectives add dnt.snbt.test dummy
data modify storage dnt:zsnbt_test state set value {running:1b,cases:[]}
scoreboard players set #failures dnt.snbt.test 0
scoreboard players set #cases dnt.snbt.test 0
scoreboard players set #tests dnt.snbt.test 0
stopwatch create dnt:snbt/test
function dnt:private/snbt/__test__/cases
# All five fixture functions must load; missing groups are test failures.
execute store result score #loaded dnt.snbt.test run data get storage dnt:zsnbt_test state.cases
tellraw @a {"text":"[get_snbt] started","color":"aqua"}
function dnt:private/snbt/__test__/next
