import 'string_tools.dart';

Map<String, String> errors = {};
List<Function> functions = [
  test_next,
  test_back,
  test_find,
  test_nextCharacters,
  test_home,
  test_end,
  test_countUntil,
  test_countCharacterSequenze,
  test_insertAtPosition,
  test_replaceAtPosition,
  test_replaceCharacters,
  test_getAllFromPosition,
  test_getAllAfterPosition,
  test_getAllBeforePosition,
  test_getFromPosition,
  test_getAfterPosition,
  test_getBeforePosition,
  test_deleteAllFromPosition,
  test_deleteAllAfterPosition,
  test_deleteAllBeforePosition,
  test_moveToListElement,
  test_deleteCharacters,
  test_findPosition,
  test_getSelection,
  test_deleteSelection,
  test_edgesIs,
  test_firstIs,
  test_lastIs,
  test_deleteEdges,
  test_count,
  test_getQuotedString,
  test_selectTo,
  test_selectFromTo,
  test_selectFromToWithIgnoreES,
  test_getFromTo,
  test_getFromToWithIgnoreES,
  test_deleteFromTo,
  test_replaceSelection,
  test_deleteEdgesOfSelection,
  test_moveToRegex,
  test_moveWhileRegex
];

main() {
  print("\r\n  ------------------------------------------------------------------");
  print("  :: Running Test Script                                          ::");
  print("  ------------------------------------------------------------------");  
  int cleared = 0;
  int failed = 0;

  for(Function f in functions) {
    if(f()) {
      failed++;
      String error_message = "Unknown error";
      if(errors.containsKey(getFunctionName(f))) {
        error_message = errors[getFunctionName(f)].toString();
      }
      print("  \u001b[31m" + getFunctionName(f) + " failed. Reason: " + error_message + "\u001b[0m");
    } else {
      cleared++;
    }
  }

  if(failed == 0) {
    print("  :: [" + cleared.toString() + "/" + cleared.toString() + "] tests completed without fail.                        ::");
  } else {
  print("\r\n  ------------------------------------------------------------------");  
    print("  ::  [\u001b[31m" + cleared.toString() + "\u001b[0m/" + (cleared + failed).toString() + "] tests completed without fail. Review errors above.  ::");
  }
  print("  ------------------------------------------------------------------\r\n");

}

/*  UTILITY FUNCTIONS   
*/

void printErrorMessages(String key) {
  for(MapEntry e in errors.entries) {
    if(e.key == key) {
      print(errors[key]);
    }
  }
}

String getFunctionName(Function f) {
  return ""+f.toString().split("from Function 'test_", )[1].split("': ")[0] + "()".toString();  // yes this is bad
}

/*  TEST FUNCTIONS
*/

bool test_next() {
  bool bugs = true;
  StringTools cursor = new StringTools("Woof");
  cursor.next();
  if (cursor.position == 1) {
    cursor.next();
    if (cursor.position == 2) {
      cursor.next(characters: 1);
      if (cursor.position == 3) {
        cursor.next(characters: 100);
        if (cursor.position == 4) {
          bugs = false;
        }
      }
    }
  }
  return bugs;
}

bool test_back() {
  bool bugs = true;
  StringTools cursor = new StringTools("01234567890");
  cursor.end();
  cursor.back();
  if (cursor.position == 10) {
    while(cursor.back(characters: 2)) {
      
    }
    if(cursor.position == 0) {
      bugs = false;
    }
  }
  return bugs;
}

bool test_nextCharacters() {
  bool bugs = true;
  StringTools cursor = new StringTools("This is a super duper test!");
  cursor.find("super");
  if (cursor.nextCharacters("super")) {
    if(cursor.nextCharacters("aaaaarg") == false) {
      cursor.find("!");
      if(cursor.nextCharacters("!!") == false) {
        bugs = false;
      }
    }
  }
  return bugs;
}

bool test_find() {
  bool bugs = true;
  StringTools cursor = new StringTools("High as a kite!");
  cursor.find("as");
  if (cursor.position == 5) {
    if(cursor.find('!')) {
      if(cursor.find("High", reverse: true)) {
        if(cursor.position == 0) {
          bugs = false;
        } else {
          errors["find()"] = "Position after reverse find is not correct.";
        }
      } else {
        errors["find()"] = "Failed reverse find.";
      }
    } else {
      errors["find()"] = "Failed to find last character.";
    }
  } else {
    errors["find()"] = "Failed to find the supplied argument.";
  }
  return bugs;
}

bool test_end() {
  bool bugs = true;
  StringTools stringtools = new StringTools("");
  stringtools.end();
  if (stringtools.position == 0) {
    stringtools.data = "123";
    stringtools.end();
    if (stringtools.position == 3) {
      bugs = false;
    }
  }
  return bugs;
}

/*  
  Example     "I am a string"
  
  With a position of 0, countUntil('a') returns 2.
  With a position of 3, countUntil('a') returns 5.
  With a position of 3, countUntil('a', relativePosition: true) returns 5.
*/
bool test_countUntil() {
  bool bugs = true;
  StringTools stringtools = new StringTools("I am a string");
  int result = stringtools.countUntil('a');
  if (result == 2) {
    stringtools.position = 3;
    result = stringtools.countUntil('a');
    if (result == 5) {
      result = stringtools.countUntil('a', relativePosition: true);
      if (result == 2) {
        result = stringtools.countUntil('x');
        if (result == -1) {
          bugs = false;
        }
      }
    }
  }
  return bugs;
}

/*  
  Example:    "aaaarg!"

  With a position of 0, countCharacterSequence('a') returns 4.
  With a position of 4, countCharacterSequence('a') returns 0.
  With a position of 4, countCharacterSequence('r') returns 1.
*/
bool test_countCharacterSequenze() {
  bool bugs = true;
  StringTools stringtools = new StringTools("aaaarg!");
  int result = stringtools.countCharacterSequenze('a');
  if (result == 4) {
    stringtools.position = 4;
    result = stringtools.countCharacterSequenze('a');
    if (result == 0) {
      result = stringtools.countCharacterSequenze('r');
      if (result == 1) {
        bugs = false;
      }
    }
  }
  return bugs;
}

/*  
  Example:    "Well done is better than well said."

  With a position of 5, insertAtPosition('friggin ') results in data being
  "Well friggin done is better than well said."

  With a position of 5, insertAtPosition('friggin ', cutOverflow: false) results in data being
  "Well friggin done is better than wel"
*/
bool test_insertAtPosition() {
  bool bugs = true;
  StringTools stringtools =
      new StringTools("Well done is better than well said.");
  stringtools.position = 5;
  stringtools.insertAtPosition('friggin ');
  if (stringtools.data == "Well friggin done is better than well said.") {
    bugs = false;
    stringtools.data = "Well done is better than well said.";
    stringtools.insertAtPosition('friggin ', cutOverflow: false);
    if (stringtools.data == "Well friggin done is better than wel") {
      bugs = false;
    }
  }
  return bugs;
}

/*  
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
  StringTools stringtools =
      new StringTools("Well done is better than well said.");
  stringtools.position = 5;
  stringtools.replaceAtPosition("shouted");
  if (stringtools.data == "Well shouted better than well said.") {
    stringtools.data = "Well done is better than well said.";
    stringtools.position = 30;
    stringtools.replaceAtPosition("shouted.");
    if (stringtools.data == "Well done is better than well shouted.") {
      stringtools.data = "Well done is better than well said.";
      stringtools.replaceAtPosition("shouted.", cutOverflow: true);
      if (stringtools.data == "Well done is better than well shout") {
        bugs = false;
      }
    }
  }
  return bugs;
}

/*  
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
  StringTools stringtools =
      new StringTools("Well done is better than well said.");
  stringtools.position = 5;
  stringtools.replaceCharacters(4, "shouted");
  if (stringtools.data == "Well shouted is better than well said.") {
    stringtools.data = "Well done is better than well said.";
    stringtools.position = 30;
    stringtools.replaceCharacters(4, "shouted");
    if (stringtools.data == "Well done is better than well shouted.") {
      stringtools.data = "Well done is better than well said.";
      stringtools.replaceCharacters(4, "shouted", cutOverflow: true);
      if (stringtools.data == "Well done is better than well shout") {
        bugs = false;
      }
    }
  }
  return bugs;
}

/*
  Example:    "ABCDE"

  With a position of 2, getAllFromPosition() returns "CDE"
*/
test_getAllFromPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if (stringtools.getAllFromPosition() == "CDE") {
    bugs = false;
  }
  return bugs;
}

/*  
  Example:    "ABCDE"

  With a position of 2, getAllAfterPosition() returns "DE"
*/
test_getAllAfterPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if (stringtools.getAllAfterPosition() == "DE") {
    bugs = false;
  }
  return bugs;
}

/*  
  Example:    "ABCDE"

  With a position of 2, getAllBeforePosition() returns "AB"
*/
test_getAllBeforePosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if (stringtools.getAllBeforePosition() == "AB") {
    bugs = false;
  }
  return bugs;
}

/*
  Example:    "ABCDE"

  With a position of 2, deleteAllFromPosition() deletes "CDE"
*/
test_deleteAllFromPosition() {
  bool bugs = true;
  StringTools cursor = new StringTools("ABCDE");
  cursor.position = 2;
  cursor.deleteAllFromPosition();
  if (cursor.data == "AB") {
    bugs = false;
  }
  return bugs;
}

/*  
  Example:    "ABCDE"

  With a position of 2, deleteAllAfterPosition() deletes "DE"
*/
test_deleteAllAfterPosition() {
  bool bugs = true;
  StringTools cursor = new StringTools("ABCDE");
  cursor.position = 2;
  cursor.deleteAllAfterPosition();
  if (cursor.data == "ABC") {
    bugs = false;
  }
  return bugs;
}

/*  
  Example:    "ABCDE"

  With a position of 2, deleteAllBeforePosition() deletes "AB"
*/
test_deleteAllBeforePosition() {
  bool bugs = true;
  StringTools cursor = new StringTools("ABCDE");
  cursor.position = 2;
  cursor.deleteAllBeforePosition();
  if (cursor.data == "CDE") {
    bugs = false;
  }
  return bugs;
}

/*  
  Example:    "ABCDE"

  With a position of 2, test_getFromPosition() returns "C"
*/
test_getFromPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if (stringtools.getFromPosition() == "C") {
    if (stringtools.getFromPosition(characters: 2) == "CD") {
      bugs = false;
    }
  }
  return bugs;
}

/*  
  Example:    "ABCDE"

  With a position of 2, test_getFromPosition() returns "D"
*/
test_getAfterPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if (stringtools.getAfterPosition() == "D") {
    if (stringtools.getAfterPosition(characters: 2) == "DE") {
      bugs = false;
    }
  }
  return bugs;
}

/*  
  Example:    "ABCDE"

  With a position of 2, test_getFromPosition() returns "B"
*/
test_getBeforePosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 2;
  if (stringtools.getBeforePosition() == "B") {
    if (stringtools.getBeforePosition(characters: 2) == "AB") {
      bugs = false;
    }
  }
  return bugs;
}

/*
  Example:  "It is warm (inside)."

  With a position of 0, moveToFirstInList([")", "("]) returns "(". The position is then 11.
  With a position of 11, moveToFirstInList(["(", ")"]) returns ")". The position is then 18.
*/
test_moveToListElement() {
  bool bugs = true;
  StringTools cursor = new StringTools("It is warm (inside).");
  List<String> list = ["(", ")"];
  cursor.moveToListElement(list);
  if (cursor.position == 11) {
    cursor.next();
    cursor.moveToListElement(list);
    if (cursor.position == 18) {
      List<String> list2 = ["//", "%&"];
      cursor.data = "Move to //this then %&!";
      cursor.reset();
      if(cursor.moveToListElement(list2) == "//") {
        cursor.startSelection();
        cursor.next();
        if(cursor.moveToListElement(list2) == "%&") {
          cursor.stopSelection();
          if(cursor.getSelection() == "//this then ") {
            bugs = false;
          }
        }
      }
    }
  }
  return bugs;
}

/*
  Example:    "ABCDE"

  With a position of 1, deleteCharacters(2) will change stringtools.data to "ADE".
*/
test_deleteCharacters() {
  bool bugs = true;
  StringTools stringtools = new StringTools("ABCDE");
  stringtools.position = 1;
  stringtools.deleteCharacters(2);
  if (stringtools.data == "ADE") {
    bugs = false;
  }
  return bugs;
}

/*
  Example:    "I am a string."

  With a position of 3, findPosition("a") returns 5.
  With a position of 0, findPosition("rockets!"") returns -1.
*/
test_findPosition() {
  bool bugs = true;
  StringTools stringtools = new StringTools("I am a string.");
  if (stringtools.findPosition("rockets!") == -1) {
    stringtools.position = 3;
    if (stringtools.findPosition("a") == 5) {
      bugs = false;
    }
  }
  return bugs;
}

/*  
  Example:    "I am not the best!"

  With a start_position of 5 and a stop_position of 8, test_getSelection() returns "not".
*/
test_getSelection() {
  bool bugs = true;
  StringTools stringtools = new StringTools("I am not the best!");
  stringtools.find("not");
  stringtools.startSelection();
  stringtools.next(characters: 3);
  stringtools.stopSelection();
  if (stringtools.getSelection() == "not") {
    bugs = false;
  }
  return bugs;
}

/*  
  Example:    "I am not the best!"

  With a start_position of 5 and a stop_position of 9, test_deleteSelection() deletes "not ".
*/
test_deleteSelection() {
  bool bugs = true;
  StringTools stringtools = new StringTools("I am not the best!");
  stringtools.find("not");
  stringtools.startSelection();
  stringtools.next(characters: 4);
  stringtools.stopSelection();
  stringtools.deleteSelection();
  if (stringtools.data == "I am the best!") {
    bugs = false;
  }
  return bugs;
}

/*  
  Example:    "abbbbabbba"

  With the first and last characters being "a", edgesIs("a") returns true.

  Examole2:   "abaab"

  With the first and last string being "ab", edgesIs("ab") returns true.
*/
test_edgesIs() {
  bool bugs = true;
  StringTools stringtools = new StringTools("abbbbabbba");
  if (stringtools.edgesIs("a")) {
    stringtools.data = "12ab12";
    if (stringtools.edgesIs("12")) {
      bugs = false;
    }
  }
  return bugs;
}

/*  
  Example:    "1234"

  deleteEdges() deletes the first and last character, setting data to "23".
*/
test_deleteEdges() {
  bool bugs = true;
  StringTools cursor = new StringTools("1234");
  cursor.deleteEdges();
  if (cursor.data == "23") {
    bugs = false;
  }
  return bugs;
}

/*  
  Example:    "abbbbabbba"

  counts number of non-overlapping strings in data.
*/
test_count() {
  bool bugs = true;
  StringTools cursor = new StringTools("abbbbabbba");
  if (cursor.count("a") == 3) {
    if(cursor.count("bbb") == 2) {
      if(cursor.count("ab") == 2) {
        if(cursor.count("@") == 0) {
          bugs = false;
        }
      }
    }
  }
  return bugs;
}

test_getQuotedString() {
  bool bugs = true;
  StringTools cursor = new StringTools('abba"abbbbabbba"abba');
  if (cursor.getQuotedString() == "abbbbabbba") {
    bugs = false;
  }
  return bugs;
}

test_selectTo() {
  bool bugs = true;
  StringTools cursor = new StringTools('1234586789');
  cursor.next();
  cursor.selectTo("8");
  if (cursor.getSelection() == "2345") {
    cursor.reset();
    cursor.next();
    cursor.selectTo("8", includeArgument: true);
    if(cursor.getSelection() == "23458") {
      bugs = false;
    }
  }
  return bugs;
}

test_selectFromTo() {
  bool bugs = true;
  StringTools cursor = new StringTools('thisis(not)awesome!');
  cursor.selectFromTo("s(", ")a");
  if (cursor.getSelection() == "not") {
    cursor.reset();
    cursor.selectFromTo("(", ")", includeArguments: true);
    if(cursor.getSelection() == "(not)") {
      cursor.reset();
      cursor.selectFromTo("n", "o");
      if(cursor.getSelection() == "") {
        cursor.reset();
        cursor.selectFromTo("n", "o", includeArguments: true);
        if(cursor.getSelection() == "no") {
          bugs = false;
        }
      }
    }
  }
  return bugs;
}

test_selectFromToWithIgnoreES() {
  bool bugs = true;
  StringTools cursor = new StringTools(r'print("This is a \"quoted\" string.")');
  cursor.selectFromTo('"', '"', ignoreEscape: true);
  if (cursor.getSelection() == r'This is a \"quoted\" string.') {
    bugs = false;
  }
  return bugs;
}

test_getFromTo() {
  bool bugs = true;
  StringTools cursor = new StringTools('thisis(not)awesome!');
  String result = cursor.getFromTo("s(", ")a");
  if (result == "not") {
    cursor.reset();
    result = cursor.getFromTo("s(", ")a", includeArguments: true);
    if(result == "s(not)a") {
      bugs = false;
    }
  }
  return bugs;
}

test_getFromToWithIgnoreES() {
  bool bugs = true;
  StringTools cursor = new StringTools(r'print("This is a \"quoted\" string.")');
  String result = cursor.getFromTo('"', '"', ignoreEscape: true);
  if (result == r'This is a \"quoted\" string.') {
    bugs = false;
  }
  return bugs;
}

test_deleteFromTo() {
  bool bugs = true;
  StringTools cursor = new StringTools('thisis(not)awesome!');
  cursor.deleteFromTo("isis", "awe");
  if (cursor.data == "thisisawesome!") {
    cursor.reset();
    cursor.deleteFromTo("isis", "wes", deleteArguments: true);
    if(cursor.data == "thome!") {
      cursor.data = "test('1234')test";
      cursor.reset();
      String test = cursor.deleteFromTo("('", "')", includeArguments: false, deleteArguments: true);
      cursor.data = '1234';
      if(test == '1234') {
        cursor.reset();
        cursor.deleteFromTo('2', '3');
        if(test == '1234') {
          bugs = false;
        }
      }
    }
  }
  return bugs;
}

test_firstIs() {
  bool bugs = true;
  StringTools cursor = new StringTools("abbbbabbba");
  if (cursor.firstIs("abb")) {
    bugs = false;
  }
  return bugs;
}

test_lastIs() {
  bool bugs = true;
  StringTools cursor = new StringTools("abbbbabbba");
  if (cursor.lastIs("bba")) {
    bugs = false;
  }
  return bugs;
}

test_replaceSelection() {
  bool bugs = true;
  StringTools cursor = new StringTools("Get off my lawn!");
  cursor.find("my");
  cursor.startSelection();
  cursor.find("!");
  cursor.stopSelection();
  if (cursor.getSelection() == "my lawn") {
    cursor.replaceSelection("the carpet");
    if(cursor.data == "Get off the carpet!") {
      if(cursor.getSelection() == "the carpet") {
        bugs = false;
      }
    }
  }
  return bugs;
}

test_deleteEdgesOfSelection() {
  bool bugs = true;
  StringTools cursor = new StringTools("123321");
  cursor.next();
  cursor.startSelection();
  cursor.next(characters: 4);
  cursor.stopSelection();
  //print(cursor.getSelection());
  cursor.deleteEdgesOfSelection();
  if(cursor.getSelection() == "33") {
    if(cursor.data == "1331") {
      bugs = false;
    }
  }
  return bugs;
}

test_moveToRegex() {
  bool bugs = true;
  StringTools cursor = new StringTools("5 * (43 - number1 + number2) / 12");
  RegExp exp1 = new RegExp(r"^[a-zA-Z]*$", caseSensitive: false);
  cursor.moveToRegex(exp1);
  if(cursor.getFromPosition(characters: 6) == "number") {
    bugs = false;
  }
  return bugs;
}

test_moveWhileRegex() {
  bool bugs = true;
  StringTools cursor = new StringTools("5 * (43 - Number1 + number2) / 12");
  RegExp exp1 = new RegExp(r"^[a-z]*$", caseSensitive: false);
  RegExp exp2 = new RegExp(r"^[a-z0-9_]*$", caseSensitive: false);
  cursor.moveToRegex(exp1);
  cursor.startSelection();
  if(cursor.getFromPosition(characters: 6) == "Number") {
    cursor.moveWhileRegex(exp2);
    cursor.stopSelection();
    if(cursor.getSelection() == "Number1") {
      if(cursor.moveToRegex(exp1)) {
        cursor.startSelection();
        cursor.moveWhileRegex(exp2);
        cursor.stopSelection();
        if(cursor.getSelection() == "number2") {
          bugs = false;
        }
      }
    }
  }
  return bugs;
}

/*  
  insertAtEdgesOfSelection() appends the two arguments to the first and last parts of the selected string.
  The selection is then resized.
*/
test_insertAtEdgesOfSelection() {
  bool bugs = true;
  StringTools cursor = new StringTools("1346");
  cursor.next();
  cursor.startSelection();
  cursor.next(characters: 2);
  cursor.stopSelection();
  cursor.insertAtEdgesOfSelection("2", "5");
  if (cursor.data == "123456") {
    if(cursor.getSelection() == "2345") {
      bugs = false;
    }
  }
  return bugs;
}

/*  
  insertAtEdgesOfSelection() appends the two arguments to the first and last parts of the selected string.
  The selection is then resized.
*/
test_home() {
  bool bugs = true;
  StringTools cursor = new StringTools("abcdef");
  cursor.position = 3;
  cursor.home();
  if (cursor.position == 0) {
    bugs = false;
  }
  return bugs;
}