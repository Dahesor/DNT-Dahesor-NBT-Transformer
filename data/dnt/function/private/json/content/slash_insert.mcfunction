#>dnt:private/json/content/slash_insert
# @private within %parent/%parent

data modify storage dnt:ram result append from storage dnt:ram out
data modify storage dnt:ram result append value "\\"
data modify storage dnt:ram out set value ""