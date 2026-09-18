tellraw @a [{"text":"[concat] Finished "},{"score":{"name":"#cases","objective":"dnt.concat.test"}},{"text":" tests, failures: "},{"score":{"name":"#failures","objective":"dnt.concat.test"}}]
stopwatch remove dnt:concat/test
# The NBT implementation leaves its internal objective behind.
scoreboard objectives remove calc.dnt
scoreboard objectives remove dnt.concat.test
data remove storage dnt:zconcat_test state
