import 'package:flutter/material.dart';

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
  int compensationDays;
  bool healthCareApproval;
  bool isFreezed;

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
    this.membershipStartDate = DateTime.now();
    this.membershipEndDate = DateTime.now();
  }

  Member.fromMember(var json) {
    this.history = new List<HistoryRecord>();
    this.firstName = json["firstName"];
    this.lastName = json["lastName"];
    this.phoneNumber = json["phoneNumber"];
    this.city = json["city"];
    this.gender = (json["gender"] == "male") ? Gender.male : Gender.female;
    this.currentWeight = json["currentWeight"];
    this.requestedWeight = json["requestedWeight"];
    this.height = json["height"];
    this.birthDate = DateTime.parse(json["birthDate"]);
    this.membershipStartDate = DateTime.parse(json["membershipStartDate"]);
    this.membershipEndDate = DateTime.parse(json["membershipEndDate"]);
    this.idNumber = json["idNumber"];
    this.currentBalance = json["currentBalance"];
    this.healthCareApproval = json["healthCareApproval"];
    this.earnedCredits = json["earnedCredit"];
    var records = json["records"];
    Map<String, dynamic> mapOfMaps = Map.from(records);

    mapOfMaps.values.forEach((value) {
      history.add(new Record.fromRecord(Map.from(value)));
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
      "currentBalance": this.currentBalance,
      "earnedCredit": this.earnedCredits
      //TODO  "isFreezed": this.isFreezed
      //TODO  "compensationDays": this.compensationDays
    };
    var paymentRecords = {};
    for (var i = 0; i < this.history.length; i++) {
      var currPayRec = this.history[i];
      paymentRecords[currPayRec.getKey()] = currPayRec.getJson();
    }
    jsn["records"] = paymentRecords;
    return jsn;
  }

  void updateBalance({@required int paidPrice, @required int requestedPrice}) {
    this.currentBalance += paidPrice - requestedPrice;
    this.earnedCredits += (paidPrice / 10).round();
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
