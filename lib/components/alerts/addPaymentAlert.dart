import 'package:country_tot_casher/entities/HistoryRecord.dart';
import 'package:country_tot_casher/entities/Member.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/services/validators.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

addPaymentAlert({context, Member member}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddPaymentRecordAlert(member: member);
      });
}

class AddPaymentRecordAlert extends StatefulWidget {
  final Member member;

  AddPaymentRecordAlert({this.member});

  @override
  _AddPaymentRecordAlertState createState() => _AddPaymentRecordAlertState();
}

class _AddPaymentRecordAlertState extends State<AddPaymentRecordAlert> {
  PaymentRecord paymentRecord = new PaymentRecord(paidPrice: 0, note: '');
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
              child: new TextFormField(
                validator: numberFieldValidator,
                textAlign: TextAlign.right,
                onChanged: (text) {
                  paymentRecord.paidPrice = int.parse(text);
                },
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: sPaidPrice,
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: new TextFormField(
                textAlign: TextAlign.right,
                onChanged: (text) {
                  paymentRecord.note = text;
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
                        //Update the member
                        widget.member.updateBalance(
                          paymentRecord.paidPrice,
                          0,
                        );
                        paymentRecord.update();
                        widget.member.history.add(new Record(
                          note: paymentRecord.note,
                          title: paymentRecord.title,
                          type: paymentRecord.type,
                          date: paymentRecord.date,
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
