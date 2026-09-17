scoreboard players operation $slash_count calc.dnt = $iteration calc.dnt
function dnt:private/concat/get_slash

data modify storage dnt:ram result set value []
function dnt:private/concat/initial_loop
data modify storage dnt:ram in set from storage dnt:ram result
function dnt:private/concat/layer_loop