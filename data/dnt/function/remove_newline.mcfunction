#>@public dnt:remove_newline
# This function removes all new line characters from the input list, then concat it.
# @input storage dnt:ram in
#   The list of strings to operate
# @writes storage dnt:ram out
#   The output string

execute unless data storage dnt:ram in run return run function dnt:private/snbt/no_input
scoreboard objectives remove calc.dnt
scoreboard objectives add calc.dnt dummy
scoreboard players set $process calc.dnt 1
function dnt:private/split/setup

data modify storage dnt:ram in set from storage dnt:ram result
function dnt:concat_splited
return 1