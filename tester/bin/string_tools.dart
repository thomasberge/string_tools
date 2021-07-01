// StringTools
// https://github.com/thomasberge/string_tools
// © 2021 Thomas Sebastian Berge

class StringTools {

  int position = 0;
  int width = 1;
  String data;
  int start_selection = 0;
  int stop_selection = 0;
  bool eol = false;

  StringTools(this.data);

/*  
  Counts forward from current cursor position until it finds the given value. Returns the 
  absolute position of the first character of the value string. If the optional argument
  relativePosition is true then it returns the character count relative to the current
  cursor position. If the value is not found it returns -1.

  Example     "I am a string"
  
  With a position of 0, countUntil('a') returns 2.
  With a position of 3, countUntil('a') returns 5.
  With a position of 3, countUntil('a', relativePosition: true) returns 5.
*/
  int countUntil(String value, {bool relativePosition = false}) {
    int old_position = position;
    bool value_not_found = true;

    while(value_not_found) {
      if((position + value.length) > data.length) {
        return -1;
      } else {
        String string_sample = data.substring(position, (position + value.length));
        if(string_sample == value) {
          int found_position = position;
          position = old_position;
          if(relativePosition) {
            return found_position-position;
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

  /*  
    Counts how many characters of provided string there are next to each other from
    cursor position. Only supports 1 character. If several is provided only the first
    will be used.

    Example:    "aaaarg!"

    With a position of 0, countCharacterSequence('a') returns 4.
    With a position of 4, countCharacterSequence('a') returns 0.
    With a position of 4, countCharacterSequence('r') returns 1.
  */
  int countCharacterSequenze(String character) {
    character = character.substring(0,1);
    int old_position = position;
    int count = 0;

    while(true) {
      if((position + 1) > data.length) {
        position = old_position;
        return count;
      } else {
        String string_sample = data.substring(position, (position + 1));
        if(string_sample == character) {
          count++;
          position++;
        } else {
          position = old_position;
          return count;
        }
      }
    }    
  }

  /*  
    Moves the cursor position a certain number of characters. If it overshoots then the 
    cursor position will be set to the last character in the string.
  */
  void move({int characters = 1}) {
    position = position + characters;
    _checkEndOfLine();
    if(eol)
      moveToEnd();
  }

  /*  
    Moves the cursor position to the last character of the string. An empty string returns 0.
  */
  void moveToEnd() {
    if(data.length != 0) {
      position = data.length - 1;
    }
  }

  /*  
    Inserts the supplied string at the current cursor position. It expands the data as
    it does not replace any characters. If overflow is set to true then the data string
    will retain the same length, cutting characters that overflow.

    Example:    "Well done is better than well said."

    With a position of 5, insertAtPosition('friggin ') results in data being
    "Well friggin done is better than well said."

    With a position of 5, insertAtPosition('friggin ', cutOverflow: false) results in data being
    "Well friggin done is better than wel"
  */
  void insertAtPosition(String value, {bool cutOverflow = false}) {
    String first = data.substring(0, position);
    String last = data.substring(position);
    int original_length = data.length;

    data = first + value + last;

    if(cutOverflow == true)
      data = data.substring(0, original_length);
  }

  /*  
    Replace characters starting from the current position with the supplied string. Can
    optionally be set to cut overflow, maintaining the original width of the data.

    Example:    "Well done is better than well said."

    With a position of 4, replaceAtPosition('shouted') results in data being
    "Well shouted better than well said."

    With a position of 30, replaceAtPosition('shouted') resulsts in data being
    "Well done is better than well shouted"

    With a position of 30, replaceAtPosition('shouted', overflow: false) resulsts in data being
    "Well done is better than well shout"
  */
  void replaceAtPosition(String value, {bool cutOverflow = false}) {
    String first = data.substring(0, position);
    String last = "";
    int original_length = data.length;

    if((position + value.length) < data.length)
      last = data.substring(position + value.length);

    data = first + value + last;

    if(cutOverflow == true)
      data = data.substring(0, original_length);
  }

/*  
  Replaces the given amount of characters from the current cursor position with the 
  new replacement string. If overflow is set to true then the data string will 
  retain the same length, cutting characters that overflow.

  Example:    "Well done is better than well said."

  With a position of 5, test_replaceCharacters(4, 'shouted') results in data being
  "Well shouted is better than well said."

  With a position of 30, test_replaceCharacters(4, 'shouted') resulsts in data being
  "Well done is better than well shouted."

  With a position of 30, test_replaceCharacters(4, 'shouted', cutOverflow: false) resulsts in data being
  "Well done is better than well shout"    
*/
  void replaceCharacters(int characters, String replacement, {bool cutOverflow = false}) {
    String first = data.substring(0, position);
    String last = data.substring(position + characters);
    int original_length = data.length;

    data = first + replacement + last;

    if(cutOverflow == true)
      data = data.substring(0, original_length);
  }

  /*  
    Moves the cursor forward until either end of line or the value is found in the string.
    Returns true if found and false if not.
  */
  bool moveTo(String value) {
    bool not_found = true;
    while(not_found) {
      if((position + value.length) > data.length) {
        return false;
      } else {
        String temp = data.substring(position, (position + value.length));
        if(temp == value) {
          return true;
        } else {
          position++;
          _checkEndOfLine();
        }
      }
    }    
  }

  /* NOT YET DONE!!!! DOES NOT WORK! */
  bool moveBackwardsFromEndUntil(String value) {
    bool not_found = true;
    int previous_position = position;
    position = data.length - value.length;
    int width = value.length;

    print("Data: >" + data + "<");
    print("Position: " + position.toString());
    print("Width: " + width.toString());

    while(not_found) {
      position = data.length;
      if(position < previous_position) {
        position = previous_position;
        return false;
      }
      position--;
    }
  }

  /*  
    Moves the cursor backwards until either start of line or the value is found in the string.
    Returns true if found and false if not. The cursor position is set to the start of the
    found string.
  */
  bool moveBackwardsTo(String value) {
    bool not_found = true;
    while(not_found) {
      if(position == 0) {
        return false;
      } else {
        if(getFromPosition(characters: value.length) == value) {
          return true;
        } else {
          if(position > -1) {
            position--;
          }
        }
      }
    }    
  }  

  /*  
    Returns the string before current cursor position.

    Example:    "ABCDE"

    With a position of 2, getAllBeforePosition() returns "AB"
  */
  String getAllBeforePosition() {
    return data.substring(0, position);
  }

  /*  
    Returns the string after current cursor position, excluding the character at
    the current cursor position.

    Example:    "ABCDE"

    With a position of 2, getAllAfterPosition() returns "DE"
  */
  String getAllAfterPosition() {
    return data.substring(position + 1);
  }

  /*  
    Returns the string starting from current cursor position and until the end of line.

    Example:    "ABCDE"

    With a position of 2, getAllFromPosition() returns "CDE"
  */
  String getAllFromPosition() {
    return data.substring(position);
  }

  /*  
    Returns the number of specified characters before the current cursor
    position. Default is 1 character.

    Example:    "ABCDE"

    With a position of 2, test_getFromPosition() returns "B"
  */
  String getBeforePosition({int characters = 1}) {
    if((position - characters) < 0) {
      return "";
    } else {    
      return data.substring(position - characters, position);
    }
  }

  /*  
    Returns the number of specified characters from one character after
    the current cursor position. Default is 1 character.

    Example:    "ABCDE"

    With a position of 2, test_getFromPosition() returns "D"
  */
  String getAfterPosition({int characters = 1}) {
    _checkEndOfLine();
    if(eol) {
      return "";
    } else {
      {
        if(_checkOutOfBounds(characters)) {
          return "";
        } else {
          return data.substring(position + 1, position + 1 + characters);
        }
      }
    }
  }

  /*  
    Returns the number of specified characters from the current cursor
    position. Default is 1 character.

    Example:    "ABCDE"

    With a position of 2, test_getFromPosition() returns "C"
  */
  String getFromPosition({int characters = 1}) {
    _checkEndOfLine();
    if(eol) {
      return "";
    } else {
      {
        if(_checkOutOfBounds(characters)) {
          return "";
        } else {
          return data.substring(position, position + characters);
        }
      }
    }
  }  

  /*
    Moves cursor to the first single character that is present in the List<String> argument, then
    returns that character. If cursor position is already on an element in the list then move the
    cursor with the move() function before looking for the next element.

    Example:  "It is warm (inside)."

    With a position of 0, moveToFirstInList([")", "("]) returns "(". The position is then 11.
    With a position of 11, moveToFirstInList(["(", ")"]) returns ")". The position is then 18.
  */
  String moveToFirstInList(List<String> values) {
    while(true) {
      _checkEndOfLine();
      if(eol) {
        return "";
      } else {
        String nextCharacter = getFromPosition();
        if(values.contains(nextCharacter)) {
          return nextCharacter;
        } else {
          move();
        }
      }
    }    
  }  

  /*
    Deletes the number of characters supplied in the argument, starting with the current position.
    
    Example:    "ABCDE"

    With a position of 1, deleteCharacters(2) will change stringtools.data to "ADE".
  */
  void deleteCharacters(int characters) {
    String first = data.substring(0, position);
    String last = data.substring(position + characters);
    data = first + last;
  }

  /*
    Finds the position of the next occurance of the supplied string. It starts looking from the current
    cursor position, but returns the absolute position in the string. Returns -1 if not present.

    Example:    "I am a string."

    With a position of 3, findPosition("a") returns 5.
    With a position of 0, findPosition("rockets!"") returns -1.
  */
  int findPosition(String value) {
    String read_data = data.substring(position, (data.length - position));
    int index = read_data.indexOf(value);
    if(index != -1) {
      return index + position;
    } else {
      return -1;
    }
  }

  /*
    Set the start of selection from the cursors current position unless a specific positional value 
    is supplied. Setting a start_selection value does not check if the selection is negative, meaning
    that the stop_selection value is lower than the start_selection value.

    Example:

    With a position of 0, startSelection() sets the start_selection value to 0.
    With a position of 2, startSelection(1) sets the start_selection value to 1.
  */
  void startSelection({int? value = null}) {
    if (value != null) {
      if(value <= (data.length - position)) {
        start_selection = value;
      } else {
        start_selection = data.length;
      }
    } else {
      start_selection = position;
    }
  }

  /*
    Set the end of the selection from the cursors current position unless a specific positional value 
    is supplied. Setting a stop_selection value does not check if the selection is negative, meaning
    that the stop_selection value is lower than the start_selection value.

    Example:

    With a position of 3, stopSelection() sets the stop_selection value to 3.
    With a position of 0, stopSelection(1) sets the stop_selection value to 1.
  */
  void stopSelection({int? value = null, bool end_of_string = false}) {
    if (value != null) {
      stop_selection = value;
    } else if (end_of_string) {
      stop_selection = data.length;
    } else {
      stop_selection = position;
    }
  }

/*
  Returns the current selected string. A string is selected by calling startSelection() and
  stopSelection() on cursor position.
*/
  String getSelection() {
    if ((stop_selection - start_selection) > 0) {
      String test = data.substring(start_selection, stop_selection);
      return test;
    } else {
      return "";
    }
  }

  /*
    Deletes the current selected string.
  */
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

  /*
    Checks if current position is past the end of the string. Used internally to set the 
    eol (EndOfLine) flag.
  */
  void _checkEndOfLine() {
    if((data.length - 1) <= position) {
      eol = true;
    } else {
      eol = false;
    }
  }

  /*
    Returns true if current position + number of characters in the characters argument will
    put the position out of bounds.
  */
  bool _checkOutOfBounds(int characters) {
    if(position + characters > data.length) {
      return true;
    } else {
      return false;
    }
  }
}