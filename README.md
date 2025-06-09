# DNT (Dahesor's NBT Transformer)

This is a library that provides a couple tools to operate on snbt.

* **`function dnt:concat`**:\
    Takes the a list of strings from `storage dnt:ram in`, and output the contacted string in `storage dnt:ram out`\
    This will handles all the escape characters correctly, so `\`, `'`, or`"` will be contacted correctly.


* **`function dnt:concat_splited`**:\
    This is the later step of the normal `concat` function. It takes in a list of splited strings —— which has all the escape characters isolated —— and concat them.\
    The `concat` works by first re-construct the list:\
        [`"Hello"`,`" single ' quote"`,`" and \\ back slash"`]\
        into something `concat_splited` accepts:\
        [`"Hello single "`,`"'"`,`" quote and "`,`"\\"`,`" back slash"`]\
        then `concat_splited` concat it:\
        `"Hello single ' quote and \\ back slash"`


* **`function dnt:get_snbt`**:\
    Takes the nbt structure stored in `storage dnt:ram in`, output its snbt as a string in `storage dnt:ram out`


* **`function dnt:to_json`**:\
    Takes in a nbt compound or list and convert this structure into JSON, stored as a string in `storage dnt:ram out`. Escapes/newlines/strange key names are all accounted. `0b` and `1b` will be written as `true` and `false`.

**Example**:

Input:
```
{equipment:{mainhand:{id:"diamond",components:{"minecraft:item_name":{text:"what\"\"''ha>?",italic:true},"!attribute_modifiers":{},custom_data:{'Cool"\'\\Name':Yeah...}}}}}
```
Output:
```json
{"equipment":{"mainhand":{"components":{"!attribute_modifiers":{},"custom_data":{"Cool\"'\\Name":"Yeah..."},"minecraft:item_name":{"italic":true,"text":"what\"\"''ha>?"}},"id":"diamond"}}}
 ```

* **`function dnt:version`**:\
    Returns the version of this datapack. Also set `dnt:ram sys.pong__` to `true` so that other data packs can easily confirm that this pack is loaded.

This library will be updated if I had to make a new *transformer*.