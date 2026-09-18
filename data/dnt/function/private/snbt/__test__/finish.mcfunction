tellraw @a [{"text":"[get_snbt] Finished "},{"score":{"name":"#cases","objective":"dnt.snbt.test"}},{"text":" batches, "},{"score":{"name":"#tests","objective":"dnt.snbt.test"}},{"text":" tests, failures: "},{"score":{"name":"#failures","objective":"dnt.snbt.test"}}]
stopwatch remove dnt:snbt/test
scoreboard objectives remove calc.dnt
scoreboard objectives remove dnt.snbt.test
data remove storage dnt:zsnbt_test state
