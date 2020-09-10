import 'package:country_tot_casher/constants.dart';
import 'package:country_tot_casher/entities/Member.dart';
import 'package:country_tot_casher/screens/EditMember.dart';
import 'package:country_tot_casher/services/calculations.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/services/validators.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Card(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          sExpiredUsers,
                          style: kLargeButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                new Expanded(
                  child: FutureBuilder(
                      future: getExpiredMembers(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null)
                          return new ListView.builder(
                              itemBuilder: (context, index) {});
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            return new ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return new Card(
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Stack(
                                                overflow: Overflow.visible,
                                                children: <Widget>[
                                                  Positioned(
                                                    right: -40.0,
                                                    top: -40.0,
                                                    child: InkResponse(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: CircleAvatar(
                                                        child:
                                                            Icon(Icons.close),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Directionality(
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            child:
                                                                TextFormField(
                                                              validator:
                                                                  adminPasswordValidator,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                hintText:
                                                                    sPassword,
                                                              ),
                                                              autofocus: false,
                                                              obscureText: true,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: RaisedButton(
                                                            child: Text(sNext),
                                                            onPressed: () {
                                                              if (_formKey
                                                                  .currentState
                                                                  .validate()) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        EditMember(
                                                                            snapshot.data[index]),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: new ListTile(
                                        leading: new CircleAvatar(
                                          backgroundImage: new AssetImage(
                                              snapshot.data[index].gender ==
                                                      Gender.male
                                                  ? 'images/maleAvatar.png'
                                                  : "images/female.png"),
                                        ),
                                        title: new Text(
                                            snapshot.data[index].firstName +
                                                ' ' +
                                                snapshot.data[index].lastName),
                                        subtitle: new Text(
                                            snapshot.data[index].idNumber),
                                        trailing: Column(
                                          children: <Widget>[
                                            Text(
                                              sMembershipEndfDate +
                                                  " " +
                                                  convertDate(snapshot
                                                      .data[index]
                                                      .membershipEndDate),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  margin: const EdgeInsets.all(0.0),
                                );
                              },
                            );
                          case ConnectionState.none:
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                          default:
                            print("hello");
                            return new ListView.builder(
                                itemBuilder: (context, index) {});
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Card(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          sAboutToExpiredUsers,
                          style: kLargeButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                new Expanded(
                  child: FutureBuilder(
                      future: getSoonExpireMemberships(7),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null)
                          return new ListView.builder(
                              itemBuilder: (context, index) {});
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            return new ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return new Card(
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Stack(
                                                overflow: Overflow.visible,
                                                children: <Widget>[
                                                  Positioned(
                                                    right: -40.0,
                                                    top: -40.0,
                                                    child: InkResponse(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: CircleAvatar(
                                                        child:
                                                            Icon(Icons.close),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Directionality(
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            child:
                                                                TextFormField(
                                                              validator:
                                                                  adminPasswordValidator,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                hintText:
                                                                    sPassword,
                                                              ),
                                                              autofocus: false,
                                                              obscureText: true,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: RaisedButton(
                                                            child: Text(sNext),
                                                            onPressed: () {
                                                              if (_formKey
                                                                  .currentState
                                                                  .validate()) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        EditMember(
                                                                            snapshot.data[index]),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: new ListTile(
                                        leading: new CircleAvatar(
                                          backgroundImage: new AssetImage(
                                              snapshot.data[index].gender ==
                                                      Gender.male
                                                  ? 'images/maleAvatar.png'
                                                  : "images/female.png"),
                                        ),
                                        title: new Text(
                                            snapshot.data[index].firstName +
                                                ' ' +
                                                snapshot.data[index].lastName),
                                        subtitle: new Text(
                                            snapshot.data[index].idNumber),
                                        trailing: Column(
                                          children: <Widget>[
                                            Text(
                                              sMembershipEndfDate +
                                                  " " +
                                                  convertDate(snapshot
                                                      .data[index]
                                                      .membershipEndDate),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  margin: const EdgeInsets.all(0.0),
                                );
                              },
                            );
                          case ConnectionState.none:
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                          default:
                            return new ListView();
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
