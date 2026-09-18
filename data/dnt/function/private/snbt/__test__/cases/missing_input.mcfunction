# No input field: the loop removes any previous input before this call.
data modify storage dnt:zsnbt_test state.cases append value {name:"missing_input",tests:[{name:"missing_input",result:0,expected:"DNT ERROR: INVALID INPUT"}]}
