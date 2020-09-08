import 'package:country_tot_casher/entities/HistoryRecord.dart';
import 'package:country_tot_casher/entities/Member.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/services/validators.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';
import '../reusable_card.dart';

void renewAlert({context, Member member}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return RenewMembershipRecordAlert(member: member);
      });
}

class RenewMembershipRecordAlert extends StatefulWidget {
  final Member member;

  RenewMembershipRecordAlert({this.member});

  @override
  _RenewMembershipRecordAlertState createState() =>
      _RenewMembershipRecordAlertState();
}

class _RenewMembershipRecordAlertState
    extends State<RenewMembershipRecordAlert> {
  int pointsToUse = 0;
  SubscriptionRecord subscriptionRecord = new SubscriptionRecord(
    startDate: DateTime.now(),
    endDate: DateTime.now(),
    note: "",
    requestedPrice: 0,
    paidPrice: 0,
    isNewMember: false,
  );

  int periodToAdd = 1;

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
            ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    sPeriodToAdd,
                    style: kLabelTextStyle,
                  ),
                  Text(
                    periodToAdd.toString(),
                    style: kNumberTextStyle,
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xFF8D8E98),
                      activeTrackColor: Colors.white,
                      thumbColor: kButtonsColor,
                      overlayColor: Color(0x29EC801A),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Slider(
                      value: periodToAdd.toDouble(),
                      min: 1,
                      max: 12,
                      onChanged: (double newValue) {
                        setState(() {
                          periodToAdd = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: new TextFormField(
                validator: numberFieldValidator,
                textAlign: TextAlign.right,
                onChanged: (text) {
                  subscriptionRecord.requestedPrice = int.parse(text);
                },
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: sRequestedPrice,
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: new TextFormField(
                validator: numberFieldValidator,
                textAlign: TextAlign.right,
                onChanged: (text) {
                  subscriptionRecord.paidPrice = int.parse(text);
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
                  subscriptionRecord.note = text;
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
                        widget.member.updateMembership(periodToAdd);
                        widget.member.updateBalance(
                          subscriptionRecord.paidPrice,
                          subscriptionRecord.requestedPrice,
                        );

                        //Update the record
                        subscriptionRecord.startDate =
                            widget.member.membershipStartDate;
                        subscriptionRecord.endDate =
                            widget.member.membershipEndDate;
                        subscriptionRecord.update();
                        print(subscriptionRecord.endDate.toUtc().toString());
                        print(
                            widget.member.membershipEndDate.toUtc().toString());
                        widget.member.history.add(new Record(
                          note: subscriptionRecord.note,
                          title: subscriptionRecord.title,
                          type: subscriptionRecord.type,
                          date: subscriptionRecord.date,
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
