// StringTools
// https://github.com/thomasberge/string_tools
// © 2021 Thomas Sebastian Berge

library string_tools;

class StringTools {
  int position = 0;
  int width = 1;
  String data;
  int start_selection = 0;
  int stop_selection = 0;
  bool eol = false;

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
        String nextCharacter = getFromPosition();
        if (values.contains(nextCharacter)) {
          return nextCharacter;
        } else {
          move();
        }
      }
    }
  }

  /// Deletes a number of [characters], starting with the cursor [position].
  void deleteCharacters(int characters) {
    String first = data.substring(0, position);
    String last = data.substring(position + characters);
    data = first + last;
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
  void deleteSelection({bool reset_marks = true}) {
    if (stop_selection - start_selection > 0) {
      String first = data.substring(0, start_selection);
      String last = data.substring(stop_selection);
      data = first + last;
      if (position > start_selection && position < stop_selection) {
        position = start_selection;
      } else if (position > stop_selection) {
        position = position - (stop_selection - start_selection);
      }
      if (reset_marks) {
        start_selection = 0;
        stop_selection = 0;
      }
      _checkEndOfLine();
    } else {
      print("StringTools error, tried to delete marked length of 0 or less.");
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

  /// Check first and last
  void deleteEdges() {
    data = data.substring(1);
    data = data.substring(0, data.length-1);
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
      print("StringTools error, getQuotedString data contains more than two double quotes.");
      return("");
    }
  }

  /// Extract the string between the two supplied string arguments
  String getFromTo(String from, String to) {
    if(moveTo(from)) {
      move(characters: from.length);
      startSelection();
      if(moveTo(to)) {
        stopSelection();
        return getSelection();
      } else {
        print("StringTools error, getFromTo were unable to find 'to' value " + to + " in data.");
        return("");
      }
    } else {
      print("StringTools error, getFromTo were unable to find 'from' value " + from + " in data.");
      return("");
    }
  }  

  /// Delete the string between the two supplied string arguments
  void deleteFromTo(String from, String to) {
    if(moveTo(from)) {
      move(characters: from.length);
      startSelection();
      if(moveTo(to)) {
        stopSelection();
        deleteSelection();
      } else {
        print("StringTools error, deleteFromTo were unable to find 'to' value " + to + " in data.");
      }
    } else {
      print("StringTools error, deleteFromTo were unable to find 'from' value " + from + " in data.");
    }
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
}
