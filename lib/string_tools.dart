// StringTools
// https://github.com/thomasberge/string_tools
// © 2021 Thomas Sebastian Berge

library string_tools;
import 'dart:convert';

class CursorState {
  int position = 0;
  int width = 0;
  int start_selection = 0;
  int stop_selection = 0;
  bool eol = false;
}

class StringTools {
  int position = 0;
  int width = 1;
  var data = r"";
  int start_selection = 0;
  int stop_selection = 0;
  bool eol = false;

  CursorState _state = CursorState();

  StringTools(this.data);

  /// Counts forward from current cursor [position] until it finds the given [value].
  ///
  /// Returns the absolute [position] of the first character of the [value]. If [relativePosition]
  /// is true then it returns the character count relative to the current cursor [position].
  /// If the value is not found it returns -1.
  int countUntil(String value, {bool relativePosition = false}) {
    int old_position = position;
    bool value_not_found = true;

    while (value_not_found) {
      if ((position + value.length) > data.length) {
        return -1;
      } else {
        String string_sample =
            data.substring(position, (position + value.length));
        if (string_sample == value) {
          int found_position = position;
          position = old_position;
          if (relativePosition) {
            return found_position - position;
          } else {
            return found_position;
          }
        } else {
          position++;
          _checkEndOfLine();
        }
      }
    }
  }

  /// Counts neighbouring [character] to the right of cursor [position].
  ///
  /// Only supports single [character] argument. If several string is provided only the first
  /// character will be used.
  int countCharacterSequenze(String character) {
    character = character.substring(0, 1);
    int old_position = position;
    int count = 0;

    while (true) {
      if ((position + 1) > data.length) {
        position = old_position;
        return count;
      } else {
        String string_sample = data.substring(position, (position + 1));
        if (string_sample == character) {
          count++;
          position++;
        } else {
          position = old_position;
          return count;
        }
      }
    }
  }

  /// Moves the cursor [position] a certain number of [characters].
  ///
  /// If it overshoots then the cursor [position] will be moved to the end of the string.
  void move({int characters = 1}) {
    position = position + characters;
    _checkEndOfLine();
    if (eol) moveToEnd();
  }

  /// Moves the cursor position past the last character of the string.
  void moveToEnd() {
    if (data.length != 0) {
      position = data.length;
    }
  }

  /// Inserts [value] at the current cursor [position].
  ///
  /// It expands the data as it does not replace any characters. If [cutOverflow] is true
  /// then the data string will retain the same length, cutting characters that overflow.
  void insertAtPosition(String value, {bool cutOverflow = false}) {
    String first = data.substring(0, position);
    String last = data.substring(position);
    int original_length = data.length;

    data = first + value + last;

    if (cutOverflow == true) data = data.substring(0, original_length);
  }

  /// Replace characters starting from current [position] with the supplied [value].
  ///
  /// Can optionally be set to [cutOverflow], maintaining the original width of the data.
  void replaceAtPosition(String value, {bool cutOverflow = false}) {
    String first = data.substring(0, position);
    String last = "";
    int original_length = data.length;

    if ((position + value.length) < data.length)
      last = data.substring(position + value.length);

    data = first + value + last;

    if (cutOverflow == true) data = data.substring(0, original_length);
  }

  /// Replaces a specific [character] from cursor [position] with [value].
  ///
  /// Can optionally be set to [cutOverflow], maintaining the original width of the data.
  void replaceCharacters(int characters, String value,
      {bool cutOverflow = false}) {
    String first = data.substring(0, position);
    String last = data.substring(position + characters);
    int original_length = data.length;

    data = first + value + last;

    if (cutOverflow == true) data = data.substring(0, original_length);
  }

  ///  Moves the cursor [position] forward until either end of line or [value] is found.
  ///
  ///  Returns `true` if found and `false` if not.
  bool moveTo(String value) {
    bool not_found = true;
    while (not_found) {
      if ((position + value.length) > data.length) {
        return false;
      } else {
        String temp = data.substring(position, (position + value.length));
        if (temp == value) {
          return true;
        } else {
          position++;
          _checkEndOfLine();
        }
      }
    }
  }

  ///  Moves the cursor [position] forward until either end of line or [value] is found.
  ///
  ///  Returns `true` if found and `false` if not.
  bool moveToNext(String value) {
    move();
    return moveTo(value);
  }


  // MOCKUP - NOT YET DONE!!!! DOES NOT WORK! IF USED WORLDS WILL COLLIDE!
  bool moveBackwardsFromEndUntil(String value) {
    bool not_found = true;
    int previous_position = position;
    position = data.length - value.length;
    int width = value.length;

    print("Data: >" + data + "<");
    print("Position: " + position.toString());
    print("Width: " + width.toString());

    while (not_found) {
      position = data.length;
      if (position < previous_position) {
        position = previous_position;
        return false;
      }
      position--;
    }
  }

  /// Moves the cursor [position] backwards until start of line or [value] is found.
  ///
  /// Returns `true` if found and `false` if not. The cursor [position] is set to the
  /// start of the found [value].
  bool moveBackwardsTo(String value) {
    bool not_found = true;
    while (not_found) {
      if (position == 0) {
        return false;
      } else {
        if (getFromPosition(characters: value.length) == value) {
          return true;
        } else {
          if (position > -1) {
            position--;
          }
        }
      }
    }
  }

  /// Deletes all the characters left of cursor [position]. This resets any selection.
  void deleteAllBeforePosition() {
    data = getAllFromPosition();
    position = 0;
    start_selection = 0;
    stop_selection = 0;
  }

  /// Deletes all the characters right of cursor [position], excluding current cursor position.
  void deleteAllAfterPosition() {
    String temp = getAllBeforePosition() + getFromPosition();
    data = temp;
  }

  /// Returnss all character starting from cursor [position] and until the end of line.
  void deleteAllFromPosition() {
    data = getAllBeforePosition();
  }

  /// Returns the all characters left of cursor [position].
  String getAllBeforePosition() {
    return data.substring(0, position);
  }

  /// Returns all the characters right of cursor [position], excluding current cursor position.
  String getAllAfterPosition() {
    return data.substring(position + 1);
  }

  /// Returns all character starting from cursor [position] and until the end of line.
  String getAllFromPosition() {
    return data.substring(position);
  }

  /// Returns the character left of cursor [position].
  ///
  /// Can optionally define number of [characters] to return.
  String getBeforePosition({int characters = 1}) {
    if ((position - characters) < 0) {
      return "";
    } else {
      return data.substring(position - characters, position);
    }
  }

  /// Returns the character to the right of cursor [position].
  ///
  /// Can optionally define number of [characters] to return.
  String getAfterPosition({int characters = 1}) {
    _checkEndOfLine();
    if (eol) {
      return "";
    } else {
      {
        if (_checkOutOfBounds(characters)) {
          return "";
        } else {
          return data.substring(position + 1, position + 1 + characters);
        }
      }
    }
  }

  /// Returns the character from cursor [position].
  ///
  /// Can optionally define number of [characters] to return.
  String getFromPosition({int characters = 1}) {
    _checkEndOfLine();
    if (eol) {
      return "";
    } else {
      {
        if (_checkOutOfBounds(characters)) {
          return "";
        } else {
          return data.substring(position, position + characters);
        }
      }
    }
  }

  /// Moves cursor [position] until it finds any element in [values] and returns that element.
  ///
  /// Reaching end of line returns a blank character.
  String moveToListElement(List<String> values) {
    while (true) {
      _checkEndOfLine();
      if (eol) {
        return "";
      } else {
        for(String val in values){
          if(val == getFromPosition(characters: val.length)) {
            return val;
          }
        }
        move();
      }
    }
  }

  /// Deletes a number of [characters], starting with the cursor [position] unless fromPosition is provided.
  void deleteCharacters(int characters, {int fromPosition = -1}) {
    if(fromPosition > -1) {
      String first = data.substring(0, fromPosition);
      String last = data.substring(fromPosition + characters);
      data = first + last;
    } else {
      String first = data.substring(0, position);
      String last = data.substring(position + characters);
      data = first + last;
    }
  }

  /// Finds absolute position of the next occurance of [value] starting from cursor [position].
  ///
  /// Returns `-1` if not present.
  int findPosition(String value) {
    String read_data = data.substring(position, (data.length - position));
    int index = read_data.indexOf(value);
    if (index != -1) {
      return index + position;
    } else {
      return -1;
    }
  }

  /// Sets the start of a selection from cursors [position].
  ///
  /// An optional [value] may set the selection start directly without relying on cursor [position].
  void startSelection({int? value = null}) {
    if (value != null) {
      if (value <= (data.length - position)) {
        start_selection = value;
      } else {
        start_selection = data.length;
      }
    } else {
      start_selection = position;
    }
  }

  /// Sets the end of a selection from cursors [position].
  ///
  /// An optional [value] may set the selection end directly without relying on cursor [position].
  void stopSelection({int? value = null, bool end_of_string = false}) {
    if (value != null) {
      stop_selection = value;
    } else if (end_of_string) {
      stop_selection = data.length;
    } else {
      stop_selection = position;
    }
  }

  /// Returns the selected `string`.
  String getSelection() {
    if ((stop_selection - start_selection) > 0) {
      String test = data.substring(start_selection, stop_selection);
      return test;
    } else {
      return "";
    }
  }

  /// Deletes the selected `string`.
  void deleteSelection() {
    if (stop_selection - start_selection > 0) {
      String first = data.substring(0, start_selection);
      String last = data.substring(stop_selection);
      data = first + last;
      position = start_selection;
      _checkEndOfLine();
    } else if(stop_selection - start_selection == 0){
      // nothing to delete, move along
    } else {
      print("StringTools error, tried to delete a negative selection.\nstart:" + start_selection.toString() + " stop:" + stop_selection.toString());
    }
  }

  /// Check if first and last are the same as the supplied string
  bool edgesIs(String string) {
    if (data.substring(0, string.length) == string) {
      if(data.substring(data.length-string.length) == string) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// Check if first is the same as the supplied string
  bool firstIs(String string) {
    if (data.substring(0,string.length) == string) {
      return true;
    } else {
      return false;
    }
  }

  /// Check if last is the same as the supplied string
  bool lastIs(String string) {
    if (data.substring(data.length-string.length) == string) {
      return true;
    } else {
      return false;
    }
  } 

  /// Deletes first and last characters. Character moves 
  void deleteEdges({int characters: 1}) {
    int tempPosition = position;
    data = data.substring(characters);
    data = data.substring(0, data.length-characters);
    position = tempPosition - characters;
    if(position < 0) {
      position = 0;
    }
    _checkEndOfLine();
  }

  /// Extract one args from quotes
  String getQuotedString() {
    if(count('"') == 2) {
      position = 0;
      moveTo('"');
      move();
      startSelection();
      moveTo('"');
      stopSelection();
      return(getSelection());
    } else {
      print("StringTools error, getQuotedString data does not contain two double quotes: " + data.toString());
      return("");
    }
  }

  /// Selects the string between the current cursor position and until the supplied string argument
  void selectTo(String to, {bool ignoreEscape = false, bool includeArgument = false}) {
    startSelection();
    bool run = true;

    while(run) {
      if(moveTo(to)) {
        if(getBeforePosition() == '\\' && ignoreEscape) {
          move();
        } else {
          if(includeArgument) {
            move(characters: to.length);
          }
          stopSelection();
          run = false;
        }
      } else {
        print("StringTools error, selectTo were unable to find 'to' value " + to + " in data.");
        break;
      }
    }    
  }

  /// Selects the string between the two supplied string arguments
  void selectFromTo(String from, String to, {bool ignoreEscape = false, bool includeArguments = false}) {
    bool run = true;

    while(run) {
      if(moveTo(from)) {
        
        if(getBeforePosition() == '\\' && ignoreEscape) {
          move();
        } else {
          if(includeArguments == false) {
            move(characters: from.length);
          } else {
            move();
          }

          startSelection();
          run = false;
        }
      } else {
        print("StringTools error, selectFromTo were unable to find 'from' value " + from + " in data.");
        run = false;
        break;
      }
    }

    run = true;

    while(run) {
      if(moveTo(to)) {
        if(getBeforePosition() == '\\' && ignoreEscape) {
          move();
        } else {
          stopSelection();

          if(includeArguments) {
            start_selection = start_selection -1;
            stop_selection = stop_selection + to.length;
          }

          run = false;
        }
      } else {
        print("StringTools error, selectFromTo were unable to find 'to' value " + to + " in data.");
        run = false;
        break;
      }
    }    
  }

  /// Extract the string between the two supplied string arguments
  String getFromTo(String from, String to, {bool ignoreEscape = false, bool includeArguments = false}) {
    _saveState();
    selectFromTo(from, to, ignoreEscape: ignoreEscape, includeArguments: includeArguments);
    String temp = getSelection();
    _loadState();
    return temp;
  }


  String deleteFromTo(String from, String to, {bool ignoreEscape = false, bool includeArguments = false, bool deleteArguments = false}) {
    String string = "";

    if(includeArguments == false && deleteArguments) {
      selectFromTo(from, to, ignoreEscape: ignoreEscape, includeArguments: true);
      string = getSelection();
      string = string.substring(from.length, string.length - to.length);
    } else {
      selectFromTo(from, to, ignoreEscape: ignoreEscape, includeArguments: includeArguments);
      string = getSelection();
    }

    deleteSelection();
    return string;
  }

  /// Deletes the first and last character of the current selection
  void deleteEdgesOfSelection({int characters: 1}) {
    deleteCharacters(characters, fromPosition: start_selection);
    stop_selection = stop_selection - characters;
    deleteCharacters(characters, fromPosition: stop_selection - characters);
    stop_selection = stop_selection - characters;
  }

  /// Counts the occurance of the given string
  int count(String string) {
    int matches = 0;
    int pos = 0;
    while((pos + string.length) - 1 < data.length) {
      if(data.substring(pos, pos + string.length) == string) {
        matches++;
        pos = pos + string.length - 1;
      }
      pos++;
    }
    return matches;
    //return ((string.allMatches(data).length) / string.length).round();
  }

  /// Clears selection values and resets position to 0
  void reset() {
    start_selection = 0;
    stop_selection = 0;
    position = 0;
  }

  /// Replaces the selected string with the supplied argument. Selects the new string.
  void insertAtEdgesOfSelection(String first, String last) {
    position = start_selection;
    insertAtPosition(first);
    position = stop_selection + first.length;
    insertAtPosition(last);
    stop_selection = stop_selection + first.length + last.length;
  }

  /// 
  void replaceSelection(String string) {
    deleteSelection();
    insertAtPosition(string);
    stop_selection = start_selection + string.length;
  }

  ///  Moves the cursor [position] forward until either end of line or the selected string
  ///  matches the regular expressions. The test is done on a substring based on the width
  ///  argument.
  ///
  ///  Returns `true` if found and `false` if not.
  bool moveToRegex(RegExp exp, {int width = 1}) {
    bool not_found = true;
    while (not_found) {
      if ((position + width) > data.length) {
        return false;
      } else {
        String temp = data.substring(position, (position + width));
        if (exp.hasMatch(temp)) {
          return true;
        } else {
          position++;
          _checkEndOfLine();
        }
      }
    }
  }

  ///  Moves the cursor [position] forward until either end of line or the selected string
  ///  matches the regular expressions. The test is done on a substring based on the width
  ///  argument.
  ///
  ///  Returns `true` if found and `false` if not.
  void moveWhileRegex(RegExp exp, {int width = 1}) {
    bool found = true;
    while (found) {
      if ((position + width) > data.length) {
        found = false;
      } else {
        String temp = data.substring(position, (position + width));
        if (exp.hasMatch(temp)) {
          position++;
        } else {
          found = false;
          _checkEndOfLine();
        }
      }
    }
  }

  /// Checks if cursor position is past data boundary and sets eol (endOfLine) flag.
  void _checkEndOfLine() {
    if ((data.length) <= position) {
      eol = true;
    } else {
      eol = false;
    }
  }

  /// Returns true if current [position] + [characters] will put the position out of bounds.
  bool _checkOutOfBounds(int characters) {
    if (position + characters > data.length) {
      return true;
    } else {
      return false;
    }
  }

  // Saves the current state of the cursor
  void _saveState() {
    _state.position = position;
    _state.width = width;
    _state.start_selection = start_selection;
    _state.stop_selection = stop_selection;
    _state.eol = eol;
  }

  // Saves the current state of the cursor
  void _loadState() {
    position = _state.position;
    width = _state.width;
    start_selection = _state.start_selection;
    stop_selection = _state.stop_selection;
    eol = _state.eol;
  }
}