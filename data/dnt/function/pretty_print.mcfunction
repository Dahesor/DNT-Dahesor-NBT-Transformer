#>@public dnt:pretty_print
# This function converts the input NBT into SNBT in the form of a pretty-printed string,
# with new lines and indentations.
# @input storage dnt:ram in
#   The NBT to pretty-print
# @input storage dnt:ram args[0]
#   *Optional*. The maximum indent for pretty-printing (default 12)
# @input storage dnt:ram args[1]
#   *Optional*. The indent space count (default 2)
# @writes storage dnt:ram out
#   The output string

execute unless data storage dnt:ram in run return run function dnt:private/snbt/no_input
scoreboard objectives remove calc.dnt
scoreboard objectives add calc.dnt dummy

scoreboard players set max_indent calc.dnt 12
scoreboard players set indent_space calc.dnt 2
execute if data storage dnt:ram args[0] store result score max_indent calc.dnt run data get storage dnt:ram args[0]
execute if data storage dnt:ram args[1] store result score indent_space calc.dnt run data get storage dnt:ram args[1]

execute summon text_display if function dnt:private/pretty_print/get_printed run return 1

data modify storage dnt:ram out set value "DNT ERROR: UNKNOWN ERROR"
return 0