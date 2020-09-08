import 'package:country_tot_casher/services/calculations.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/cupertino.dart';

abstract class HistoryRecord {
  DateTime date;
  String title;
  String note;
  String type;

  void setRecordType();
  void setRecordTitle();
  void setRecordSubtitle();

  void update() {
    setRecordTitle();
    setRecordSubtitle();
  }

  String getRecordDate() {
    return convertDate(date);
  }

  String getKey() {
    var key = date.year.toString() +
        "|" +
        date.month.toString() +
        "|" +
        date.day.toString() +
        "|" +
        date.hour.toString() +
        "|" +
        date.minute.toString() +
        "|" +
        date.second.toString();
    return key;
  }

  getJson() {
    return {
      "note": this.note,
      "title": this.title,
      "type": this.type,
      "dateTime": this.date.toString()
    };
  }
}

class Record extends HistoryRecord {
  Record({String note, String title, String type, DateTime date}) {
    this.note = note;
    this.title = title;
    this.type = type;
    this.date = date;
  }

  @override
  void setRecordSubtitle() {}

  @override
  void setRecordTitle() {}

  @override
  void setRecordType() {}

  Record.fromRecord(var json) {
    this.note = json["note"];
    this.title = json["title"];
    this.type = json["type"];
    this.date = DateTime.parse(json["dateTime"]);
  }
}

class PaymentRecord extends HistoryRecord {
  int paidPrice;
  String note;

  PaymentRecord({
    @required paidPrice,
    @required note,
  }) {
    this.paidPrice = paidPrice;
    this.note = note;
    this.date = DateTime.now();
    setRecordSubtitle();
    setRecordTitle();
    setRecordType();
  }

  @override
  setRecordSubtitle() {
    this.note = note;
  }

  @override
  setRecordTitle() {
    title = sPaidPrice;
    title += ":";
    title += paidPrice.toString();
    this.title = title;
  }

  @override
  setRecordType() {
    this.type = sPaymentRecord;
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
    this.date = DateTime.now();
    setRecordType();
    setRecordTitle();
  }

  @override
  void setRecordSubtitle() {
    String subtitle = sMembershipStartDate;
    subtitle += ":";
    subtitle += convertDate(startDate);
    subtitle += ", ";
    subtitle += sMembershipEndfDate;
    subtitle += ":";
    subtitle += convertDate(endDate);
    subtitle += (note != '' ? "\n$note" : note);
    this.note = subtitle;
  }

  @override
  void setRecordTitle() {
    String title = sRequestedPrice;
    title += ":";
    title += requestedPrice.toString();
    title += ", ";
    title += sPaidPrice;
    title += ":";
    title += paidPrice.toString();
    this.title = title;
  }

  @override
  void setRecordType() {
    this.type = isNewMember ? sNewSubscriptionRecord : sRenewSubscriptionRecord;
  }
}

class PointsUseRecord extends HistoryRecord {
  int pointsBalance;
  int usedPoints;
  String note;

  PointsUseRecord({
    @required pointsBalance,
    @required usedPoints,
    @required note,
  }) {
    this.pointsBalance = pointsBalance;
    this.usedPoints = usedPoints;
    this.note = note;
    this.date = DateTime.now();
    setRecordSubtitle();
    setRecordTitle();
    setRecordType();
  }

  @override
  void setRecordSubtitle() {
    this.note = note;
  }

  @override
  void setRecordTitle() {
    String title = sRemainingPointsBalance;
    title += ":";
    title += (pointsBalance - usedPoints).toString();
    title += ", ";
    title += sUsedPoints;
    title += ":";
    title += usedPoints.toString();
    this.title = title;
  }

  @override
  void setRecordType() {
    this.type = sUsePoints;
  }
}
