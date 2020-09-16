import 'package:country_tot_casher/services/calculations.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/cupertino.dart';

abstract class HistoryRecord {
  DateTime firebaseDate;
  String firebaseTitle;
  String firebaseNote;
  String firebaseType;

  String getRecordDate() {
    return convertDate(firebaseDate);
  }

  String getKey() {
    var key = firebaseDate.year.toString() +
        "|" +
        firebaseDate.month.toString() +
        "|" +
        firebaseDate.day.toString() +
        "|" +
        firebaseDate.hour.toString() +
        "|" +
        firebaseDate.minute.toString() +
        "|" +
        firebaseDate.second.toString();
    return key;
  }

  getNote();
  getTitle();
  getType();
  getJson() {
    return {
      "note": getNote(),
      "title": getTitle(),
      "type": getType(),
      "dateTime": this.firebaseDate.toString()
    };
  }
}

class Record extends HistoryRecord {
  Record.fromRecord(var json) {
    this.firebaseNote = json["note"];
    this.firebaseTitle = json["title"];
    this.firebaseType = json["type"];
    this.firebaseDate = DateTime.parse(json["dateTime"]);
  }

  @override
  getNote() {
    return this.firebaseNote;
  }

  @override
  getTitle() {
    return this.firebaseTitle;
  }

  @override
  getType() {
    return this.firebaseType;
  }
}

class PaymentRecord extends HistoryRecord {
  int paidPrice;
  String note;

  PaymentRecord({
    int paidPrice = 0,
    String note = '',
  }) {
    this.paidPrice = paidPrice;
    this.firebaseNote = note;
    this.firebaseDate = DateTime.now();
  }

  @override
  getNote() {
    return this.firebaseNote;
  }

  @override
  getTitle() {
    String title = sPaidPrice;
    title += ":";
    title += paidPrice.toString();
    this.firebaseTitle = title;
    return firebaseTitle;
  }

  @override
  getType() {
    this.firebaseType = sPaymentRecord;
    return this.firebaseType;
  }
}

class SubscriptionRecord extends HistoryRecord {
  DateTime startDate;
  DateTime endDate;
  String note;
  int requestedPrice;
  int paidPrice;
  bool isNewMember;

  SubscriptionRecord({
    @required DateTime startDate,
    @required DateTime endDate,
    @required String note,
    @required int requestedPrice,
    @required int paidPrice,
    @required bool isNewMember,
  }) {
    this.startDate = startDate;
    this.endDate = endDate;
    this.note = note;
    this.requestedPrice = requestedPrice;
    this.paidPrice = paidPrice;
    this.isNewMember = isNewMember;
    this.firebaseDate = DateTime.now();
  }

  @override
  getNote() {
    String subtitle = sMembershipStartDate;
    subtitle += ":";
    subtitle += convertDate(startDate);
    subtitle += ", ";
    subtitle += sMembershipEndfDate;
    subtitle += ":";
    subtitle += convertDate(endDate);
    subtitle += (note != '' ? "\n$note" : note);
    this.firebaseNote = subtitle;
    return this.firebaseNote;
  }

  @override
  getTitle() {
    String title = sRequestedPrice;
    title += ":";
    title += requestedPrice.toString();
    title += ", ";
    title += sPaidPrice;
    title += ":";
    title += paidPrice.toString();
    this.firebaseTitle = title;
    return firebaseTitle;
  }

  @override
  getType() {
    firebaseType =
        (isNewMember ? sNewSubscriptionRecord : sRenewSubscriptionRecord);
    return firebaseType;
  }
}

class PointsUseRecord extends HistoryRecord {
  int pointsBalance;
  int usedPoints;
  String firebaseNote;

  PointsUseRecord({
    @required pointsBalance,
    @required usedPoints,
    @required note,
  }) {
    this.pointsBalance = pointsBalance;
    this.usedPoints = usedPoints;
    this.firebaseNote = note;
    this.firebaseDate = DateTime.now();
  }

  @override
  getNote() {
    return this.firebaseNote;
  }

  @override
  getTitle() {
    String title = sRemainingPointsBalance;
    title += ":";
    title += (pointsBalance - usedPoints).toString();
    title += ", ";
    title += sUsedPoints;
    title += ":";
    title += usedPoints.toString();
    this.firebaseTitle = title;
    return this.firebaseTitle;
  }

  @override
  getType() {
    this.firebaseType = sUsePoints;
    return this.firebaseType;
  }
}

class FreezeMembershipRecord extends HistoryRecord {
  FreezeMembershipRecord({
    @required note,
  }) {
    this.firebaseTitle = note;
    this.firebaseDate = DateTime.now();
    this.firebaseNote = ' ';
    this.firebaseType = sFreezeMembershipAlert;
  }

  @override
  getNote() {
    return firebaseNote;
  }

  @override
  getTitle() {
    return this.firebaseTitle;
  }

  @override
  getType() {
    return this.firebaseType;
  }
}

class unfreezeMembershipRecord extends HistoryRecord {
  unfreezeMembershipRecord({
    @required note,
  }) {
    this.firebaseTitle = note;
    this.firebaseDate = DateTime.now();
    this.firebaseNote = ' ';
    this.firebaseType = sUNFreezeMembershipAlert;
  }

  @override
  getNote() {
    return firebaseNote;
  }

  @override
  getTitle() {
    return this.firebaseTitle;
  }

  @override
  getType() {
    return this.firebaseType;
  }
}

class CompensationRecord extends HistoryRecord {
  int compensationDays;
  int compensationMonths;
  CompensationRecord({
    @required note,
  }) {
    this.compensationDays = 0;
    this.compensationMonths = 0;
    this.firebaseTitle = note;
    this.firebaseDate = DateTime.now();
    this.firebaseNote = ' ';
    this.firebaseType = sCompensation;
  }

  @override
  getNote() {
    return firebaseNote;
  }

  @override
  getTitle() {
    String title = sCompensationDays;
    title += ': ' + this.compensationDays.toString();
    title +=
        ' , ' + sCompensationMonths + ': ' + this.compensationMonths.toString();
    this.firebaseTitle = title;
    return this.firebaseTitle;
  }

  @override
  getType() {
    return this.firebaseType;
  }
}
