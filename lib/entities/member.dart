import 'package:country_tot_casher/services/calculations.dart';

enum Gender {
  male,
  female,
}

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
  int currentBalance;
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
    output += "remainingPayment:\t${this.currentBalance}\n";
    output += "healthCareApproval:\t${this.healthCareApproval}\n";
    return output;
  }

  void updateBalance(PaymentRecord paymentRecord) {
    print(paymentRecord.requestedPrice);
    print(paymentRecord.paidPrice);
    this.currentBalance +=
        paymentRecord.paidPrice - paymentRecord.requestedPrice;
  }

  void updateMembership(int periodToAdd) {
    if (compareDateTime(this.membershipEndDate, DateTime.now()) == -1) {
      this.membershipStartDate = DateTime.now();
      this.membershipEndDate = DateTime(DateTime.now().year,
          DateTime.now().month + periodToAdd, DateTime.now().day);
    } else {
      this.membershipEndDate = DateTime(
          this.membershipEndDate.year,
          this.membershipEndDate.month + periodToAdd,
          this.membershipEndDate.day);
    }
  }
}

class PaymentRecord {
  int balance = 0;
  int requestedPrice = 0;
  int paidPrice = 0;
  String note = '';
  DateTime dateTime = DateTime.now();
  PaymentRecord(
      {this.note,
      this.requestedPrice,
      this.paidPrice,
      this.balance,
      this.dateTime}) {}

  String toString() {
    return "requestedPrice=${this.requestedPrice}\n paidPrice=${this.paidPrice}\n note=$note";
  }

  PaymentRecord clone(PaymentRecord paymentRecord) {
    this.note = paymentRecord.note;
    this.requestedPrice = paymentRecord.requestedPrice;
    this.paidPrice = paymentRecord.paidPrice;
  }
}
