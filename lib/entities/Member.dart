import 'HistoryRecord.dart';

enum Gender {
  male,
  female,
}

class Member {
  Gender gender;
  DateTime birthDate;
  DateTime membershipStartDate;
  DateTime membershipEndDate;
  List<HistoryRecord> history;
  String firstName;
  String lastName;
  String phoneNumber;
  String city;
  String idNumber;
  String bmi;
  int currentWeight;
  int requestedWeight;
  int height;
  int earnedCredits;
  int currentBalance;
  bool healthCareApproval;

  Member() {
    this.history = new List<HistoryRecord>();
    this.firstName = '';
    this.lastName = '';
    this.phoneNumber = '';
    this.city = '';
    this.idNumber = '';
    this.currentWeight = 80;
    this.requestedWeight = 80;
    this.height = 180;
    this.earnedCredits = 0;
    this.currentBalance = 0;
    this.bmi = calculateBMI();
    this.gender = Gender.male;
    this.healthCareApproval = false;
    this.birthDate = DateTime.now();
    //TODO: delete the field below
    this.membershipStartDate = DateTime.now();
    this.membershipEndDate = DateTime.now();
    history.add(PaymentRecord(
      paidPrice: 250,
      note: "cash",
    ));
    history.add(SubscriptionRecord(
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      note: 'he paid in cash',
      requestedPrice: 300,
      paidPrice: 200,
      isNewMember: true,
    ));
    history.add(SubscriptionRecord(
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      note: 'he paid in cash',
      requestedPrice: 300,
      paidPrice: 200,
      isNewMember: false,
    ));
    history.add(PointsUseRecord(
      pointsBalance: 500,
      usedPoints: 300,
      note: 'coupon',
    ));
    history.add(PaymentRecord(
      paidPrice: 100,
      note: "cash",
    ));
  }

  Member.fromMember(var json) {
    this.history = new List<PaymentRecord>();
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
      history.add(Record.fromRecord(Map.from(value)));
    });
  }

  calculateBMI() {
    this.bmi =
        (this.currentWeight / ((this.height / 100) * (this.height / 100)))
            .toStringAsFixed(1);
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
    for (var i = 0; i < this.history.length; i++) {
      var currPayRec = this.history[i];
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
    for (var paymentRecord in history) {
      output += "paymentRecord:\t${paymentRecord.toString()}\n";
    }
    output += "remainingPayment:\t${this.currentBalance}\n";
    output += "healthCareApproval:\t${this.healthCareApproval}\n";
    return output;
  }

  void updateBalance(int paidPrice, int requestedPrice) {
    this.currentBalance += paidPrice - requestedPrice;
    this.earnedCredits += paidPrice ~/ 10;
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
