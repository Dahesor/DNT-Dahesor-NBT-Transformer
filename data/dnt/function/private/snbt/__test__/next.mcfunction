execute unless data storage dnt:zsnbt_test state.cases[0] run return run function dnt:private/snbt/__test__/finish
data modify storage dnt:zsnbt_test state.case set from storage dnt:zsnbt_test state.cases[0]
data remove storage dnt:zsnbt_test state.cases[0]
schedule function dnt:private/snbt/__test__/sample 1t replace
