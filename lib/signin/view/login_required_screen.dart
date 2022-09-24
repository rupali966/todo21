// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LoginRequiredScreen extends StatefulWidget {
  LoginRequiredScreen(
    this.loginRequired, {
    Key? key,
  }) : super(key: key);
  String loginRequired;

  @override
  State<LoginRequiredScreen> createState() => _LoginRequiredScreenState();
}

class _LoginRequiredScreenState extends State<LoginRequiredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text((widget.loginRequired == null) ? "Error " : widget.loginRequired, style: TextStyle(fontSize: 21)),
      ),
    );
    ;
  }
}
