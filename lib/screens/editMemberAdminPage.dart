import 'package:country_tot_casher/components/bottom_button.dart';
import 'package:country_tot_casher/components/reusable_card.dart';
import 'package:country_tot_casher/constants.dart';
import 'package:country_tot_casher/entities/member.dart';
import 'package:country_tot_casher/services/calculations.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/services/validators.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminEditMember extends StatefulWidget {
  Member member;
  AdminEditMember(this.member, {Key key})
      : super(key: key); //add also..example this.abc,this...
  @override
  _AdminEditMemberState createState() => _AdminEditMemberState();
}

class _AdminEditMemberState extends State<AdminEditMember> {
  int periodToAdd = 0;
  int birthdayDay;
  int birthdayMonth;
  int birthdayYear;
  final _formKey = GlobalKey<FormState>();
  PaymentRecord debtPaymentRecord = new PaymentRecord(
      requestedPrice: 0,
      paidPrice: 0,
      note: '',
      balance: 0,
      dateTime: DateTime.now());
  PaymentRecord newPaymentRecord = new PaymentRecord(
      requestedPrice: 0,
      paidPrice: 0,
      note: '',
      balance: 0,
      dateTime: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
            Row(
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
            Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: <Widget>[
                  RadioListTile<Gender>(
                    title: Text(sMale),
                    value: Gender.male,
                    groupValue: widget.member.gender,
                    onChanged: (Gender value) {
                      setState(() {
                        widget.member.gender = value;
                      });
                    },
                  ),
                  RadioListTile<Gender>(
                    title: Text(sFemale),
                    value: Gender.female,
                    groupValue: widget.member.gender,
                    onChanged: (Gender value) {
                      setState(() {
                        widget.member.gender = value;
                      });
                    },
                  ),
                  Row(
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
                  )
                ],
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      sCurrentBalace,
                      style: kLargeButtonTextStyle,
                    ),
                  ),
                  new Text(
                    "${widget.member.currentBalance}$sShekel",
                    style: widget.member.currentBalance >= 0
                        ? kPlusTextStyle
                        : kMinusTextStyle,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: new TextFormField(
                          textAlign: TextAlign.right,
                          onChanged: (text) {
                            setState(() {
                              debtPaymentRecord.paidPrice = int.parse(text);
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            labelText: sAddPayment,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        disabledColor: kButtonsColor,
                        color: kActiveCardColour,
                        child: Text(
                          sAdd,
                          style: kLargeButtonTextStyle,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.member.updateBalance(debtPaymentRecord);

                            widget.member.paymentRecords.add(
                              new PaymentRecord(
                                requestedPrice:
                                    debtPaymentRecord.requestedPrice,
                                paidPrice: debtPaymentRecord.paidPrice,
                                note: debtPaymentRecord.note,
                                balance: widget.member.currentBalance,
                                dateTime: DateTime.now(),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    sAddPeriod,
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
                      min: 0,
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
            ReusableCard(
              colour: kActiveCardColour,
              cardChild: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: new TextFormField(
                          textAlign: TextAlign.right,
                          onChanged: (text) {
                            setState(() {
                              newPaymentRecord.paidPrice = int.parse(text);
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            labelText: sPaidPrice,
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
                          textAlign: TextAlign.right,
                          onChanged: (text) {
                            setState(() {
                              newPaymentRecord.requestedPrice = int.parse(text);
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            labelText: sRequestedPrice,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      disabledColor: kButtonsColor,
                      color: kActiveCardColour,
                      child: Text(
                        sRenew,
                        style: kLargeButtonTextStyle,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.member.updateBalance(newPaymentRecord);
                          widget.member.updateMembership(periodToAdd);
                          widget.member.paymentRecords.add(new PaymentRecord(
                              requestedPrice: newPaymentRecord.requestedPrice,
                              paidPrice: newPaymentRecord.paidPrice,
                              note: newPaymentRecord.note,
                              balance: widget.member.currentBalance,
                              dateTime: DateTime.now()));
                          periodToAdd = 0;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextField(
                        textAlign: TextAlign.right,
                        onChanged: (text) {
                          setState(() {
                            newPaymentRecord.note = text;
                          });
                        },
                        decoration: new InputDecoration(
                          labelText: sNotes,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: new ListView.builder(
              itemCount: widget.member.paymentRecords.length,
              itemBuilder: (context, i) {
                return new Card(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: new ListTile(
                      leading: new Text(
                          "$sCurrentBalace: ${widget.member.paymentRecords.elementAt(i).balance}"),
                      title: new Text(
                          "$sPaidPrice: ${widget.member.paymentRecords.elementAt(i).paidPrice}"),
                      subtitle: new Text(
                          "$sNotes: ${widget.member.paymentRecords.elementAt(i).note}"),
                      trailing: new Text(
                          "${convertDate(widget.member.paymentRecords.elementAt(i).dateTime)}"),
                    ),
                  ),
                );
              },
            )),
            BottomButton(
              buttonTitle: sSave,
              onTap: () {
                if (_formKey.currentState.validate()) {
                  editUserToFirebase(widget.member);
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
