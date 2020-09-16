import 'package:country_tot_casher/entities/HistoryRecord.dart';
import 'package:country_tot_casher/entities/Member.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/services/validators.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';

CompensationAlert({BuildContext context, Member member}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CompensationRecordAlert(member: member);
      });
}

class CompensationRecordAlert extends StatefulWidget {
  final Member member;

  CompensationRecordAlert({this.member});

  @override
  _CompensationRecordAlert createState() => _CompensationRecordAlert();
}

class _CompensationRecordAlert extends State<CompensationRecordAlert> {
  CompensationRecord record = new CompensationRecord(note: '');
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
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Directionality(
              textDirection: appDirection,
              child: new TextFormField(
                textAlign: TextAlign.right,
                onChanged: (text) {
                  record.compensationDays = int.parse(text);
                },
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: sDays,
                ),
              ),
            ),
            Directionality(
              textDirection: appDirection,
              child: new TextFormField(
                textAlign: TextAlign.right,
                onChanged: (text) {
                  record.compensationMonths = int.parse(text);
                },
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: sMonths,
                ),
              ),
            ),
            Directionality(
              textDirection: appDirection,
              child: new TextFormField(
                textAlign: TextAlign.right,
                onChanged: (text) {
                  record.firebaseNote = text;
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
                        widget.member.history.add(record);
                        widget.member.updateMembership(
                          monthsToAdd: record.compensationMonths,
                          daysToAdd: record.compensationDays,
                        );
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
