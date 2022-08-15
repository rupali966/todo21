import 'package:flutter/material.dart';
import 'package:persistence/util/persnal_widgets.dart';

confirm_alertbox({
  required BuildContext context,
  String warnig_to_display = "",
  bool getdata = false,
  VoidCallback? onYes_Pressed,
  VoidCallback? onNo_Pressed,
  required Widget editWidget,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: (getdata) ? Text('Edit') : Text("Alert-box"),
        content: SingleChildScrollView(
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
                      : Text(warnig_to_display),
                ),
        ),
        actions: [
          (getdata)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: txtbtn(str: 'Yes', clr: Colors.green),
                      onPressed: onYes_Pressed,
                    ),
                    TextButton(
                      child: txtbtn(str: 'No', clr: Colors.redAccent),
                      onPressed: onNo_Pressed,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: txtbtn(str: 'Yes', clr: Colors.green),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
        ],
      );
    },
  );
}

class dialogmodal {
  bool yesorno;
  String userinfo;

  dialogmodal({required this.yesorno, required this.userinfo});
}
