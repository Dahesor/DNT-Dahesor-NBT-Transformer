#>@public dnt:concat/by_nbt_parse
# Concat the input list of strings into a single string.
# This will concat any quotation marks, backslashes, and any escape characters correctly.
# This is done with some text component and snbt formatting black magic
# One of the 2 methods
# @input storage dnt:ram in
#   The strings to concat
# @writes storage dnt:ram out
#   The output string


execute unless data storage dnt:ram in[] run return run function dnt:private/snbt/no_input
data modify storage dnt:ram out set value ""
scoreboard objectives remove calc.dnt
scoreboard objectives add calc.dnt dummy
data modify storage dnt:ram pcat_groups set value []

execute summon text_display run function dnt:private/pcat/auto

return 1

