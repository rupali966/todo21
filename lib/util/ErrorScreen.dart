// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  ErrorScreen(this.error_Msg, {Key? key}) : super(key: key);
  String error_Msg;

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        (widget.error_Msg == null) ? "Error " : widget.error_Msg,
        style: TextStyle(fontSize: 21),
      ),
    );
    ;
  }
}
