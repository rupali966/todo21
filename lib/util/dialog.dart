import 'package:flutter/material.dart';
import 'package:persistence/util/persnal_widgets.dart';

confirm_alertbox({
  required BuildContext context,
  String warnig_to_display = "",
  String alrt_title = 'Alert-box',
  bool getdata = false,
  VoidCallback? onYes_Pressed,
  VoidCallback? onNo_Pressed,
  required Widget editWidget,
}) async {
  return showDialog<void>(
    useSafeArea: true,
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;
      return AlertDialog(
        scrollable: true,
        elevation: 0.2,
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.start,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: (getdata)
            ? Text('Edit')
            : Text("$alrt_title",
                style: TextStyle(
                  fontSize: 18,
                  inherit: true,
                )),
        content: Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: SingleChildScrollView(
            child: (getdata)
                ? ListBody(
                    children: [
                      (warnig_to_display == "")
                          ? Text('This is a demo alert dialog.')
                          : Text(warnig_to_display),
                      S(),
                      Center(
                        child: Expanded(
                          child: editWidget,
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: (warnig_to_display == "")
                        ? Text('This is alert dialog.')
                        : Text(
                            warnig_to_display,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                  ),
          ),
        ),
        actions: [
          (getdata)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        size: 28,
                        color: Colors.green,
                      ),
                      onPressed: onYes_Pressed,
                    ),
                    S(),
                    IconButton(
                      icon: Icon(
                        Icons.thumb_down,
                        size: 28,
                        color: Colors.redAccent,
                      ),
                      onPressed: onNo_Pressed,
                    ),
                  ],
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
                          Navigator.pop(context);
                        },
                      ),
                      S(width: 25, height: 25),
                    ],
                  ),
                ),
        ],
      );
    },
  );
}
