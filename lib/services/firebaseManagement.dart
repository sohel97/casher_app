import 'dart:math';

import 'package:country_tot_casher/entities/member.dart';
import 'package:country_tot_casher/screens/addMemberPage.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future<bool> addNewMember(
    DatabaseReference databaseReference, Member newMember) async {
  DataSnapshot snapshot = await databaseReference.once();
  databaseReference.push().set(newMember.getJson());
  if (snapshot.value == null) {
    print("Member Not exist!");
  } else {
    print("Member Already exist!");
  }
  return snapshot.value != null;
}

void addUserToFirebase(
    Gender selectedGender,
    int height,
    int currentWeight,
    int requestedWeight,
    int birthdayDay,
    int birthdayMonth,
    int birthdayYear,
    String firstName,
    String lastName,
    String city,
    String phoneNumber,
    int perioToAdd,
    String id) {
  var newMem = new Member(
      firstName,
      lastName,
      phoneNumber,
      city,
      selectedGender.toString(),
      currentWeight,
      requestedWeight,
      height,
      new DateTime(birthdayYear, birthdayMonth, birthdayDay),
      DateTime.now(),
      new DateTime(DateTime.now().year, DateTime.now().month + perioToAdd,
          DateTime.now().day),
      id);

  final ref = FirebaseDatabase().reference().child("Customers");
  ref.push().set(newMem.getJson());
}

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

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
