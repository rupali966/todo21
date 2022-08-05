import 'package:flutter/material.dart';
import 'package:persistence/signup/modal/signup_data.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  dynamic signup;

  @override
  void initState() {
    signup = Provider.of<signupProvider>(context, listen: false);
    super.initState();
  }

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
                textEditingController: username,
                hgt: 50,
                wgt: 300,
                lbltxt: 'Name',
              ),
            ),
            S(),
            Center(
              child: textInput(
                textEditingController: email,
                hgt: 50,
                wgt: 300,
                lbltxt: 'Email',
              ),
            ),
            S(),
            Center(
              child: textInput(
                textEditingController: password,
                lbltxt: "Password",
                hgt: 50,
                wgt: 300,
              ),
            ),
            S(),
            Center(
                child: Button(context, str: "Save", onTap: () async {
                  usrsignUp usr1 = usrsignUp(
                id1: 1,
                name1: username.text,
                pass1: password.text,
                email1: email.text,
              );

              signup.setData(setdt: usr1);
              // iitilizig the data
              dataOperation op = dataOperation();
              final database2 = op.data_initialization();
              database2;
              op.insert_data(usr1, database2);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(
                    "Saving ...       ${username.text}",
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
