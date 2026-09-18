# Integer milliseconds; validation and reporting are excluded.
tellraw @a [{"nbt":"state.case.name","storage":"dnt:zsnbt_test"},{"text":" | get_snbt: "},{"score":{"name":"#time","objective":"dnt.snbt.test"},"color":"yellow"},{"text":" ms | failures: "},{"score":{"name":"#batch_fail","objective":"dnt.snbt.test"}}]
scoreboard players operation #failures dnt.snbt.test += #batch_fail dnt.snbt.test
scoreboard players add #cases dnt.snbt.test 1
schedule function dnt:private/snbt/__test__/next 1t replace
