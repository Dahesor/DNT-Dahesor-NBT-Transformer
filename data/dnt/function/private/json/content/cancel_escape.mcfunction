#>dnt:private/json/content/cancel_escape
# @private within %parent/%parent

data modify storage dnt:ram result[-1] set value "'"
data modify storage dnt:ram out set value ""
function dnt:private/json/main