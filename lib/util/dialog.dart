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
      return AlertDialog(
        scrollable: true,
        elevation: 0.2,
        alignment: Alignment.center,
        title: (getdata)
            ? Text('Edit')
            : Text("$alrt_title",
                style: TextStyle(
                  fontSize: 16,
                  inherit: true,
                )),
        content: Container(
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
                              fontSize: 12,
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.thumb_up,
                          size: 28,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.thumb_down,
                          size: 28,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
        ],
      );
    },
  );
}
