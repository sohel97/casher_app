// import 'package:country_tot_casher/entities/HistoryRecord.dart';
// import 'package:country_tot_casher/entities/Member.dart';
// import 'package:country_tot_casher/services/firebaseManagement.dart';
// import 'package:country_tot_casher/services/validators.dart';
// import 'package:country_tot_casher/strings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void freezeMembershipAlert({BuildContext context, Member member}) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return FreezeMembershipRecordAlert(member: member);
//       });
// }
//
// class FreezeMembershipRecordAlert extends StatefulWidget {
//   final Member member;
//
//   FreezeMembershipRecordAlert({this.member});
// s
//   @override
//   _FreezeMembershipRecordAlertState createState() =>
//       _FreezeMembershipRecordAlertState();
// }
//
// class _FreezeMembershipRecordAlertState
//     extends State<FreezeMembershipRecordAlert> {
//   @override
//   Widget build(BuildContext context) {
//     final _proccedKey = GlobalKey<FormState>();
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20.0))),
//       content: Form(
//         key: _proccedKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           textDirection: TextDirection.rtl,
//           children: <Widget>[
//             Directionality(
//               textDirection: TextDirection.rtl,
//               child: new TextFormField(
//                 validator: numberFieldValidator,
//                 textAlign: TextAlign.right,
//                 onChanged: (text) {
//                   subscriptionRecord.requestedPrice = int.parse(text);
//                 },
//                 inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
//                 keyboardType: TextInputType.number,
//                 decoration: new InputDecoration(
//                   labelText: sRequestedPrice,
//                 ),
//               ),
//             ),
//             Directionality(
//               textDirection: TextDirection.rtl,
//               child: new TextFormField(
//                 validator: numberFieldValidator,
//                 textAlign: TextAlign.right,
//                 onChanged: (text) {
//                   subscriptionRecord.paidPrice = int.parse(text);
//                 },
//                 inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
//                 keyboardType: TextInputType.number,
//                 decoration: new InputDecoration(
//                   labelText: sPaidPrice,
//                 ),
//               ),
//             ),
//             Directionality(
//               textDirection: TextDirection.rtl,
//               child: new TextFormField(
//                 textAlign: TextAlign.right,
//                 onChanged: (text) {
//                   subscriptionRecord.note = text;
//                 },
//                 decoration: new InputDecoration(
//                   labelText: sNotes,
//                 ),
//               ),
//             ),
//             Row(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: RaisedButton(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18.0),
//                     ),
//                     child: Text(sSave),
//                     onPressed: () {
//                       if (_proccedKey.currentState.validate()) {
//                         //Update the member
//                         widget.member
//                             .updateMembership(monthsToAdd: monthsToAdd);
//                         widget.member.updateBalance(
//                           subscriptionRecord.paidPrice,
//                           subscriptionRecord.requestedPrice,
//                         );
//
//                         //Update the record
//                         subscriptionRecord.startDate =
//                             widget.member.membershipStartDate;
//                         subscriptionRecord.endDate =
//                             widget.member.membershipEndDate;
//                         subscriptionRecord.update();
//                         print(subscriptionRecord.endDate.toUtc().toString());
//                         print(
//                             widget.member.membershipEndDate.toUtc().toString());
//                         widget.member.history.add(new Record(
//                           note: subscriptionRecord.note,
//                           title: subscriptionRecord.title,
//                           type: subscriptionRecord.type,
//                           date: subscriptionRecord.date,
//                         ));
//                         editUserFromFirebase(widget.member);
//                         Navigator.of(context).pop();
//                       }
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: RaisedButton(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18.0),
//                         side: BorderSide(color: Colors.red)),
//                     color: Colors.redAccent,
//                     child: Text(sCancel),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
