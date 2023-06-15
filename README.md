![](https://i.imgur.com/WVRc6JD.png)

A dart class with a set of functions for handling string operations. Can it get more exciting than that!?

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
StringTools cursor = new StringTools("This is pretty handy and pretty awesome!");
```

In this case the cursor.data has been set with the string "This is pretty handy and pretty awesome!". We can easily replace only the first "pretty" in the string with "quite" as such:

```dart
cursor.moveTo("pretty");
cursor.replaceCharacters("pretty".length, "quite");
```

With the selection function you can highlight a certain part of a string and do manipulation. Let's remove the parenthesis and its scandalous content:

```dart
StringTools cursor = new StringTools("StringTools is quite useful(not really)!");

List<String> elems = [")", "("];
cursor.moveToListElement(elems);
cursor.startSelection();
cursor.next();
cursor.moveToListElement(elems);
cursor.stopSelection();
cursor.deleteSelection();
```

The order of the elements in the string doesn't matter. StringTools will find the first one and stop there. We start the selection at that position. In order to not find the same element again we `move()`, which basically increases position by 1. Then we find the next element, stop the selection and delete it. Handy!

"But what about nested parenthesis" you might think; well you can evaluate the element found by moveToListElement by catching its return value, as it returns the element it finds. The nesting logic you'll have to write yourself though.

There are a number of other usefull functions that will allow you to edit the string as if you were scripting a text editor.


## Function index

##### Move Cursor
- [next](#next)
- [back](#back)
- [home](#home)
- [end](#end)

##### Search
- [find](#find)
- [findNext](#movetonext)
- [findOneOf](#movetolistelement)
- [moveToRegex](#movetoregex)
- [moveWhileRegex](#movewhileregex)

##### Selection
- [startSelection](#startselection)
- [stopSelection](#stopselection)
- [selectFromTo](#selectfromto)
- [selectTo](#selectto)

##### Get
- [getAllAfterPosition](#getallafterposition)
- [getAllBeforePosition](#getallbeforeposition)
- [getAllFromPosition](#getallfromposition)
- [getAfterPosition](#getafterposition)
- [getBeforePosition](#getbeforeposition)
- [getFromPosition](#getfromposition)
- [getFromTo](#getfromto)
- [getQuotedString](#getquotedstring)
- [getSelection](#getselection)

##### Replace
- [replaceAtPosition](#replaceatposition)
- [replaceCharacters](#replacecharacters)
- [replaceSelection](#replaceselection)

##### Insert
- [insertAtEdgesOfSelection](#insertatposition)
- [insertAtPosition](#insertatposition)

##### Delete
- [deleteAllBeforePosition](#deleteallbeforeposition)
- [deleteAllAfterPosition](#deleteallafterposition)
- [deleteAllFromPosition](#deleteallfromposition)
- [deleteCharacters](#deletecharacters)
- [deleteEdges](#deleteedges)
- [deleteEdgesOfSelection](#deleteedgesofselection)
- [deleteFromTo](#deletefromto)
- [deleteSelection](#deleteselection)

##### General
- [countUntil](#countuntil)
- [countCharacterSequenze](#countcharactersequenze)
- [findPosition](#findposition)
- [edgesIs](#edgesis)
- [firstIs](#edgesis)
- [lastIs](#edgesis)
- [count](#count)
- [reset](#reset)


## Functions descriptions

### next
Advances the cursor `position` a certain number of `characters`. 

If it overshoots then the cursor `position` will be moved just past the last character of the string and the eol flag will be set.

```dart
void next({int characters = 1})
```
[top](#move cursor)

### back
Moves the cursor `position` back a certain number of `characters`. 

If it overshoots then the cursor `position` will be moved to the first character of the string.

```dart
void back({int characters = 1})
```
[top](#move cursor)

### home
Moves the cursor position to the start of the string.

```dart
void home()
``` 
[top](#move cursor)

### end
Moves the cursor position just past the last character of the string and sets the eol flag.

```dart
void end()
``` 
[top](#move cursor)

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


### insertAtPosition
Inserts `value` at the current cursor `position`. 

It expands the data as it does not replace any characters. If `cutOverflow` is true
then the data string will retain the same length, cutting characters that overflow.

```dart
void insertAtPosition(String value, {bool cutOverflow = false})
```


### insertAtEdgesOfSelection
Inserts the two strings `first` and `last` at the first and last position of the selection. 

```dart
void insertAtEdgesOfSelection(String first, String last)
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


### find
Advances the cursor `position` forward until either end of line or `value` is found.

Returns `true` if found and `false` if not.

```dart
bool find(String value {bool reverse = false})
```
[top](#search)

### findNext
Moves the cursor `position` forward until either end of line or `value` is found.

Returns `true` if found and `false` if not.

```dart
bool moveTo(String value)
```
[top](#search)

### getAllBeforePosition
Returns all the characters left of cursor `position`.

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

### deleteAllBeforePosition
Deletes all the characters left of cursor `position`.

```dart
String getAllBeforePosition()
```


### deleteAllAfterPosition
Deletes all the characters right of cursor `position`, excluding current cursor position.

```dart
String getAllAfterPosition()
```


### deleteAllFromPosition
Deletes all character starting from cursor `position` and until the end of line.

```dart
String getAllFromPosition()
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
Deletes the selected `string`. The cursor `position` is set to the start location of the selection after it has been deleted.

```dart
void deleteSelection()
```

### edgesIs
Checks that the first and last string of the data object is the same as the supplied String.

```dart
bool edgesIs(String string)
```

### firstIs
Checks that the first characters of the data object is the same as the supplied String.

```dart
bool firstIs(String character)
```

### lastIs
Checks that the last characters of the data object is the same as the supplied String.

```dart
bool lastIs(String character)
```

### deleteEdges
Deletes the first and last character of the data object.

```dart
void deleteEdges()
```

### count
Returns the count of occurances of the argument within the data object. It does not count overlap, meaning looking for the string argument "aaa" in the data object "aaaa" will return 1, not 2.

```dart
int count(String argument)
```

### getQuotedString
If the data object contain two double quotes then this function will return the String within the quotes.

```dart
String getQuotedString()
```

### selectTo
Selects the string from cursor `position` and to the supplied string argument. If `ignoreEscape` is set to `True` then the `to` value will not be detected if it has a backslack \ as prefix. If `includeArgument` is set to `True` then the function will also select the detected argument.

```dart
void selectTo(String from, String to, {bool ignoreEscape = false, bool includeArgument = false})
```

### selectFromTo
Selects the string between the two supplied string arguments. If `ignoreEscape` is set to `True` then the `from` and `to` value will not be detected if it has a backslack \ as prefix. If `includeArguments` are set to `True` then the function will also select the detected argument.

```dart
void selectFromTo(String from, String to, {bool ignoreEscape = false, bool includeArguments = false})
```

### getFromTo
Extract the string between the two supplied string arguments. If `ignoreEscape` is set to `True` then the `from` and `to` value will not be detected if it has a backslack \ as prefix. If `includeArguments` are set to `True` then the function will also select the detected argument.

```dart
String getFromTo(String from, String to, {bool ignoreEscape = false, bool includeArguments = false})
```

### deleteFromTo
Delete the string between the two supplied string arguments and returns the deleted value. If the optional deleteArguments is set to `True` then the supplied arguments will also be deleted, even if the function is not set to includeArguments. If includeArguments is set to `True` then it will both return and delete the arguments. If `ignoreEscape` is set to `True` then the `from` and `to` value will not be detected if it has a backslack \ as prefix. 

```dart
String deleteFromTo(String from, String to, { bool ignoreEscape = false, bool includeArguments = false, bool deleteArguments = false })
```

### reset
Clears selection and resets position to 0. Does not clear the data.

```dart
void reset()
```

### replaceSelection
Replaces the selected text with the supplied argument. The new text will be selected.

```dart
void replaceSelection(String argument)
```

### deleteEdgesOfSelection
Deletes the first and last character of the selected text. Adjusts the selection.

```dart
void replaceSelection(String argument)
```

### moveToRegex
Moves the cursor until it hits a character or word that matches the supplied regular expression argument or until end of line. ```True``` will be returned if it finds a match and ```False``` if it reaches end of line without any match. The width of characters to test on default to 1 (single character) but can be overridden with the named ```width``` argument.

```dart
bool moveToRegex(RegExp expression, {int width = 1})
```

### moveWhileRegex
Moves the cursor while the characters in the supplied regular expression matches. Will stop at the first non-match string or at the end of line. The width being tested defaults to 1 but can be overridden.

```dart
void moveWhileRegex(RegExp expression, {int width = 1})
```

## Testing

There is a test script included in /test that runs all functions in different variations and tests against the result. A report is written to console where each function is graded with a `OK` or `Failed`. If changes are made to string_tools then new functions should be added and all functions tested again to make sure they pass.

The accompanying Dockerfile in this repo root can be run in order to run the test.

```bash
docker build -t string_tools_test . && docker run -it string_tools_test
```
