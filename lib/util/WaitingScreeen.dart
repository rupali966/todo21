// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  WaitingScreen(
    this.waiting, {
    Key? key,
  }) : super(key: key);
  String waiting;

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.waiting),
          SizedBox(height: 20, width: 20),
          CircularProgressIndicator(
            semanticsLabel: 'Loading',
          ),
        ],
      ),
    );
  }
}
