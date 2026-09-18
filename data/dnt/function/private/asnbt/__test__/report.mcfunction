# Sum of per-input integer milliseconds; tick waits, validation and reporting excluded.
tellraw @a [{"nbt":"asnbt_test.state.case.name","storage":"dnt:ram"},{"text":" | get_snbt: "},{"score":{"name":"#time","objective":"dnt.asnbt.test"},"color":"yellow"},{"text":" ms | failures: "},{"score":{"name":"#batch_fail","objective":"dnt.asnbt.test"}}]
scoreboard players operation #failures dnt.asnbt.test += #batch_fail dnt.asnbt.test
scoreboard players add #cases dnt.asnbt.test 1
schedule function dnt:private/asnbt/__test__/next 1t replace
