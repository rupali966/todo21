import 'package:flutter/material.dart';
import 'package:persistence/signup/modal/signup_data.dart';
import 'package:persistence/util/persnal_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  usrsignUp usr = usrsignUp(id1: 0, name1: "", pass1: '0000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                textEditingController: usr.name,
                hgt: 50,
                wgt: 300,
                lbltxt: 'Name',
              ),
            ),
            S(),
            Center(
              child: textInput(
                textEditingController: usr.pass,
                lbltxt: "Password",
                hgt: 50,
                wgt: 300,
              ),
            ),
            S(),
            Center(
                child: Button(context, str: "Save", onTap: () async {
              String username = usr.name.text;
              String password = usr.pass.text;
              usrsignUp usr1 = usrsignUp(
                id1: 0,
                name1: username,
                pass1: password,
              );
              final database2 = usr1.dt();
              database2;
              usr1.insertDog(usr1, database2);
              print("${usr1.toString()}");
              List data = await usr1.dogs(database2);
              print('${data}');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Saving .. ${usr.name.text}",
                  ),
                ),
              );
              print("Save");
            })),
          ],
        ),
      ),
    );
  }
}
