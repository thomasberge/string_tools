![](https://i.imgur.com/WVRc6JD.png)

A dart class with a set of functions for handling string operations. Does it get more exciting than that!?

<a href="https://www.buymeacoffee.com/thomasberge" target="_blank"><img src="https://i.imgur.com/aV6DDA7.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important; box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" > </a>

## Installing

Add string_tools to your pubspec.yaml file:

```yaml
dependencies:
  string_tools:
    git:
      url: https://github.com/thomasberge/string_tools.git
```

Import in dart file:

```dart
import 'package:string_tools/string_tools.dart';
```


## The Concept (+examples)
StringTools works as a text editor by having a cursor present on a single line of text. The cursor can be moved around, do selections, inserts, deletes, replace and more. You can also do sub-divisions based on cursor position - or on absolute position within the string.

You instantiate the tool as such:

```dart
StringTools stringtool = new StringTools("This is pretty handy and pretty awesome!");
```

In this case the stringtool.data has been set with the string "This is pretty handy and pretty awesome!". We can easily replace only the first "pretty" in the string with "quite" as such:

```dart
stringtool.moveTo("pretty");
stringtool.replaceCharacters("pretty".length, "quite");
```

With the selection function you can highlight a certain part of a string and do manipulation. Let's remove the parenthesis and its scandalous content:

```dart
StringTools stringtool = new StringTools("StringTools is quite useful(not really)!");

List<String> elems = [")", "("];
stringtool.moveToListElement(elems);
stringtool.startSelection();
stringtool.move();
stringtool.moveToListElement(elems);
stringtool.stopSelection();
stringtool.deleteSelection();
```

The order of the elements in the string doesn't matter. StringTools will find the first one and stop there. We start the selection at that position. In order to not find the same element again we `move()`, which basically increases position by 1. Then we find the next element, stop the selection and delete it. Handy!

"But what about nested parenthesis" you might think; well you can evaluate the element found by moveToListElement by catching its return value, as it returns the element it finds. The nesting logic you'll have to write yourself though.

There are a number of other usefull functions that will allow you to edit the string as if you were scripting a text editor.


## Functions

### countUntil
Counts forward from current cursor `position` until it finds the given `value`. 

Returns the absolute `position` of the first character of the `value`. If `relativePosition`
is true then it returns the character count relative to the current cursor `position`. 
If the value is not found it returns -1.

```dart
int countUntil(String value, {bool relativePosition = false})
```


### countCharacterSequenze    
Counts neighbouring `character` to the right of cursor `position`.

Only supports single `character` argument. If several string is provided only the first
character will be used.

```dart
int countCharacterSequenze(String character)
```


### move    
Moves the cursor `position` a certain number of `characters`. 

If it overshoots then the cursor `position` will be moved to the end of the string.

```dart
void move({int characters = 1})
```


### moveToEnd    
Moves the cursor position to the last character of the string.

```dart
void moveToEnd()
``` 


### insertAtPosition
Inserts `value` at the current cursor `position`. 

It expands the data as it does not replace any characters. If `cutOverflow` is true
then the data string will retain the same length, cutting characters that overflow.

```dart
void insertAtPosition(String value, {bool cutOverflow = false})
```


### replaceAtPosition    
Replace characters starting from current `position` with the supplied `value`. 

Can optionally be set to `cutOverflow`, maintaining the original width of the data.

```dart  
void replaceAtPosition(String value, {bool cutOverflow = false})
```


### replaceCharacters
Replaces a specific `character` from cursor `position` with `value`. 

Can optionally be set to `cutOverflow`, maintaining the original width of the data.

```dart
void replaceCharacters(int characters, String value, {bool cutOverflow = false})
```


### moveTo    
Moves the cursor `position` forward until either end of line or `value` is found.

Returns `true` if found and `false` if not.

```dart
bool moveTo(String value)
```


### moveBackwardsTo
Moves the cursor `position` backwards until start of line or `value` is found.

Returns `true` if found and `false` if not. The cursor `position` is set to the 
start of the found `value`.

```dart
bool moveBackwardsTo(String value) 
```


### getAllBeforePosition
Returns the all characters left of cursor `position`.

```dart
String getAllBeforePosition()
```


### getAllAfterPosition
Returns all the characters right of cursor `position`, excluding current cursor position.

```dart
String getAllAfterPosition()
```


### getAllFromPosition
Returns all character starting from cursor `position` and until the end of line.

```dart
String getAllFromPosition()
```


### getBeforePosition
Returns the character left of cursor `position`.

Can optionally define number of `characters` to return.

```dart
String getBeforePosition({int characters = 1})
```


### getAfterPosition
Returns the character to the right of cursor `position`.

Can optionally define number of `characters` to return.

```dart
String getAfterPosition({int characters = 1})
```


### getFromPosition
Returns the character from cursor `position`.

Can optionally define number of `characters` to return.

```dart
String getFromPosition({int characters = 1})
```


### moveToListElement
Moves cursor `position` until it finds any element in `values` and returns that element.

Reaching end of line returns a blank character.

```dart
String moveToListElement(List<String> values)
```


### deleteCharacters
Deletes a number of `characters`, starting with the cursor `position`.

```dart
void deleteCharacters(int characters)
```


### findPosition
Finds absolute position of the next occurance of `value` starting from cursor `position`. 

Returns `-1` if not present.

```dart
int findPosition(String value)
```


### startSelection
Sets the start of a selection from cursors `position`.

An optional `value` may set the selection start directly without relying on cursor `position`.

```dart
void startSelection({int? value = null})
```


### stopSelection
Sets the end of a selection from cursors `position`.

An optional `value` may set the selection end directly without relying on cursor `position`.

```dart
void stopSelection({int? value = null, bool end_of_string = false})
```


### getSelection
Returns the selected `string`. 

```dart
String getSelection()
```


### deleteSelection
Deletes the selected `string`.

```dart
void deleteSelection({bool reset_marks = true})
```


## Testing

There is a test script included in /test that runs all functions in different variations and tests against the result. A report is written to console where each function is graded with a `OK` or `Failed`. If changes are made to string_tools then new functions should be added and all functions tested again to make sure they pass.

The accompanying Dockerfile in this repo root can be run in order to run the test.

```bash
docker build -t string_tools_test . && docker run -it string_tools_test
```
