# Preserve full failures in storage; do not send oversized NBT strings in chat.
data modify storage dnt:ram asnbt_test.failures append value {}
data modify storage dnt:ram asnbt_test.failures[-1].test set from storage dnt:ram asnbt_test.state.pending[0]
data modify storage dnt:ram asnbt_test.failures[-1].output set from storage dnt:ram asnbt_test.state.outputs[0]
tellraw @a [{"text":"  FAIL: ","color":"red"},{"nbt":"asnbt_test.state.pending[0].name","storage":"dnt:ram"},{"text":" (details: storage dnt:ram asnbt_test.failures)"}]
