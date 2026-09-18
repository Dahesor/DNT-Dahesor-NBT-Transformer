# Each input gets a fresh tick/command budget. Sum active conversion times only.
data modify storage dnt:ram asnbt_test.state.pending set from storage dnt:ram asnbt_test.state.case.tests
data modify storage dnt:ram asnbt_test.state.outputs set value []
scoreboard players set #time dnt.asnbt.test 0
scoreboard players set #batch_fail dnt.asnbt.test 0
schedule function dnt:private/asnbt/__test__/loop 1t replace
