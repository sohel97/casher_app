import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HistoryRecord.dart';

enum Gender {
  male,
  female,
}
enum MembersJob { Participant, Planner }

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
  int freezedDays;
  MembersJob membersJob;

  Member() {
    this.membersJob = MembersJob.Participant;
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
    this.freezedDays = 0;
  }

  Member.fromMember(var json) {
    this.membersJob = json["membersJob"] == "MembersJob.Participant"
        ? MembersJob.Participant
        : MembersJob.Planner;
    this.history = new List<HistoryRecord>();
    this.firstName = json["firstName"];
    this.lastName = json["lastName"];
    this.phoneNumber = json["phoneNumber"];
    this.city = json["city"];
    this.gender = (json["gender"] == "male") ? Gender.male : Gender.female;
    this.idNumber = json["idNumber"];
    this.birthDate = DateTime.parse(json["birthDate"]);

    if (membersJob == MembersJob.Participant) {
      this.currentWeight = json["currentWeight"];
      this.requestedWeight = json["requestedWeight"];
      this.height = json["height"];
      this.membershipStartDate = DateTime.parse(json["membershipStartDate"]);
      this.membershipEndDate = DateTime.parse(json["membershipEndDate"]);

      this.currentBalance = json["currentBalance"];
      this.healthCareApproval = json["healthCareApproval"];
      this.earnedCredits = json["earnedCredit"];
      this.freezedDays = json["freezedDays"];

      var records = json["records"];
      Map<String, dynamic> mapOfMaps = Map.from(records);

      mapOfMaps.values.forEach((value) {
        history.add(new Record.fromRecord(Map.from(value)));
      });
    }
  }

  calculateBMI() {
    this.bmi =
        (this.currentWeight / ((this.height / 100) * (this.height / 100)))
            .toStringAsFixed(1);
  }

  getJson() {
    var jsn = this.membersJob == MembersJob.Participant
        ? {
            "idNumber": this.idNumber,
            "firstName": this.firstName,
            "lastName": this.lastName,
            "membersJob": this.membersJob.toString(),
            "phoneNumber": this.phoneNumber,
            "city": this.city,
            "gender": this.gender.toString().substring(7),
            "birthDate": this.birthDate.toString(),
            "currentWeight": this.currentWeight,
            "requestedWeight": this.requestedWeight,
            "height": this.height,
            "membershipStartDate": this.membershipStartDate.toString(),
            "membershipEndDate": this.membershipEndDate.toString(),
            "healthCareApproval": this.healthCareApproval,
            "currentBalance": this.currentBalance,
            "earnedCredit": this.earnedCredits,
            "freezedDays": this.freezedDays,
          }
        : {
            "idNumber": this.idNumber,
            "firstName": this.firstName,
            "lastName": this.lastName,
            "membersJob": this.membersJob.toString(),
            "phoneNumber": this.phoneNumber,
            "city": this.city,
            "gender": this.gender.toString().substring(7),
            "birthDate": this.birthDate.toString()
          };

    if (this.membersJob == MembersJob.Participant) {
      var paymentRecords = {};
      for (var i = 0; i < this.history.length; i++) {
        var currPayRec = this.history[i];
        paymentRecords[currPayRec.getKey()] = currPayRec.getJson();
      }
      jsn["records"] = paymentRecords;
    }
    return jsn;
  }

  void updateBalance({@required int paidPrice, @required int requestedPrice}) {
    this.currentBalance += paidPrice - requestedPrice;
    this.earnedCredits += (paidPrice / 10).round();
  }

  void updateMembership({int monthsToAdd = 0, int daysToAdd = 0}) {
    if (this.membershipEndDate.isBefore(DateTime.now())) {
      this.membershipStartDate = DateTime.now();
      this.membershipEndDate = DateTime(DateTime.now().year,
          DateTime.now().month + monthsToAdd, DateTime.now().day + daysToAdd);
    } else {
      this.membershipEndDate = DateTime(
          this.membershipEndDate.year,
          this.membershipEndDate.month + monthsToAdd,
          this.membershipEndDate.day + daysToAdd);
    }
  }
}
