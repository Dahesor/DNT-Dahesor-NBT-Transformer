tellraw @a [{"text":"[concat] 测试完成："},{"score":{"name":"#cases","objective":"dnt.concat.test"}},{"text":" 个案例，校验失败总次数："},{"score":{"name":"#failures","objective":"dnt.concat.test"}}]
stopwatch remove dnt:concat/test
# The NBT implementation leaves its internal objective behind.
scoreboard objectives remove calc.dnt
scoreboard objectives remove dnt.concat.test
data remove storage dnt:concat_test state
