# One complete batch per tick; rotate all three implementations across cases.
# Each implementation sees identical inputs once. Shared macro caches are not cleared.
execute if score #order dnt.concat.test matches 0 run function dnt:concat/test/char
execute if score #order dnt.concat.test matches 1 run function dnt:concat/test/nbt
execute if score #order dnt.concat.test matches 2 run function dnt:concat/test/concat
schedule function dnt:concat/test/sample_second 1t replace
