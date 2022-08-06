import 'package:flutter/material.dart';
import 'package:persistence/signup/modal/signup_data.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:provider/provider.dart';

confirm_alertbox(
  context, {
  String warnig_to_display = "",
  bool getdata = false,
}) async {
  dialogmodal dgldt;
  TextEditingController userchange = TextEditingController();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
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
                        child: textInput(
                          editcntrl: userchange,
                        ),
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
                      onPressed: () {
                        user_name_to_chanege = userchange.text;
                        Navigator.of(context).pop(true);
                      },
                    ),
                    TextButton(
                      child: txtbtn(str: 'No', clr: Colors.redAccent),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
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

confirmation_box(context, {String warning = ""}) {
  return text(
      clr: Colors.blueAccent,
      edit: true,
      onPresd: () {
        confirm_alertbox(
          context,
          warnig_to_display: warning,
        );
      });
}
