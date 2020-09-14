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

class AddMember extends StatefulWidget {
  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  Member member = new Member();
  int periodToAdd = 1;
  int birthdayDay;
  int birthdayMonth;
  int birthdayYear;
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
                          child: Directionality(
                            textDirection: appDirection,
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
                    children: <Widget>[
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                    ],
                  ),
                ),
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
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Directionality(
              textDirection: appDirection,
              child: Row(
                children: <Widget>[
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
                              subscriptionRecord.paidPrice = int.parse(text);
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
                ],
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
                      subscriptionRecord.note = text;
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
            member.updateMembership(periodToAdd);
            member.updateBalance(subscriptionRecord.paidPrice,
                subscriptionRecord.requestedPrice);

            subscriptionRecord.endDate = member.membershipEndDate;
            subscriptionRecord.update();

            member.history.add(new Record(
              title: subscriptionRecord.title,
              type: subscriptionRecord.type,
              note: subscriptionRecord.note,
              date: subscriptionRecord.date,
            ));

            addUserToFirebase(member);
            _formKey.currentState.reset();
          }
        },
      ),
    );
  }
}
