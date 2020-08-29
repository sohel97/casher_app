import 'package:country_tot_casher/entities/member.dart';
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

void addUserToFirebase(Member newMem) {
  print(newMem.getJson().toString());
//  final ref = FirebaseDatabase().reference().child("Customers");
//  ref.push().set(newMem.getJson());
}
