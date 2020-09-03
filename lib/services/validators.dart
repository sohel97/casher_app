import '../strings.dart';
import 'firebaseManagement.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     validators.dart
|
|  Purpose:  validators for forms.
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */

/*---------------------------------------------------------------------------\
| Function: textFieldValidator::validators
| Purpose: validate if the is not empty
| Input: Field Value
| Output:  null if its valid otherwise sPleaseEnterText message
\---------------------------------------------------------------------------*/
String textFieldValidator(String value) {
  if (value.isEmpty) {
    return sPleaseEnterText;
  }
  return null;
}

/*---------------------------------------------------------------------------\
| Function: yearFieldValidator::validators
| Purpose: validate if the field is a between 1940-2020
| Input: Field Value
| Output:  null if its valid year otherwise sPleaseEnterValidYear message
\---------------------------------------------------------------------------*/
String yearFieldValidator(String value) {
  try {
    if (value.isEmpty) {
      return sPleaseEnterText;
    }
    var val = int.parse(value);
    if (val >= 1940 && val <= 2020) {
      return null;
    }
  } catch (e) {}
  return sPleaseEnterValidYear;
}

/*---------------------------------------------------------------------------\
| Function: monthFieldValidator::validators
| Purpose: validate if the field is a between 1-12
| Input: Field Value
| Output:  null if its valid month otherwise sPleaseEnterValidMonth message
\---------------------------------------------------------------------------*/
String monthFieldValidator(String value) {
  try {
    if (value.isEmpty) {
      return sPleaseEnterText;
    }
    var val = int.parse(value);
    if (val >= 1 && val <= 12) {
      return null;
    }
  } catch (e) {}
  return sPleaseEnterValidMonth;
}

/*---------------------------------------------------------------------------\
| Function: dayFieldValidator::validators
| Purpose: validate if the field is a between 1-31
| Input: Field Value
| Output:  null if its valid day otherwise sPleaseEnterValidDay message
\---------------------------------------------------------------------------*/
String dayFieldValidator(String value) {
  try {
    if (value.isEmpty) {
      return sPleaseEnterText;
    }
    var val = int.parse(value);
    if (val >= 1 && val <= 31) {
      return null;
    }
  } catch (e) {}
  return sPleaseEnterValidDay;
}

/*---------------------------------------------------------------------------\
| Function: numberFieldValidator::validators
| Purpose: validate if the field contains numbers only
| Input: Field Value
| Output:  null if its number otherwise sPleaseEnterValidNumber message
\---------------------------------------------------------------------------*/
String numberFieldValidator(String value) {
  try {
    if (value.isEmpty) {
      return sPleaseEnterText;
    }
    int.parse(value);
    return null;
  } catch (e) {
    convertArabicNumbersToEnglish(value);
  }
  return sPleaseEnterValidNumber;
}

/*---------------------------------------------------------------------------\
| Function: adminPasswordValidator::validators
| Purpose: validate the password with firebase
| Input: string password
| Output:  null if authenticated otherwise sWrongPassword message
\---------------------------------------------------------------------------*/
String adminPasswordValidator(String value) {
  if (value.isEmpty) {
    return sPleaseEnterText;
  }
  if (authenticateWithFirebase(value)) {
    return null;
  }
  return sWrongPassword;
}

/*---------------------------------------------------------------------------\
| Function: convertArabicNumbersToEnglish::validators
| Purpose:convert Arabic Numbers To English in a string
| Input: string value
| Output:  converted string
\---------------------------------------------------------------------------*/
convertArabicNumbersToEnglish(String value) {
  String arabic = '۰۱۲۳۴۵۶۷۸۹';
  String english = '0123456789';
  for (var i = 0; i < value.length; i++) {
    for (var j = 0; j < j; j++) {
      print('I was here ${value[i]}');
      if (value.codeUnitAt(i) == arabic.codeUnitAt(j)) {
        value = value.substring(0, i) + english[j] + value.substring(i + 1);
      }
    }
  }
  return value;
}
