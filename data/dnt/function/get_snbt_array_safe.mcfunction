#>@public dnt:get_snbt_array_safe
# This function converts the input NBT into SNBT in the form of a string.
# Minecraft truncates the representation of large arrays in SNBT, like `[I; 1,2,3,4,... 1024]` -> `[I; 1,2,3,4,...<...>]`.
# If this happens, the normal version of this function will terminate and call this safe function instead,
# which has the ability to handle large arrays without truncation.
# @input storage dnt:ram in
#   The NBT to convert
# @writes storage dnt:ram out
#   The output string

execute unless data storage dnt:ram in run return run function dnt:private/asnbt/no_input
data modify storage dnt:ram asnbt set value {parts:[],path:[],segments:[],stack:[],failed:0b}
data modify storage dnt:ram asnbt.source set from storage dnt:ram in
scoreboard objectives add asnbt.dnt dummy
execute summon text_display run function dnt:private/asnbt/get_parsed
execute unless data storage dnt:ram asnbt.tokens[0] run return run function dnt:private/asnbt/error
function dnt:private/asnbt/walk
execute if data storage dnt:ram asnbt{failed:1b} run return run function dnt:private/asnbt/error
data modify storage dnt:ram in set from storage dnt:ram asnbt.parts
function dnt:concat
scoreboard objectives remove asnbt.dnt
data remove storage dnt:ram asnbt
return 1
