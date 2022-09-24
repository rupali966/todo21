// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:flutter/material.dart';

class StreamDoneScreen extends StatefulWidget {
  StreamDoneScreen(this.done_msg, {Key? key}) : super(key: key);
  String done_msg;

  @override
  State<StreamDoneScreen> createState() => _StreamDoneScreenState();
}

class _StreamDoneScreenState extends State<StreamDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text((widget.done_msg == null) ? "Error " : 'Done', style: TextStyle(fontSize: 21)),
      ),
    );
  }
}

// class StreamDoneScreen extends StatefulWidget {
//   const StreamDoneScreen({Key? key}) : super(key: key);
//
//   @override
//   State<StreamDoneScreen> createState() => _StreamDoneScreenState();
// }

// class _StreamDoneScreenState extends State {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
