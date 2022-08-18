import 'package:flutter/material.dart';
import 'package:persistence/signup/provider/firefun.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/persnal_widgets.dart';

defaultAppBar({String? title}) {
  if (title != null) {
    return AppBar(
      title: Text(title.toString(), style: appbarTextStyle),
    );
  }
  return AppBar(
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        S(height: 5),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            "Timer App",
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        S(height: 2),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Scaibu",
            style: TextStyle(fontSize: 10, color: Colors.yellowAccent),
          ),
        ),
        S(height: 5),
      ],
    ),
    actions: [
      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
    ],
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

Widget Login_required({String? log_in_required}) {
  return Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: Text(
        (log_in_required == null) ? "Error " : log_in_required as String,
        style: TextStyle(
          fontSize: 21,
        ),
      ),
    ),
  );
}

Widget Stream_Done_Widget({String? done_msg}) {
  return Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: Text(
        (done_msg == null) ? "Error " : done_msg as String,
        style: TextStyle(
          fontSize: 21,
        ),
      ),
    ),
  );
}

defaultDrawer(
  context, {
  List<Widget> children = const <Widget>[],
}) {
  fireOper fireop =
      fireOper(docName: 'userSignUptest', collectionname: 'userSignUp');
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: Align(
            alignment: Alignment.center,
            child: ListTile(
              title: Text('Timer',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  )),
              subtitle: Text(
                'Scaibu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: children,
          ),
        )
      ],
    ),
  );
}
