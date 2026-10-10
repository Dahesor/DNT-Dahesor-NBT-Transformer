#>dnt:private/json/key/end_quoted_single
# @private within %parent/%parent
scoreboard players set $quoted_end calc.dnt 1
data modify storage dnt:ram provided set value '"'
function dnt:private/json/insert_provided with storage dnt:ram
function dnt:private/json/main