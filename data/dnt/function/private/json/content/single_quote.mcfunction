#>dnt:private/json/content/single_quote
# @private within %parent/%parent

data modify storage dnt:ram result append from storage dnt:ram out
data modify storage dnt:ram result append value "'"
data modify storage dnt:ram out set value ""
function dnt:private/json/main