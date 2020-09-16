import 'package:country_tot_casher/components/alerts/procced_alert.dart';
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
                      textDirection: appDirection,
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
                                      nextAlert(
                                          context: context,
                                          label: sPassword,
                                          callback: () {
                                            Navigator.of(context).pop();

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditMember(
                                                        snapshot.data[index]),
                                              ),
                                            ).then((val) => setState(() {}));
                                          });
                                    },
                                    child: Directionality(
                                      textDirection: appDirection,
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
                      textDirection: appDirection,
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
                                      nextAlert(
                                          context: context,
                                          label: sPassword,
                                          callback: () {
                                            Navigator.of(context).pop();

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditMember(
                                                        snapshot.data[index]),
                                              ),
                                            ).then((val) => setState(() {}));
                                          });
                                    },
                                    child: Directionality(
                                      textDirection: appDirection,
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Card(
                    child: Directionality(
                      textDirection: appDirection,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          sFreezedMemberships,
                          style: kLargeButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                new Expanded(
                  child: FutureBuilder(
                      future: getFreezedUsersFromFirebase(),
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
                                      nextAlert(
                                          context: context,
                                          label: sPassword,
                                          callback: () {
                                            Navigator.of(context).pop();

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditMember(
                                                        snapshot.data[index]),
                                              ),
                                            ).then((val) => setState(() {}));
                                          });
                                    },
                                    child: Directionality(
                                      textDirection: appDirection,
                                      child: Container(
                                        decoration:
                                            snapshot.data[index].freezedDays ==
                                                    0
                                                ? null
                                                : new BoxDecoration(
                                                    color: Colors.grey),
                                        child: new ListTile(
                                          leading: new CircleAvatar(
                                            backgroundImage: new AssetImage(
                                                snapshot.data[index].gender ==
                                                        Gender.male
                                                    ? 'images/maleAvatar.png'
                                                    : "images/female.png"),
                                          ),
                                          title: new Text(snapshot
                                                  .data[index].firstName +
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
