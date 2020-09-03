import 'package:country_tot_casher/components/bottom_button.dart';
import 'package:country_tot_casher/entities/member.dart';
import 'package:country_tot_casher/services/validators.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/firebaseManagement.dart';
import '../strings.dart';

class AddMemberAdminPage extends StatefulWidget {
  final Member member;
  final _firstformKey;
  AddMemberAdminPage(this.member, this._firstformKey, {Key key})
      : super(key: key); //add also..example this.abc,this...
  @override
  _AddMemberAdminPageState createState() => _AddMemberAdminPageState();
}

class _AddMemberAdminPageState extends State<AddMemberAdminPage> {
  bool healthApproval = false;
  PaymentRecord paymentRecord = new PaymentRecord(
      requestedPrice: 0,
      paidPrice: 0,
      note: '',
      balance: 0,
      dateTime: DateTime.now());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        healthApproval = value;
                      });
                    },
                    value: healthApproval,
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: new TextFormField(
                          validator: numberFieldValidator,
                          textAlign: TextAlign.right,
                          onChanged: (text) {
                            setState(() {
                              paymentRecord.paidPrice = int.parse(text);
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
                          validator: numberFieldValidator,
                          textAlign: TextAlign.right,
                          onChanged: (text) {
                            setState(() {
                              paymentRecord.requestedPrice = int.parse(text);
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: new TextField(
                      textAlign: TextAlign.right,
                      onChanged: (text) {
                        setState(() {
                          paymentRecord.note = text;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: sNotes,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: <Widget>[],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextFormField(
                        validator: adminPasswordValidator,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: sPassword,
                        ),
//                        onChanged: (text) {
//                          setState(() {
//                            authenticateWithFirebase(text);
//                          });
//                        },
                        autofocus: false,
                        obscureText: true,
                      )),
                ),
              ),
              BottomButton(
                buttonTitle: sAddMember,
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    paymentRecord.dateTime = DateTime.now();

                    widget.member.updateBalance(paymentRecord);
                    widget.member.paymentRecords.add(
                      new PaymentRecord(
                        requestedPrice: paymentRecord.requestedPrice,
                        paidPrice: paymentRecord.paidPrice,
                        note: paymentRecord.note,
                        balance: widget.member.currentBalance,
                        dateTime: DateTime.now(),
                      ),
                    );
                    widget.member.healthCareApproval = healthApproval;
                    print(widget.member.toString());
                    addUserToFirebase(widget.member);
                    widget._firstformKey?.currentState?.reset();
                    _formKey.currentState.reset();
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
