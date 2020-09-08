import 'package:country_tot_casher/constants.dart';
import 'package:country_tot_casher/screens/EditMember.dart';
import 'package:flutter/material.dart';

import 'entities/Member.dart';
import 'screens/addMemberPage.dart';
import 'strings.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData.dark().copyWith(
        accentColor: kButtonsColor,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  final List<Widget> _children = [
    // HomePage(),

    EditMember(new Member()),
    // MembersPage(),
    AddMember(),
    Center(
        child: Container(
            child: Text(
      'Empty',
      style: TextStyle(color: Colors.white, fontSize: 50),
    ))),
    Center(
        child: Container(
            child: Text(
      'Empty',
      style: TextStyle(color: Colors.white, fontSize: 50),
    ))),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(sAppName),
      ),
      body: _children[currentPage],
      bottomNavigationBar: new BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
          items: [
            new BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              title: new Text(sHomePage),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(Icons.perm_contact_calendar),
              title: new Text(sMembers),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(Icons.add_circle_outline),
              title: new Text(sAddMember),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(Icons.query_builder),
              title: new Text('Test Page'),
            ),
          ]),
    );
  }
}
