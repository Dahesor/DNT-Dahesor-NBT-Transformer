tellraw @a [{"text":"[get_snbt_array_safe] Finished "},{"score":{"name":"#cases","objective":"dnt.asnbt.test"}},{"text":" batches, "},{"score":{"name":"#tests","objective":"dnt.asnbt.test"}},{"text":" tests, failures: "},{"score":{"name":"#failures","objective":"dnt.asnbt.test"}}]
stopwatch remove dnt:asnbt/test
scoreboard objectives remove calc.dnt
scoreboard objectives remove dnt.asnbt.test
data remove storage dnt:ram asnbt_test.state
