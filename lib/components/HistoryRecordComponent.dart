import 'package:country_tot_casher/entities/HistoryRecord.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HistoryRecordComponent extends StatelessWidget {
  HistoryRecordComponent({this.historyRecord});
  final HistoryRecord historyRecord;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Directionality(
        textDirection: appDirection,
        child: new ListTile(
          leading: new Text("${historyRecord.type}"),
          title: new Text("${historyRecord.title}"),
          subtitle: new Text("${historyRecord.note}"),
          trailing: new Text("${historyRecord.getRecordDate()}"),
        ),
      ),
    );
  }
}
