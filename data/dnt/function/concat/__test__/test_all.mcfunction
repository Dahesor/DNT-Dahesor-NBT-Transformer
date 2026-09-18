# Each case measures one continuous batch of distinct tests per implementation.
execute if data storage dnt:zconcat_test state{running:1b} run return run tellraw @a {"text":"[concat] 测试正在运行，请等待完成。","color":"yellow"}
scoreboard objectives add dnt.concat.test dummy
data modify storage dnt:zconcat_test state set value {running:1b,cases:[]}
scoreboard players set #failures dnt.concat.test 0
scoreboard players set #cases dnt.concat.test 0
scoreboard players set #order dnt.concat.test 0
stopwatch create dnt:concat/test
function dnt:concat/__test__/cases
execute store result score #selected dnt.concat.test run data get storage dnt:zconcat_test state.cases
tellraw @a [{"text":"[concat] started ","color":"aqua"},{"score":{"name":"#selected","objective":"dnt.concat.test"},"color":"aqua"},{"text":" tests","color":"aqua"}]
function dnt:concat/__test__/next
