import 'package:flutter/material.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/persnal_widgets.dart';

defaultAppBar({String? title}) {
  if (title != null) {
    return AppBar(
      title: Text(title.toString(), style: appbarTextStyle),
    );
  }
  return AppBar(
    title: Text("Timer"),
  );
}

Widget hasErrorWidget({String? ErrorMsg}) {
  return Scaffold(
    body: Container(
      child: Expanded(
        child: Text(
          (ErrorMsg == null) ? "Error " : ErrorMsg as String,
          style: TextStyle(
            fontSize: 21,
          ),
        ),
      ),
    ),
  );
}

Widget loddingWidget({String? loading_text}) {
  return Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (loading_text == null)
                ? Center(child: text2(str: "Loading"))
                : text2(
                    str: loading_text as String,
                  ),
            S(),
            CircularProgressIndicator(
              semanticsLabel: 'Loading',
            ),
          ],
        ),
      ),
    ),
  );
}
