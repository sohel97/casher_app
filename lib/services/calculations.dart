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

String convertDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

/*---------------------------------------------------------------------------\
| Function: compareDateTime::calculations
| Purpose: check which date is bigger
| Input: DateTime first, DateTime second
| Output:  -1 if second date is bigger return 1 if not
\---------------------------------------------------------------------------*/
int compareDateTime(DateTime first, DateTime second) {
  int year = first.year - second.year;
  int month = first.month - second.month;
  int day = first.day - second.day;

  if (year < 0 ||
      (year == 0 && month < 0) ||
      (year == 0 && month == 0 && day < 0)) {
    return -1;
  } else
    return 1;
}
