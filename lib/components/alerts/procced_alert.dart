import 'package:country_tot_casher/services/validators.dart';
import 'package:flutter/material.dart';

import '../../strings.dart';

void nextAlert({context, callback, String label}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return TwoOptionAlert(
          label: label,
          callback: callback,
          leftOption: sNext,
          rightOption: sCancel,
        );
      });
}

void questionAlert({context, callback, String label}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return TwoOptionAlert(
          label: label,
          callback: callback,
          leftOption: sYes,
          rightOption: sNo,
        );
      });
}

class TwoOptionAlert extends StatelessWidget {
  final callback;
  final String label;
  final String leftOption;
  final String rightOption;
  TwoOptionAlert(
      {this.callback, this.label, this.leftOption, this.rightOption});
  @override
  Widget build(BuildContext context) {
    final _proccedKey = GlobalKey<FormState>();
    return AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Form(
            key: _proccedKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(label),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      validator: adminPasswordValidator,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: sPassword,
                      ),
                      autofocus: false,
                      obscureText: true,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text(leftOption),
                        onPressed: () {
                          if (_proccedKey.currentState.validate()) {
                            callback();
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        color: Colors.redAccent,
                        child: Text(rightOption),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
