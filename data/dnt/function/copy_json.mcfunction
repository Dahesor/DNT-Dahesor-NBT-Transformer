data modify storage dnt:ram temp set value {text:"Copy",underlined:true,click_event:{action:"copy_to_clipboard",value:""}}
data modify storage dnt:ram temp.click_event.value set from storage dnt:ram out
tellraw @a {storage:"dnt:ram",nbt:"temp",interpret:true}
data remove storage dnt:ram temp