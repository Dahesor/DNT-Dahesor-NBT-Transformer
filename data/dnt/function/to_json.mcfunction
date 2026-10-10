#>@public dnt:to_json
# This function converts a NBT structure into the corresponding JSON structure as a string
# @context @any
# @input storage dnt:ram in
#   The input NBT structure
# @writes storage dnt:ram out
#   The result JSON as a string
# @returns `1` if the conversion was successful, `0` otherwise

execute unless data storage dnt:ram in run return run function dnt:private/snbt/no_input

function dnt:get_snbt

execute if data storage dnt:ram in[0] run return run function dnt:private/json/init
data modify storage dnt:ram in merge value {"dnt:test":1b}
execute if data storage dnt:ram in."dnt:test" run return run function dnt:private/json/init
return run data get storage dnt:ram out