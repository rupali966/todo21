// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:persistence/work/provider/work_provider.dart';
import 'package:provider/provider.dart';

confirm_alertbox({
  required BuildContext context,
  String warnig = "",
  String Alrt_Title = 'Alert-box',
  bool input_from_user = false,
  VoidCallback? Yes_Press,
  VoidCallback? No_Press,
  required Widget Input_wid,
}) async {
  return showDialog<void>(
    useSafeArea: true,
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;
      return Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            scrollable: true,
            elevation: 0.2,
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: (input_from_user)
                ? Text('Edit')
                : Text("$Alrt_Title",
                    style: TextStyle(
                      fontSize: 18,
                      inherit: true,
                    )),
            content: Container(
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: (input_from_user)
                    ? ListBody(
                        children: [
                          (warnig == "")
                              ? Text('This is a demo alert dialog.')
                              : Text(warnig),
                          S(),
                          Center(
                            child: Align(
                                alignment: Alignment.topLeft, child: Input_wid),
                          ),
                        ],
                      )
                    : Container(
                        child: (warnig == "")
                            ? Text('This is alert dialog.')
                            : Text(
                                warnig,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                      ),
              ),
            ),
            actions: [
              (input_from_user)
                  ? Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                tooltip: 'Yes',
                                icon: Icon(
                                  Icons.thumb_up_alt_outlined,
                                  size: 35,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  Yes_Press!.call();
                                  Navigator.pop(context);
                                },
                              ),
                              S(width: 25),
                              IconButton(
                                tooltip: 'No',
                                icon: Icon(
                                  Icons.thumb_down_alt_outlined,
                                  size: 35,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  No_Press!.call();
                                  Navigator.pop(context);
                                },
                              ),
                              S(width: 25, height: 25),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            tooltip: 'Yes',
                            icon: Icon(
                              Icons.thumb_up_alt_outlined,
                              size: 35,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              Yes_Press!.call();
                              Navigator.pop(context);
                            },
                          ),
                          S(width: 25),
                          IconButton(
                            tooltip: 'No',
                            icon: Icon(
                              Icons.thumb_down_alt_outlined,
                              size: 35,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              No_Press!.call();
                              Navigator.pop(context);
                            },
                          ),
                          S(width: 25, height: 25),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      );
    },
  );
}

bottomsheet(
  context, {
  List<Widget> children = const <Widget>[],
}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        color: Colors.blue.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: children,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.close),
                  label: const Text('Close'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

multiple_flotingactionbutton(context) {
  return Container(
    alignment: Alignment.bottomCenter,
    child: Column(
      children: [
        S(),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {
              Provider.of<work_provider>(context,listen: false).change_floting();
            },
            child: Icon(Icons.add),
          ),
        ),
        S(),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
        ),
        S(),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
        ),
      ],

    ),
  );
}
