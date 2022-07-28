import 'package:flutter/material.dart';
import 'package:persistence/util/persnal_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appabr = AppBar();
    return Scaffold(
      appBar: appabr = AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: text(
              str: 'Sign Up',
            )),
            S(),
            Center(
              child: textInput(
                hgt: 50,
                wgt: 300,
                lbltxt: 'Name',
              ),
            ),
            S(),
            Center(
              child: textInput(
                lbltxt: "Password",
                hgt: 50,
                wgt: 300,
              ),
            ),
            S(),
            Center(child: Button(context,str: "Save")),
          ],
        ),
      ),
    );
  }
}
