# Each case measures one continuous batch of distinct tests per implementation.
execute if data storage dnt:concat_test state{running:1b} run return run tellraw @a {"text":"[concat] 测试正在运行，请等待完成。","color":"yellow"}
scoreboard objectives add dnt.concat.test dummy
data modify storage dnt:concat_test state set value {running:1b,cases:[]}
scoreboard players set #failures dnt.concat.test 0
scoreboard players set #cases dnt.concat.test 0
scoreboard players set #order dnt.concat.test 0
stopwatch create dnt:concat/test
function dnt:concat/test/cases
tellraw @a {"text":"[concat] 30 组，每组约 3k 字符；不同输入连续执行一次，不预热。显示整组耗时（1 ms 精度），包含输入恢复和结果保存，不含校验及 tick 等待。请勿同时调用其他 DNT 函数。","color":"aqua"}
function dnt:concat/test/next
