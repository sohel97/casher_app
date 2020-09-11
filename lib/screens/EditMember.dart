import 'package:country_tot_casher/components/HistoryRecordComponent.dart';
import 'package:country_tot_casher/components/alerts/addPaymentAlert.dart';
import 'package:country_tot_casher/components/alerts/procced_alert.dart';
import 'package:country_tot_casher/components/alerts/renew_membership_alert.dart';
import 'package:country_tot_casher/components/alerts/use_points_alert.dart';
import 'package:country_tot_casher/components/bottom_button.dart';
import 'package:country_tot_casher/constants.dart';
import 'package:country_tot_casher/entities/HistoryRecord.dart';
import 'package:country_tot_casher/entities/Member.dart';
import 'package:country_tot_casher/services/calculations.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/services/validators.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditMember extends StatefulWidget {
  final Member member;
  Future<List<Member>> members;
  int index;
  EditMember(this.member, {Key key})
      : super(key: key); //add also..example this.abc,this...
  EditMember.fromEditMember(this.members, this.index, {Key key, this.member})
      : super(key: key); //add also..example this.abc,this...
  @override
  _EditMemberState createState() => _EditMemberState();
}

//TODO refresh the list below after adding money or points.
class _EditMemberState extends State<EditMember> {
  int periodToAdd = 0;
  int birthdayDay;
  int birthdayMonth;
  int birthdayYear;
  final _formKey = GlobalKey<FormState>();
  PaymentRecord debtPaymentRecord = new PaymentRecord(
    paidPrice: 0,
    note: '',
  );
  PaymentRecord newPaymentRecord = new PaymentRecord(
    paidPrice: 0,
    note: '',
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.delete, color: Colors.grey),
            onPressed: () {
              nextAlert(
                  context: context,
                  label: sAreYouSureYouWantToDeleteTheUser,
                  callback: () {
                    deleteUserFromFirebase(widget.member);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
            },
          ),
        ],
        title: Text(sDeleteUserData),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        initialValue: widget.member.lastName,
                        validator: textFieldValidator,
                        textAlign: TextAlign.right,
                        onChanged: (text) {
                          setState(() {
                            widget.member.lastName = text;
                          });
                        },
                        decoration: new InputDecoration(
                          labelText: sLastName,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        initialValue: widget.member.firstName,
                        validator: textFieldValidator,
                        textAlign: TextAlign.right,
                        decoration: new InputDecoration(
                          labelText: sFirstName,
                        ),
                        onChanged: (text) {
                          setState(() {
                            widget.member.firstName = text;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        initialValue: widget.member.phoneNumber,
                        validator: numberFieldValidator,
                        textAlign: TextAlign.right,
                        decoration: new InputDecoration(
                          labelText: sPhoneNumber,
                        ),
                        onChanged: (text) {
                          setState(() {
                            widget.member.phoneNumber = text;
                          });
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        initialValue: widget.member.idNumber,
                        validator: numberFieldValidator,
                        textAlign: TextAlign.right,
                        decoration: new InputDecoration(
                          labelText: sIdNumber,
                        ),
                        onChanged: (text) {
                          setState(() {
                            widget.member.idNumber = text;
                          });
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        initialValue: widget.member.city,
                        validator: textFieldValidator,
                        textAlign: TextAlign.right,
                        decoration: new InputDecoration(
                          labelText: sCity,
                        ),
                        onChanged: (text) {
                          setState(() {
                            widget.member.city = text;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        initialValue: widget.member.birthDate.day.toString(),
                        validator: dayFieldValidator,
                        textAlign: TextAlign.right,
                        decoration: new InputDecoration(
                            labelText: sBirthDateDay, hintText: 'DD'),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            birthdayDay = int.parse(text);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        initialValue: widget.member.birthDate.month.toString(),
                        validator: monthFieldValidator,
                        textAlign: TextAlign.right,
                        decoration: new InputDecoration(
                            labelText: sBirthDateMonth, hintText: 'MM'),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            birthdayMonth = int.parse(text);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        initialValue: widget.member.birthDate.year.toString(),
                        validator: yearFieldValidator,
                        textAlign: TextAlign.right,
                        decoration: new InputDecoration(
                            labelText: sBirthDateYear, hintText: 'YYYY'),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            birthdayYear = int.parse(text);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      sBirthDate,
                      style: kLabelTextStyle,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        initialValue: widget.member.height.toString(),
                        validator: numberFieldValidator,
                        textAlign: TextAlign.right,
                        decoration: new InputDecoration(
                          labelText: sHeight,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            widget.member.height = int.parse(text);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        initialValue: widget.member.requestedWeight.toString(),
                        validator: numberFieldValidator,
                        textAlign: TextAlign.right,
                        decoration: new InputDecoration(
                          labelText: sRequestedWeight,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            widget.member.requestedWeight = int.parse(text);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        initialValue: widget.member.currentWeight.toString(),
                        validator: numberFieldValidator,
                        textAlign: TextAlign.right,
                        decoration: new InputDecoration(
                          labelText: sCurrentWeight,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            widget.member.currentWeight = int.parse(text);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: <Widget>[
                  Checkbox(
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        widget.member.healthCareApproval = value;
                      });
                    },
                    value: widget.member.healthCareApproval,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new Text(
                        sHealthApproval,
                        style: kLargeButtonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            sMembershipEndfDate,
                            style: kLargeButtonTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            convertDate(widget.member.membershipEndDate),
                            style: kLargeButtonTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            sMembershipStartDate,
                            style: kLargeButtonTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            convertDate(widget.member.membershipStartDate),
                            style: kLargeButtonTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            sAvailablePoints,
                            style: kLargeButtonTextStyle,
                          ),
                        ),
                        new Text(
                          "${widget.member.earnedCredits}",
                          style: kPlusTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            sCurrentBalance,
                            style: kLargeButtonTextStyle,
                          ),
                        ),
                        new Text(
                          "${widget.member.currentBalance}$sShekel",
                          style: widget.member.currentBalance >= 0
                              ? kPlusTextStyle
                              : kMinusTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: kButtonsColor,
                      onPressed: () {
                        addPaymentAlert(
                          context: context,
                          member: widget.member,
                        ).then((v) => {setState(() {})});
                      },
                      child: Text(
                        sAddPayment,
                        style: kLargeButtonTextStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: kButtonsColor,
                      onPressed: () {
                        renewAlert(
                          context: context,
                          member: widget.member,
                        ).then((val) => {setState(() {})});
                      },
                      child: Text(
                        sRenewSubscriptionRecord,
                        style: kLargeButtonTextStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: kButtonsColor,
                      onPressed: () {
                        usePointsAlert(
                          context: context,
                          member: widget.member,
                        ).then((val) => setState(() {}));
                      },
                      child: Text(
                        sUsePoints,
                        style: kLargeButtonTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: new ListView.builder(
              itemCount: widget.member.history.length,
              itemBuilder: (context, i) {
                return HistoryRecordComponent(
                  historyRecord: widget.member.history.elementAt(i),
                );
              },
            )),
            BottomButton(
              buttonTitle: sSave,
              onTap: () {
                if (_formKey.currentState.validate()) {
                  editUserFromFirebase(widget.member);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
