#>@public dnt:get_snbt
# This function converts the input NBT into SNBT in the form of a string
# @input storage dnt:ram in
#   The NBT to convert
# @writes storage dnt:ram out
#   The output string

execute unless data storage dnt:ram in run return run function dnt:private/snbt/no_input
data modify storage dnt:ram backup set from storage dnt:ram in
scoreboard objectives remove calc.dnt
scoreboard objectives add calc.dnt dummy
execute summon text_display if function dnt:private/snbt/get_parsed run return 1

data modify storage dnt:ram out set value "DNT ERROR: UNKNOWN ERROR"
return 0