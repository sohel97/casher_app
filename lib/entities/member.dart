import 'package:country_tot_casher/screens/addMemberPage.dart';

class Member {
  String firstName;
  String lastName;
  String phoneNumber;
  String city;
  Gender gender;
  int currentWeight;
  int requestedWeight;
  int height;
  DateTime birthDate;
  DateTime membershipStartDate;
  DateTime membershipEndDate;
  String idNumber;
  List<PaymentRecord> paymentRecords;
  int remainingPayment;
  bool healthCareApproval;

  Member() {
    this.paymentRecords = new List<PaymentRecord>();
    this.height = 180;
    this.currentWeight = 80;
    this.requestedWeight = 80;
    this.gender = Gender.male;
  }

  getJson() {
    return {
      "idNumber": this.idNumber,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "phoneNumber": this.phoneNumber,
      "city": this.city,
      "gender": this.gender.toString().substring(7),
      "currentWeight": this.currentWeight,
      "requestedWeight": this.requestedWeight,
      "height": this.height,
      "birthDate": this.birthDate,
      "membershipStartDate": this.membershipStartDate.toString(),
      "membershipEndDate": this.membershipEndDate.toString()
    };
  }

  String toString() {
    String output = "FirstName:\t${this.firstName}\n";
    output += "LastName:\t${this.lastName}\n";
    output += "IdNumber:\t${this.idNumber}\n";
    output += "PhoneNumber:\t${this.phoneNumber}\n";
    output += "City:\t${this.city}\n";
    output += "Gender:\t${this.gender.toString().substring(7)}\n";
    output += "CurrentWeight:\t${this.currentWeight}\n";
    output += "RequestedWeight:\t${this.requestedWeight}\n";
    output +=
        "birthDate:\t${this.birthDate.day}/${this.birthDate.month}/${this.birthDate.year}\n";
    output +=
        "MembershipStartDate:\t${this.membershipStartDate.day}/${this.membershipStartDate.month}/${this.membershipStartDate.year}\n";
    output +=
        "membershipEndfDate:\t${this.membershipEndDate.day}/${this.membershipEndDate.month}/${this.membershipEndDate.year}\n";
    for (var paymentRecord in paymentRecords) {
      output += "paymentRecord:\t${paymentRecord.toString()}\n";
    }
    output += "remainingPayment:\t${this.remainingPayment}\n";
    output += "healthCareApproval:\t${this.healthCareApproval}\n";
    return output;
  }
}

class PaymentRecord {
  int requestedPrice;
  int paidPrice;
  String note;

  PaymentRecord({this.note, this.requestedPrice, this.paidPrice});

  String toString() {
    return "requestedPrice=${this.requestedPrice}\n paidPrice=${this.paidPrice}\n note=$note";
  }
}
