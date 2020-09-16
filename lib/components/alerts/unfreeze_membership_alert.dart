import 'package:country_tot_casher/entities/HistoryRecord.dart';
import 'package:country_tot_casher/entities/Member.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/services/validators.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';

unfreezeMembershipAlert({BuildContext context, Member member}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return unfreezeMembershipRecordAlert(member: member);
      });
}

class unfreezeMembershipRecordAlert extends StatefulWidget {
  final Member member;

  unfreezeMembershipRecordAlert({this.member});

  @override
  _unfreezeMembershipRecordAlertState createState() =>
      _unfreezeMembershipRecordAlertState();
}

class _unfreezeMembershipRecordAlertState
    extends State<unfreezeMembershipRecordAlert> {
  unfreezeMembershipRecord record = new unfreezeMembershipRecord(note: '');

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
                        widget.member.membershipEndDate
                            .add(new Duration(days: widget.member.freezedDays));
                        widget.member.freezedDays = 0;
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
