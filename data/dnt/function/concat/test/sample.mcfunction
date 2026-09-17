# Run the first complete batch this tick, the other next tick, to separate command budgets.
# Never schedule inside a measured batch. Alternate method order across cases.
execute if score #order dnt.concat.test matches 0 run function dnt:concat/test/char
execute if score #order dnt.concat.test matches 1 run function dnt:concat/test/nbt
schedule function dnt:concat/test/sample_second 1t replace
