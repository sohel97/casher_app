/*----------------------------------------------------------------------------\
|
|  Module Details: Calculations
|
|  Name:     calculations.dart
|
|  Purpose:  all general calculation functions
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  04-Sep-20 Alpha    Sohel   $$1     Created
/----------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------\
| Function: calculateAge::calculations
| Purpose: Get Age based on DateTime birthDate
| Input: DateTime birthDate
| Output:  age
\---------------------------------------------------------------------------*/
int calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

/*---------------------------------------------------------------------------\
| Function: convertDate::calculations
| Purpose: Get date as string
| Input: DateTime date
| Output:  String with this format DD/MM/YYYY
\---------------------------------------------------------------------------*/
String convertDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}
