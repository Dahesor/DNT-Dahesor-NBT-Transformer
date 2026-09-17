# One complete batch per tick; rotate all three implementations across cases.
# Each implementation sees identical inputs once. Shared macro caches are not cleared.
execute if score #order dnt.concat.test matches 0 run function dnt:concat/test/nbt
execute if score #order dnt.concat.test matches 1 run function dnt:concat/test/concat
execute if score #order dnt.concat.test matches 2 run function dnt:concat/test/char
schedule function dnt:concat/test/sample_third 1t replace
