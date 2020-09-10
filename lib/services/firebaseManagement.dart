import 'package:country_tot_casher/entities/Member.dart';
import 'package:firebase_database/firebase_database.dart';

import '../entities/Member.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     firebaseManagement.dart
|
|  Purpose:  firebase management.
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
|
/---------------------------------------------------------------------------- */

//TODO: Add documentation in this format to your code Mr. Ameer
//TODO: when you touch a folder please add a comment upside also
/*---------------------------------------------------------------------------\
| Function: textFieldValidator::validators
| Purpose: validate if the is not empty
| Input: Field Value
| Output:  null if its valid otherwise sPleaseEnterText message
\---------------------------------------------------------------------------*/

enum OrderBy { WillExpireSoon, Expired }
final ref = FirebaseDatabase().reference().child("Customers");
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

void addUserToFirebase(Member newMem) {
  ref.child(newMem.idNumber).set(newMem.getJson());
}

void editUserFromFirebase(Member member) {
  //TODO: Edit user
}

void deleteUserFromFirebase(Member member) {
  //TODO: Delete user
}

bool authenticateWithFirebase(String text) {
  //TODO: add password
  if (text.hashCode == '1234'.hashCode) {
    return true;
  }
  return false;
}

Future<List<Member>> getExpiredMembers() {
  print("from get Expires");
  return getAllMembers(orderBy: OrderBy.Expired);
}

Future<List<Member>> getSoonExpireMemberships(int days) {
  print("from getSoonExpireMemberships");
  return getAllMembers(orderBy: OrderBy.WillExpireSoon, days: days);
}

/*
Update: 04/09/2020 12:30 by Ameer
Comments: everything related to the members is inside this function, things
like filtering (expired membership, etc...), and filtering by the search textfield
from membersPage.dart
*/
Future<List<Member>> getAllMembers(
    {OrderBy orderBy, int days, String text = ""}) {
  print("getting members");

  return ref.once().then((DataSnapshot snapshot) {
//    print("the snapshot key ${snapshot.key}");
//    print("the snapshot value ${snapshot.value}");
    List<Member> members = new List<Member>();

    if (snapshot.value != null) {
      Map<String, dynamic> mapOfMaps = Map.from(snapshot.value);

      mapOfMaps.values.forEach((value) {
        members.add(Member.fromMember(Map.from(value)));
      });
    }
    members.sort((a, b) => a.membershipEndDate.compareTo(b.membershipEndDate));
    switch (orderBy) {
      case OrderBy.WillExpireSoon:
        members.sort((a, b) => a.membershipEndDate
            .compareTo(DateTime.now().add(new Duration(days: days))));
        break;

      case OrderBy.Expired:
        members = members
            .where(
                (element) => element.membershipEndDate.isBefore(DateTime.now()))
            .toList();

        break;
    }

    if (text != "") {
      members = members
          .where((element) =>
              element.firstName.contains(text) ||
              element.lastName.contains(text) ||
              element.idNumber.contains(text))
          .toList();
    }
    print("the length:${members.length}");
    return members;
  });
}
