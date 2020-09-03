import 'package:country_tot_casher/entities/member.dart';
import 'package:country_tot_casher/screens/editMemberAdminPage.dart';
import 'package:country_tot_casher/services/calculations.dart';
import 'package:country_tot_casher/services/firebaseManagement.dart';
import 'package:country_tot_casher/services/validators.dart';
import 'package:country_tot_casher/strings.dart';
import 'package:flutter/material.dart';

class MembersPage extends StatefulWidget {
  @override
  _MembersPageState createState() => new _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  TextEditingController controller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    getAllMembers().then((value) => {_userDetails = value});
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
          child: _searchResult.length != 0 || controller.text.isNotEmpty
              ? new ListView.builder(
                  itemCount:
                      _searchResult.length > 10 ? 10 : _searchResult.length,
                  itemBuilder: (context, i) {
                    return new Card(
                      child: InkWell(
                        onTap: () {
                          AdminEditMember(_userDetails[i]);
                        },
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: new ListTile(
                            leading: new CircleAvatar(
                              backgroundImage: new AssetImage(
                                _searchResult[i].gender == Gender.male
                                    ? 'images/maleAvatar.png'
                                    : 'images/female.png',
                              ),
                            ),
                            title: new Text(_searchResult[i].firstName +
                                ' ' +
                                _searchResult[i].lastName),
                            subtitle: new Text(_searchResult[i].idNumber),
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.all(0.0),
                    );
                  },
                )
              : new ListView.builder(
                  itemCount:
                      _userDetails.length > 50 ? 50 : _userDetails.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Card(
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
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: TextFormField(
                                                    validator:
                                                        adminPasswordValidator,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: sPassword,
                                                    ),
                                                    autofocus: false,
                                                    obscureText: true,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: RaisedButton(
                                                  child: Text(sNext),
                                                  onPressed: () {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AdminEditMember(
                                                                  _userDetails[
                                                                      index]),
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
                                    _userDetails[index].gender == Gender.male
                                        ? 'images/maleAvatar.png'
                                        : "images/female.png"),
                              ),
                              title: new Text(_userDetails[index].firstName +
                                  ' ' +
                                  _userDetails[index].lastName),
                              subtitle: new Text(_userDetails[index].idNumber),
                              trailing: Column(
                                children: <Widget>[
                                  Text(
                                    sMembershipEndfDate +
                                        " " +
                                        convertDate(_userDetails[index]
                                            .membershipEndDate),
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
                ),
        ),
      ],
    );
  }

  onSearchTextChanged(String text) {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    getAllMembers().then((value) => {_userDetails = value});
    _userDetails.forEach((userDetail) {
      if (userDetail.firstName.contains(text) ||
          userDetail.lastName.contains(text) ||
          userDetail.idNumber.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<Member> _searchResult = [];

List<Member> _userDetails = [];
