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
  int currentBalance = 0;
  bool healthCareApproval;

  Member() {
    this.paymentRecords = new List<PaymentRecord>();
    this.height = 180;
    this.currentWeight = 80;
    this.requestedWeight = 80;
    this.gender = Gender.male;
  }

  Member.fromMember(var json) {
    this.paymentRecords = new List<PaymentRecord>();
    this.firstName = json["firstName"];
    this.lastName = json["lastName"];
    this.phoneNumber = json["phoneNumber"];
    this.city = json["city"];
    if (json["gender"] == "male")
      this.gender = Gender.male;
    else
      this.gender = Gender.female;
    this.currentWeight = json["currentWeight"];
    this.requestedWeight = json["requestedWeight"];
    this.height = json["height"];
    this.birthDate = DateTime.parse(json["birthDate"]);
    this.membershipStartDate = DateTime.parse(json["membershipStartDate"]);
    print(this.membershipStartDate);
    this.membershipEndDate = DateTime.parse(json["membershipEndDate"]);
    this.idNumber = json["idNumber"];
    this.currentBalance = json["currentBalance"];
    this.healthCareApproval = json["healthCareApproval"];
    var records = json["records"];
    Map<String, dynamic> mapOfMaps = Map.from(records);

    mapOfMaps.values.forEach((value) {
      paymentRecords.add(PaymentRecord.fromPaymentRecord(Map.from(value)));
    });
  }
  getJson() {
    var jsn = {
      "idNumber": this.idNumber,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "phoneNumber": this.phoneNumber,
      "city": this.city,
      "gender": this.gender.toString().substring(7),
      "currentWeight": this.currentWeight,
      "requestedWeight": this.requestedWeight,
      "height": this.height,
      "birthDate": this.birthDate.toString(),
      "membershipStartDate": this.membershipStartDate.toString(),
      "membershipEndDate": this.membershipEndDate.toString(),
      "healthCareApproval": this.healthCareApproval,
      "currentBalance": this.currentBalance
    };
    var paymentRecords = {};
    for (var i = 0; i < this.paymentRecords.length; i++) {
      var currPayRec = this.paymentRecords[i];
      paymentRecords[currPayRec.getKey()] = currPayRec.getJson();
    }
    jsn["records"] = paymentRecords;
    return jsn;
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
    if (this.membershipEndDate.isBefore(DateTime.now())) {
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

  getKey() {
    var key = dateTime.year.toString() +
        "|" +
        dateTime.month.toString() +
        "|" +
        dateTime.day.toString() +
        "|" +
        dateTime.hour.toString() +
        "|" +
        dateTime.minute.toString() +
        "|" +
        dateTime.second.toString();
    return key;
  }

  getJson() {
    return {
      "note": this.note,
      "requestedPrice": this.requestedPrice,
      "paidPrice": this.paidPrice,
      "balance": this.balance,
      "dateTime": this.dateTime.toString()
    };
  }

  PaymentRecord.fromPaymentRecord(var json) {
    this.note = json["note"];
    this.requestedPrice = json["requestedPrice"];
    this.paidPrice = json["paidPrice"];
    this.balance = json["balance"];
    this.dateTime = DateTime.parse(json["dateTime"]);
  }

  PaymentRecord clone(PaymentRecord paymentRecord) {
    this.note = paymentRecord.note;
    this.requestedPrice = paymentRecord.requestedPrice;
    this.paidPrice = paymentRecord.paidPrice;
  }
}
