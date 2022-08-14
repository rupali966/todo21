import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/signup/modal/signup_data.dart';
import 'package:persistence/signup/provider/firefun.dart';
import 'package:persistence/util/defaut_widgets.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  dynamic db = FirebaseFirestore.instance;
  dynamic collectionRef = FirebaseFirestore.instance.collection("userSignUp");
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("userSignUp").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return hasErrorWidget(
                ErrorMsg: "Error while retrieving data from server");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loddingWidget();
          }
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
                      child: text2(
                    str: 'Sign Up',
                  )),
                  S(),
                  Center(
                    child: textInput(
                      editcntrl: username,
                      hgt: 50,
                      wgt: 300,
                      lbltxt: 'Name',
                    ),
                  ),
                  S(),
                  Center(
                    child: textInput(
                      editcntrl: email,
                      hgt: 50,
                      wgt: 300,
                      lbltxt: 'Email',
                    ),
                  ),
                  S(),
                  Center(
                    child: textInput(
                      editcntrl: password,
                      lbltxt: "Password",
                      hgt: 50,
                      wgt: 300,
                    ),
                  ),
                  S(),
                  Center(
                      child: Button(context, str: "Save", onTap: () async {
                    final usr1 = user_signup_modal(
                      id1: 1,
                      name1: username.text,
                      pass1: password.text,
                      email1: email.text,
                    );
                    signup.setData(setdt: usr1);
                    fireOper fireop = fireOper(
                      docName: 'userSignUptest',
                      collectionname: 'userSignUp',
                    );
                    fireop.safe_write_usersignup(context, data: usr1);
                  })),
                ],
              ),
            ),
          );
        });
  }
}
