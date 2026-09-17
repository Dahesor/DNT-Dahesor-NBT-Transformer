# We can deal with 256 segments at a time, so first we store anything longer in remainder
data modify storage dnt:ram pcat set value {raw:[],seg:[],remainder:[],count:0}
execute store result score $count calc.dnt run data get storage dnt:ram in
execute if score $count calc.dnt matches 257.. run function dnt:private/pcat/remainder

# First figure out the leading quotation mark
data modify storage dnt:ram in prepend value "!"
data modify entity @s text set value {storage:"dnt:ram",nbt:"in[]",plain:true,separator:""}
data modify storage dnt:ram pcat.raw append from entity @s text.extra[].extra[]

# Insert the invert quotation mark
function dnt:private/pcat/classify/make_segments

# Parse Again
function dnt:private/pcat/process/parse_again

# Count number of segments
execute store result score $count calc.dnt run data get storage dnt:ram pcat.seg

# Remove the head character (the quote inserted)
scoreboard players operation $this calc.dnt = $count calc.dnt
function dnt:private/pcat/process/remove_head

# Macro Concat
execute store result storage dnt:ram pcat.count int 1 run scoreboard players get $count calc.dnt
function dnt:private/pcat/concat/bin/main with storage dnt:ram pcat

# If we have a remainder, recursively process it
execute if data storage dnt:ram pcat.remainder[0] run return run function dnt:private/pcat/recursive
kill