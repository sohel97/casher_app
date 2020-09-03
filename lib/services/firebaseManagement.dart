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

void editUserToFirebase(Member member) {
  //TODO: Edit user
}

bool authenticateWithFirebase(String text) {
  if (text.hashCode == '1234'.hashCode) {
    return true;
  }
  return false;
}

List<Member> getAllMembers() {
  Member first = new Member();
  Member second = new Member();
  Member third = new Member();
  List<Member> members = new List<Member>();
  first.firstName = "سهيل";
  first.lastName = "كنعان";
  first.phoneNumber = "0524707081";
  first.city = 'Tamra';
  first.gender = Gender.male;
  first.currentWeight = 120;
  first.requestedWeight = 100;
  first.height = 190;
  first.birthDate = DateTime.now();
  first.membershipStartDate = DateTime.now();
  first.membershipEndDate = DateTime.now();
  first.idNumber = '318303898';
  first.paymentRecords.add(PaymentRecord(
      requestedPrice: 0, paidPrice: 0, note: '', dateTime: DateTime.now()));
  first.currentBalance = 0;
  first.healthCareApproval = true;

  second.firstName = "امير";
  second.lastName = "ابو غنيم";
  second.phoneNumber = "052456481";
  second.city = 'Rahat';
  second.gender = Gender.male;
  second.currentWeight = 81;
  second.requestedWeight = 70;
  second.height = 175;
  second.birthDate = DateTime.now();
  second.membershipStartDate = DateTime.now();
  second.membershipEndDate = DateTime.now();
  second.idNumber = '2018845631';
  second.paymentRecords.add(PaymentRecord(
      requestedPrice: 0, paidPrice: 0, note: '', dateTime: DateTime.now()));
  second.currentBalance = 0;
  second.healthCareApproval = false;

  third.firstName = "ميري";
  third.lastName = "ريجف";
  third.phoneNumber = "0524606581";
  third.city = 'Tel Aviv';
  third.gender = Gender.female;
  third.currentWeight = 65;
  third.requestedWeight = 55;
  third.height = 165;
  third.birthDate = DateTime.now();
  third.membershipStartDate = DateTime.now();
  third.membershipEndDate = DateTime.now();
  third.idNumber = '25831262';
  third.paymentRecords.add(PaymentRecord(
      requestedPrice: 0, paidPrice: 0, note: '', dateTime: DateTime.now()));
  third.currentBalance = 0;
  third.healthCareApproval = true;

  members.add(first);
  members.add(second);
  members.add(third);
  members.add(first);
  members.add(second);
  members.add(third);
  members.add(first);

  return members;
}
