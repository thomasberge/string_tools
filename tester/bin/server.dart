import 'string_tools.dart';

main() {

  print("Testing StringTools functions:");

  if(test_move()) {
    print("move()\t\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("move()\t\t\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_moveTo()) {
    print("moveTo()\t\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("moveTo()\t\t\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_moveBackwardsTo()) {
    print("moveBackwardsTo()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("moveBackwardsTo()\t\t\t[\u001b[32mOK\u001b[0m]");
  }    

  if(test_moveToEnd()) {
    print("moveToEnd()\t\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("moveToEnd()\t\t\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_countUntil()) {
    print("countUntil()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("countUntil()\t\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_countCharacterSequenze()) {
    print("countCharacterSequenze()\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("countCharacterSequenze()\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_insertAtPosition()) {
    print("insertAtPosition()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("insertAtPosition()\t\t\t[\u001b[32mOK\u001b[0m]");
  }  

  if(test_replaceAtPosition()) {
    print("replaceAtPosition()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("replaceAtPosition()\t\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_replaceCharacters()) {
    print("replaceCharacters()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("replaceCharacters()\t\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_getAllFromPosition()) {
    print("getAllFromPosition()\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("getAllFromPosition()\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_getAllAfterPosition()) {
    print("getAllAfterPosition()\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("getAllAfterPosition()\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_getAllBeforePosition()) {
    print("getAllBeforePosition()\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("getAllBeforePosition()\t\t[\u001b[32mOK\u001b[0m]");
  }    

  if(test_getFromPosition()) {
    print("getFromPosition()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("getFromPosition()\t\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_getAfterPosition()) {
    print("getAfterPosition()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("getAfterPosition()\t\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_getBeforePosition()) {
    print("getBeforePosition()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("getBeforePosition()\t\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_moveToFirstInList()) {
    print("moveToFirstInList()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("moveToFirstInList()\t\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_deleteCharacters()) {
    print("deleteCharacters()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("deleteCharacters()\t\t\t[\u001b[32mOK\u001b[0m]");
  }

  if(test_findPosition()) {
    print("findPosition()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("findPosition()\t\t\t[\u001b[32mOK\u001b[0m]");
  }  

  if(test_getSelection()) {
    print("getSelection()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("getSelection()\t\t\t[\u001b[32mOK\u001b[0m]");
  } 

  if(test_deleteSelection()) {
    print("deleteSelection()\t\t\t[\u001b[31mFailed\u001b[0m]");
  } else {
    print("deleteSelection()\t\t\t[\u001b[32mOK\u001b[0m]");
  } 
  print("Done!");
}

/*  
  Moves the cursor position a certain number of characters. If it overshoots then the 
  cursor position will be set to the last character in the string.
*/
bool test_move() {
  bool bugs = true;
  StringTools stringtools = new StringTools("Woof");
  stringtools.move();
  if(stringtools.position == 1) {
    stringtools.move();
    if(stringtools.position == 2) {
      stringtools.move(characters: 1);
      if(stringtools.position == 3) {
        stringtools.move(characters: 100);
        if(stringtools.position == 3) {
          bugs = false;
        }
      }
    }
  }
  return bugs;
}

/*  
  Moves the cursor forward until either end of line or the value is found in the string.
  Returns true if found and false if not.
*/
bool test_moveTo() {
  bool bugs = true;
  StringTools stringtools = new StringTools("High as a kite!");
  stringtools.moveTo("as");
  if(stringtools.position == 5) {
    bugs = false;
  }
  return bugs;
}

/*  
  Moves the cursor backwards until either start of line or the value is found in the string.
  Returns true if found and false if not. The cursor position is set to the start of the
  found string.
*/
bool test_moveBackwardsTo() {
  bool bugs = true;
  StringTools stringtools = new StringTools("High as a kite!");
  stringtools.moveToEnd();
  stringtools.moveBackwardsTo("as");
  if(stringtools.position == 5) {
    bugs = false;
  }
  return bugs;
}

/*  
  Moves the cursor position to the last character of the string. An empty string returns 0.
*/
bool test_moveToEnd() {
  bool bugs = true;
  StringTools stringtools = new StringTools("");
  stringtools.moveToEnd();
  if(stringtools.position == 0) {
    stringtools.data = "123";
    stringtools.moveToEnd();
    if(stringtools.position == 2) {
      bugs = false;
    }
  }
  return bugs;
}

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
bool test_countUntil() {
  bool bugs = true;
  StringTools stringtools = new StringTools("I am a string");
  int result = stringtools.countUntil('a');
  if(result == 2) {
    stringtools.position = 3;
    result = stringtools.countUntil('a');
    if(result == 5) {
      result = stringtools.countUntil('a', relativePosition: true);
      if(result == 2) {
        result = stringtools.countUntil('x');
        if(result == -1) {
          bugs = false;
        }
      }
    }
  }
  return bugs;
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
bool test_countCharacterSequenze() {
  bool bugs = true;
  StringTools stringtools = new StringTools("aaaarg!");
  int result = stringtools.countCharacterSequenze('a');
  if(result == 4) {
    stringtools.position = 4;
    result = stringtools.countCharacterSequenze('a');
    if(result == 0) {
      result = stringtools.countCharacterSequenze('r');
      if(result == 1) {
        bugs = false;
      }
    }
  }
  return bugs;
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
bool test_insertAtPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("Well done is better than well said.");
  stringtools.position = 5;
  stringtools.insertAtPosition('friggin ');
  if(stringtools.data == "Well friggin done is better than well said.") {
    bugs = false;
    stringtools.data = "Well done is better than well said.";
    stringtools.insertAtPosition('friggin ', cutOverflow: false);
    if(stringtools.data == "Well friggin done is better than wel") {
      bugs = false;
    }
  }
  return bugs;
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
bool test_replaceAtPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("Well done is better than well said.");
  stringtools.position = 5;
  stringtools.replaceAtPosition("shouted");
  if(stringtools.data == "Well shouted better than well said.") {
    stringtools.data = "Well done is better than well said.";
    stringtools.position = 30;
    stringtools.replaceAtPosition("shouted.");
    if(stringtools.data == "Well done is better than well shouted.") {
      stringtools.data = "Well done is better than well said.";
      stringtools.replaceAtPosition("shouted.", cutOverflow: true);
      if(stringtools.data == "Well done is better than well shout") {
        bugs = false;
      }
    }
  }
  return bugs;
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
bool test_replaceCharacters() {
  bool bugs = true;
  StringTools stringtools = new StringTools("Well done is better than well said.");
  stringtools.position = 5;
  stringtools.replaceCharacters(4, "shouted");
  if(stringtools.data == "Well shouted is better than well said.") {
    stringtools.data = "Well done is better than well said.";
    stringtools.position = 30;
    stringtools.replaceCharacters(4, "shouted");
    if(stringtools.data == "Well done is better than well shouted.") {
      stringtools.data = "Well done is better than well said.";
      stringtools.replaceCharacters(4, "shouted", cutOverflow: true);
      if(stringtools.data == "Well done is better than well shout") {
        bugs = false;
      }
    }
  }
  return bugs;
}

/*
  Returns the string starting from current cursor position and until the end of line.

  Example:    "ABCDE"

  With a position of 2, getAllFromPosition() returns "CDE"
*/
test_getAllFromPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if(stringtools.getAllFromPosition() == "CDE") {
    bugs = false;
  }
  return bugs;  
}

/*  
  Returns the string after current cursor position, excluding the character at
  the current cursor position.

  Example:    "ABCDE"

  With a position of 2, getAllAfterPosition() returns "DE"
*/
test_getAllAfterPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if(stringtools.getAllAfterPosition() == "DE") {
    bugs = false;
  }  
  return bugs;  
}

/*  
  Returns the string before current cursor position.

  Example:    "ABCDE"

  With a position of 2, getAllBeforePosition() returns "AB"
*/
test_getAllBeforePosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if(stringtools.getAllBeforePosition() == "AB") {
    bugs = false;
  }  
  return bugs;  
}

/*  
  Returns the number of specified characters from the current cursor
  position. Default is 1 character.

  Example:    "ABCDE"

  With a position of 2, test_getFromPosition() returns "C"
*/
test_getFromPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if(stringtools.getFromPosition() == "C") {
    if(stringtools.getFromPosition(characters: 2) == "CD") {
      bugs = false;
    }
  }
  return bugs;  
}

/*  
  Returns the number of specified characters from one character after
  the current cursor position. Default is 1 character.

  Example:    "ABCDE"

  With a position of 2, test_getFromPosition() returns "D"
*/
test_getAfterPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if(stringtools.getAfterPosition() == "D") {
    if(stringtools.getAfterPosition(characters: 2) == "DE") {
      bugs = false;
    }
  }  
  return bugs;  
}

/*  
  Returns the number of specified characters before the current cursor
  position. Default is 1 character.

  Example:    "ABCDE"

  With a position of 2, test_getFromPosition() returns "B"
*/
test_getBeforePosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if(stringtools.getBeforePosition() == "B") {
    if(stringtools.getBeforePosition(characters: 2) == "AB") {
      bugs = false;
    }
  }  
  return bugs;  
}

/*
  Moves cursor to the first single character that is present in the List<String> argument, then
  returns that character. If cursor position is already on an element in the list then move the
  cursor with the move() function before looking for the next element.

  Example:  "It is warm (inside)."

  With a position of 0, moveToFirstInList([")", "("]) returns "(". The position is then 11.
  With a position of 11, moveToFirstInList(["(", ")"]) returns ")". The position is then 18.
*/
test_moveToFirstInList() {
  bool bugs = true;
  StringTools stringtools = new StringTools("It is warm (inside).");
  List<String> list = ["(", ")"];
  stringtools.moveToFirstInList(list);
  if(stringtools.position == 11) {
    stringtools.move();
    stringtools.moveToFirstInList(list);
    if(stringtools.position == 18) {
      bugs = false;
    }
  }
  return bugs;
}

/*
  Deletes the number of characters supplied in the argument, starting with the current position.
  
  Example:    "ABCDE"

  With a position of 1, deleteCharacters(2) will change stringtools.data to "ADE".
*/
test_deleteCharacters() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 1;
  stringtools.deleteCharacters(2);
  if(stringtools.data == "ADE") {
    bugs = false;
  }
  return bugs;
}

/*
  Finds the position of the next occurance of the supplied string. It starts looking from the current
  cursor position, but returns the absolute position in the string. Returns -1 if not present.

  Example:    "I am a string."

  With a position of 3, findPosition("a") returns 5.
  With a position of 0, findPosition("rockets!"") returns -1.
*/
test_findPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("I am a string.");
  if(stringtools.findPosition("rockets!") == -1) {
    stringtools.position = 3;
    if(stringtools.findPosition("a") == 5) {
      bugs = false;
    }
  }
  return bugs;
}

/*
  Returns the current selected string. A string is selected by calling startSelection() and
  stopSelection() on cursor position.
*/
test_getSelection() {
  bool bugs = true;
  StringTools stringtools = new StringTools("I am not the best!");
  stringtools.moveTo("not");
  stringtools.startSelection();
  stringtools.move(characters:3);
  stringtools.stopSelection();
  if(stringtools.getSelection() == "not") {
    bugs = false;
  }
  return bugs;
}

/*
  Returns the current selected string. A string is selected by calling startSelection() and
  stopSelection() on cursor position.
*/
test_deleteSelection() {
  bool bugs = true;
  StringTools stringtools = new StringTools("I am not the best!");
  stringtools.moveTo("not");
  stringtools.startSelection();
  stringtools.move(characters:4);
  stringtools.stopSelection();
  stringtools.deleteSelection();
  if(stringtools.data == "I am the best!") {
    bugs = false;
  }
  return bugs;
}