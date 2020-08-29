import 'package:country_tot_casher/components/bottom_button.dart';
import 'package:country_tot_casher/components/icon_content.dart';
import 'package:country_tot_casher/components/reusable_card.dart';
import 'package:country_tot_casher/components/round_icon_button.dart';
import 'package:country_tot_casher/constants.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender {
  male,
  female,
}

class AddMember extends StatefulWidget {
  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  Gender selectedGender;
  int height = 180;
  int currentWeight = 80;
  int requestedWeight = 80;
  int birthdayDay;
  int birthdayMonth;
  int birthdayYear;
  int periodToAdd = 1;
  String firstName;
  String lastName;
  String city;
  String phoneNumber;
  String idNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    child: new TextField(
                      textAlign: TextAlign.right,
                      onChanged: (text) {
                        setState(() {
                          lastName = text;
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
                    child: new TextField(
                      textAlign: TextAlign.right,
                      decoration: new InputDecoration(
                        labelText: sFirstName,
                      ),
                      onChanged: (text) {
                        setState(() {
                          firstName = text;
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
                    child: new TextField(
                      textAlign: TextAlign.right,
                      decoration: new InputDecoration(
                        labelText: sPhoneNumber,
                      ),
                      onChanged: (text) {
                        setState(() {
                          phoneNumber = text;
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
                    child: new TextField(
                      textAlign: TextAlign.right,
                      decoration: new InputDecoration(
                        labelText: sIdNumber,
                      ),
                      onChanged: (text) {
                        setState(() {
                          idNumber = text;
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
                    child: new TextField(
                      textAlign: TextAlign.right,
                      decoration: new InputDecoration(
                        labelText: sCity,
                      ),
                      onChanged: (text) {
                        setState(() {
                          city = text;
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
                    child: new TextField(
                      textAlign: TextAlign.right,
                      decoration: new InputDecoration(
                        labelText: sBirthDateDay,
                      ),
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
                    child: new TextField(
                      textAlign: TextAlign.right,
                      decoration: new InputDecoration(
                        labelText: sBirthDateMonth,
                      ),
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
                    child: new TextField(
                      textAlign: TextAlign.right,
                      decoration: new InputDecoration(
                        labelText: sBirthDateYear,
                      ),
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
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                  colour: selectedGender == Gender.female
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
                      selectedGender = Gender.male;
                    });
                  },
                  colour: selectedGender == Gender.male
                      ? kInactiveCardColour
                      : kActiveCardColour,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.mars,
                    label: sMale,
                  ),
                ),
              ),
            ],
          )),
          Expanded(
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
                          requestedWeight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    requestedWeight--;
                                  });
                                }),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  requestedWeight++;
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
                              height.toString(),
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
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 15.0),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 30.0),
                          ),
                          child: Slider(
                            value: height.toDouble(),
                            min: 120.0,
                            max: 220.0,
                            onChanged: (double newValue) {
                              setState(() {
                                height = newValue.round();
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
                          currentWeight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    currentWeight--;
                                  });
                                }),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  currentWeight++;
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
          Expanded(
            child: ReusableCard(
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
          ),
          BottomButton(
            buttonTitle: sAddMember,
            onTap: () {
              addUserToFirebase(
                  selectedGender,
                  height,
                  currentWeight,
                  requestedWeight,
                  birthdayDay,
                  birthdayMonth,
                  birthdayYear,
                  firstName,
                  lastName,
                  city,
                  phoneNumber,
                  periodToAdd,
                  idNumber);
            },
          ),
        ],
      ),
    );
  }
}

//onTap: () {
//showDialog(
//context: context,
//builder: (BuildContext context) {
//var _formKey;
//return AlertDialog(
//content: Stack(
//overflow: Overflow.visible,
//children: <Widget>[
//Positioned(
//right: -40.0,
//top: -40.0,
//child: InkResponse(
//onTap: () {
//Navigator.of(context).pop();
//},
//child: CircleAvatar(
//child: Icon(Icons.close),
//backgroundColor: Colors.red,
//),
//),
//),
//Form(
//key: _formKey,
//child: Column(
//mainAxisSize: MainAxisSize.min,
//children: <Widget>[
//Padding(
//padding: EdgeInsets.all(8.0),
//child: TextFormField(),
//),
//Padding(
//padding: EdgeInsets.all(8.0),
//child: TextFormField(),
//),
//Padding(
//padding: const EdgeInsets.all(8.0),
//child: RaisedButton(
//child: Text("Submitß"),
//onPressed: () {
//if (_formKey.currentState.validate()) {
//_formKey.currentState.save();
//}
//},
//),
//)
//],
//),
//),
//],
//),
//);
//});
//},
