# Array-safe SNBT tests

Run `/function dnt:private/asnbt/__test__/test_all` after reloading the pack.
The six groups include baseline SNBT fixtures and dedicated truncated-array path
regressions. The runner compares parsed output NBT with the original value,
including numeric types, and checks return values and missing input.
Full failures remain in `storage dnt:ram asnbt_test.failures`; chat only shows names.

Large inputs and batches may require a higher `maxCommandChainLength`, as with
other recursive conversion functions in this library.

`verify_asnbt.java` is an offline verifier using the installed Minecraft jar and its
matching libraries on the Java classpath. Run it with Java 25 and the repository
root as its argument. It interprets the new mcfunction files using the game's
actual NBT parser, NBT path operations, and text component visitor. It substitutes
literal concatenation for the existing `dnt:concat`, so it does not replace an
in-game integration run or enforce the game's command-chain limit.

Each input runs on a separate tick. Calling test_all restarts the suite, including
when an earlier run was interrupted. A watchdog records interrupted inputs as
failures and advances to the next input instead of leaving a permanent running flag.
