import 'package:country_tot_casher/components/alerts/procced_alert.dart';
import 'package:country_tot_casher/entities/Member.dart';
import 'package:country_tot_casher/screens/EditMember.dart';
import 'package:country_tot_casher/services/calculations.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/material.dart';

class MembersPage extends StatefulWidget {
  @override
  _MembersPageState createState() => new _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  TextEditingController controller = new TextEditingController();
  String searchText = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          color: Theme.of(context).primaryColor,
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        new Expanded(
          child: FutureBuilder(
              future: getAllMembers(text: searchText),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return new ListView.builder(
                      itemCount:
                          snapshot.data.length > 50 ? 50 : snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Card(
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
                                              EditMember(snapshot.data[index]),
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
                                  subtitle:
                                      new Text(snapshot.data[index].idNumber),
                                  trailing: Column(
                                    children: <Widget>[
                                      Text(
                                        sMembershipEndfDate +
                                            " " +
                                            convertDate(snapshot
                                                .data[index].membershipEndDate),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            margin: const EdgeInsets.all(0.0),
                          ),
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
    );
  }

  onSearchTextChanged(String text) {
    searchText = text;

    setState(() {});
  }
}
