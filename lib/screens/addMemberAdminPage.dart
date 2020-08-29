import 'package:country_tot_casher/components/bottom_button.dart';
import 'package:country_tot_casher/components/reusable_card.dart';
import 'package:country_tot_casher/entities/member.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../strings.dart';

class AddMemberAdminPage extends StatefulWidget {
  Member member;
  AddMemberAdminPage(this.member, {Key key})
      : super(key: key); //add also..example this.abc,this...
  @override
  _AddMemberAdminPageState createState() => _AddMemberAdminPageState();
}

class _AddMemberAdminPageState extends State<AddMemberAdminPage> {
  bool healthApproval = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      widget.member.getArabicString(),
                      style: kBodyTextStyle,
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
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextField(
                        textAlign: TextAlign.right,
                        onChanged: (text) {
                          setState(() {});
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
                      child: new TextField(
                        textAlign: TextAlign.right,
                        onChanged: (text) {
                          setState(() {});
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
                      setState(() {});
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
                  children: <Widget>[
                    Checkbox(
                        onChanged: (value) {
                          setState(() {
                            healthApproval = value;
                          });
                        },
                        value: healthApproval),
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
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: new TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: sPassword,
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                      autofocus: false,
                      obscureText: true,
                    )),
              ),
            ),
            BottomButton(
              buttonTitle: sAddMember,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
