execute unless data storage dnt:ram asnbt_test.state.cases[0] run return run function dnt:private/asnbt/__test__/finish
data modify storage dnt:ram asnbt_test.state.case set from storage dnt:ram asnbt_test.state.cases[0]
data remove storage dnt:ram asnbt_test.state.cases[0]
schedule function dnt:private/asnbt/__test__/sample 1t replace
