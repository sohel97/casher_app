import 'package:country_tot_casher/components/bottom_button.dart';
import 'package:country_tot_casher/components/icon_content.dart';
import 'package:country_tot_casher/components/reusable_card.dart';
import 'package:country_tot_casher/components/round_icon_button.dart';
import 'package:country_tot_casher/constants.dart';
import 'package:country_tot_casher/entities/HistoryRecord.dart';
import 'package:country_tot_casher/entities/Member.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/services/validators.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddMember extends StatefulWidget {
  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  Member member = new Member();
  int monthsToAdd = 1;
  int birthdayDay;
  int birthdayMonth;
  int birthdayYear;
  int renewStartDay = DateTime.now().day;
  int renewStartMonth = DateTime.now().month;
  int renewStartYear = DateTime.now().year;
  String dropdownValue = 'מתאמן';
  SubscriptionRecord subscriptionRecord = SubscriptionRecord(
    startDate: DateTime.now(),
    endDate: DateTime.now(),
    note: "",
    requestedPrice: 0,
    paidPrice: 0,
    isNewMember: true,
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Directionality(
                    textDirection: appDirection,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['מתאמן', 'מאמן']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    )),
                SizedBox(
                  height: 30.0,
                ),
                Directionality(
                  textDirection: appDirection,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new TextFormField(
                            validator: textFieldValidator,
                            textAlign: TextAlign.right,
                            decoration: new InputDecoration(
                              labelText: sFirstName,
                            ),
                            onChanged: (text) {
                              setState(() {
                                member.firstName = text;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new TextFormField(
                            validator: textFieldValidator,
                            textAlign: TextAlign.right,
                            onChanged: (text) {
                              setState(() {
                                member.lastName = text;
                              });
                            },
                            decoration: new InputDecoration(
                              labelText: sLastName,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Directionality(
                  textDirection: appDirection,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Directionality(
                            textDirection: appDirection,
                            child: new TextFormField(
                              validator: numberFieldValidator,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              textAlign: TextAlign.right,
                              decoration: new InputDecoration(
                                labelText: sPhoneNumber,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  member.phoneNumber = text;
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
                            textDirection: appDirection,
                            child: new TextFormField(
                              validator: numberFieldValidator,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              textAlign: TextAlign.right,
                              decoration: new InputDecoration(
                                labelText: sIdNumber,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  member.idNumber = text;
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
                            textDirection: appDirection,
                            child: new TextFormField(
                              validator: textFieldValidator,
                              textAlign: TextAlign.right,
                              decoration: new InputDecoration(
                                labelText: sCity,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  member.city = text;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Directionality(
                  textDirection: appDirection,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Directionality(
                          textDirection: appDirection,
                          child: Text(
                            sBirthDate,
                            style: kLabelTextStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Directionality(
                            textDirection: appDirection,
                            child: new TextFormField(
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
                            textDirection: appDirection,
                            child: new TextFormField(
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
                            textDirection: appDirection,
                            child: new TextFormField(
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
                    ],
                  ),
                ),
                Directionality(
                  textDirection: appDirection,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ReusableCard(
                          onPress: () {
                            setState(() {
                              member.gender = Gender.female;
                            });
                          },
                          colour: member.gender == Gender.female
                              ? kInactiveCardColour
                              : kActiveCardColour,
                          cardChild: IconContent(
                            icon: FontAwesomeIcons.venus,
                            label: sFemale,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReusableCard(
                          onPress: () {
                            setState(() {
                              member.gender = Gender.male;
                            });
                          },
                          colour: member.gender == Gender.male
                              ? kInactiveCardColour
                              : kActiveCardColour,
                          cardChild: IconContent(
                            icon: FontAwesomeIcons.mars,
                            label: sMale,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    children: dropdownValue == 'מתאמן'
                        ? <Widget>[
                            Expanded(
                              child: ReusableCard(
                                colour: kActiveCardColour,
                                cardChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      sRequestedWeight,
                                      style: kLabelTextStyle,
                                    ),
                                    Text(
                                      member.requestedWeight.toString(),
                                      style: kNumberTextStyle,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        RoundIconButton(
                                            icon: FontAwesomeIcons.minus,
                                            onPressed: () {
                                              setState(() {
                                                member.requestedWeight--;
                                              });
                                            }),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        RoundIconButton(
                                          icon: FontAwesomeIcons.plus,
                                          onPressed: () {
                                            setState(() {
                                              member.requestedWeight++;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: ReusableCard(
                                colour: kActiveCardColour,
                                cardChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      sHeight,
                                      style: kLabelTextStyle,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: <Widget>[
                                        Text(
                                          member.height.toString(),
                                          style: kNumberTextStyle,
                                        ),
                                        Text(
                                          'cm',
                                          style: kLabelTextStyle,
                                        )
                                      ],
                                    ),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        inactiveTrackColor: Color(0xFF8D8E98),
                                        activeTrackColor: Colors.white,
                                        thumbColor: kButtonsColor,
                                        overlayColor: Color(0x29EC801A),
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 15.0),
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 30.0),
                                      ),
                                      child: Slider(
                                        value: member.height.toDouble(),
                                        min: 120.0,
                                        max: 220.0,
                                        onChanged: (double newValue) {
                                          setState(() {
                                            member.height = newValue.round();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: ReusableCard(
                                colour: kActiveCardColour,
                                cardChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      sCurrentWeight,
                                      style: kLabelTextStyle,
                                    ),
                                    Text(
                                      member.currentWeight.toString(),
                                      style: kNumberTextStyle,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        RoundIconButton(
                                            icon: FontAwesomeIcons.minus,
                                            onPressed: () {
                                              setState(() {
                                                member.currentWeight--;
                                              });
                                            }),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        RoundIconButton(
                                          icon: FontAwesomeIcons.plus,
                                          onPressed: () {
                                            setState(() {
                                              member.currentWeight++;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                        : [],
                  ),
                ),
                ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: dropdownValue == 'מתאמן'
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              sPeriodToAdd,
                              style: kLabelTextStyle,
                            ),
                            Text(
                              monthsToAdd.toString(),
                              style: kNumberTextStyle,
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                inactiveTrackColor: Color(0xFF8D8E98),
                                activeTrackColor: Colors.white,
                                thumbColor: kButtonsColor,
                                overlayColor: Color(0x29EC801A),
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 15.0),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 30.0),
                              ),
                              child: Slider(
                                value: monthsToAdd.toDouble(),
                                min: 1,
                                max: 12,
                                onChanged: (double newValue) {
                                  setState(() {
                                    monthsToAdd = newValue.round();
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      : Column(),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Directionality(
                        textDirection: appDirection,
                        child: Text(
                          sStartDate,
                          style: kLabelTextStyle,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new TextFormField(
                              initialValue:
                                  (renewStartDay).toString().padLeft(2, '0'),
                              validator: dayFieldValidator,
                              textAlign: TextAlign.right,
                              onChanged: (text) {
                                renewStartDay = int.parse(text);
                              },
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                  labelText: sBirthDateDay, hintText: 'DD'),
                            ),
                          ),
                        ),
                        new Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new TextFormField(
                              initialValue:
                                  (renewStartMonth).toString().padLeft(2, '0'),
                              validator: monthFieldValidator,
                              textAlign: TextAlign.right,
                              onChanged: (text) {
                                renewStartMonth = int.parse(text);
                              },
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                  labelText: sBirthDateMonth, hintText: 'MM'),
                            ),
                          ),
                        ),
                        new Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new TextFormField(
                              initialValue: (renewStartYear).toString(),
                              validator: yearFieldValidator,
                              textAlign: TextAlign.right,
                              onChanged: (text) {
                                renewStartYear = int.parse(text);
                              },
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                  labelText: sBirthDateYear, hintText: 'YYYY'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: dropdownValue == 'מתאמן' ? 50 : 0,
            ),
            Directionality(
              textDirection: appDirection,
              child: Row(
                children: dropdownValue == 'מתאמן'
                    ? <Widget>[
                        Checkbox(
                          checkColor: Colors.black,
                          activeColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              member.healthCareApproval = value;
                            });
                          },
                          value: member.healthCareApproval,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Directionality(
                            textDirection: appDirection,
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
                              textDirection: appDirection,
                              child: new TextFormField(
                                validator: numberFieldValidator,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.right,
                                onChanged: (text) {
                                  setState(() {
                                    subscriptionRecord.paidPrice =
                                        int.parse(text);
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
                              textDirection: appDirection,
                              child: new TextFormField(
                                validator: numberFieldValidator,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.right,
                                onChanged: (text) {
                                  setState(() {
                                    subscriptionRecord.requestedPrice =
                                        int.parse(text);
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
                      ]
                    : [],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: appDirection,
                child: new TextFormField(
                  textAlign: TextAlign.right,
                  onChanged: (text) {
                    setState(() {
                      subscriptionRecord.firebaseNote = text;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: sNotes,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                  textDirection: appDirection,
                  child: new TextFormField(
                    validator: adminPasswordValidator,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: sPassword,
                    ),
                    autofocus: false,
                    obscureText: true,
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(
        buttonTitle: sNext,
        onTap: () {
          if (_formKey.currentState.validate()) {
            member.history.clear();

            member.birthDate =
                new DateTime(birthdayYear, birthdayMonth, birthdayDay);
            DateTime startDate =
                new DateTime(renewStartYear, renewStartMonth, renewStartDay);
            subscriptionRecord.startDate = startDate;
            member.updateMembership(
                newStartDate: startDate, monthsToAdd: monthsToAdd);
            member.updateBalance(
                paidPrice: subscriptionRecord.paidPrice,
                requestedPrice: subscriptionRecord.requestedPrice);

            subscriptionRecord.endDate = member.membershipEndDate;
            print(subscriptionRecord.getJson());
            member.history.add(subscriptionRecord);
            member.membersJob = dropdownValue == 'מתאמן'
                ? MembersJob.Participant
                : MembersJob.Planner;
            addUserToFirebase(member);
            Fluttertoast.showToast(
                msg: sSavedSuccessfully,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            _formKey.currentState.reset();
          }
        },
      ),
    );
  }
}
