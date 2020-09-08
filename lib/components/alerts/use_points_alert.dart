import 'package:country_tot_casher/entities/HistoryRecord.dart';
import 'package:country_tot_casher/entities/Member.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/material.dart';

void usePointsAlert({context, Member member}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return UsePointsRecordAlert(member: member);
      });
}

class UsePointsRecordAlert extends StatefulWidget {
  final Member member;

  UsePointsRecordAlert({this.member});

  @override
  _UsePointsRecordAlertState createState() => _UsePointsRecordAlertState();
}

class _UsePointsRecordAlertState extends State<UsePointsRecordAlert> {
  PointsUseRecord pointsUseRecord =
      new PointsUseRecord(pointsBalance: 0, usedPoints: 0, note: '');
  @override
  Widget build(BuildContext context) {
    final _proccedKey = GlobalKey<FormState>();
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Form(
        key: _proccedKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                validator: (value) {
                  try {
                    if (value.isEmpty) {
                      return sPleaseEnterText;
                    }
                    var val = int.parse(value);
                    if (val > widget.member.earnedCredits) {
                      return sPointsNotEnough;
                    }
                  } catch (e) {
                    return sPleaseEnterValidNumber;
                  }
                  return null;
                },
                textAlign: TextAlign.right,
                decoration: new InputDecoration(
                  labelText: sUsePoints,
                ),
                onChanged: (text) {
                  pointsUseRecord.usedPoints = int.parse(text);
                },
                keyboardType: TextInputType.number,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: new TextFormField(
                textAlign: TextAlign.right,
                onChanged: (text) {
                  pointsUseRecord.note = text;
                },
                decoration: new InputDecoration(
                  labelText: sNotes,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text(sSave),
                    onPressed: () {
                      if (_proccedKey.currentState.validate()) {
                        pointsUseRecord.pointsBalance =
                            widget.member.earnedCredits;

                        widget.member.earnedCredits -=
                            pointsUseRecord.usedPoints;

                        pointsUseRecord.update();

                        widget.member.history.add(new Record(
                          note: pointsUseRecord.note,
                          title: pointsUseRecord.title,
                          type: pointsUseRecord.type,
                          date: pointsUseRecord.date,
                        ));
                        editUserFromFirebase(widget.member);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    color: Colors.redAccent,
                    child: Text(sCancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
