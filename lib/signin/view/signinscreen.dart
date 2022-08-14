import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/util/defaut_widgets.dart';
import 'package:persistence/util/persnal_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('userSignUp').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return hasErrorWidget();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loddingWidget();
          }
          return Scaffold(
            appBar: defaultAppBar(),
            body: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: textInput(
                      editcntrl: username,
                      hgt: 50,
                      wgt: 300,
                      lbltxt: 'User Name or Email',
                    ),
                  ),
                  S(),
                  Center(
                    child: textInput(
                      editcntrl: password,
                      hgt: 50,
                      wgt: 300,
                      lbltxt: 'Password',
                    ),
                  ),
                  S(),
                  Center(
                      child: Button(
                    context,
                    str: 'Sign-In',
                    onTap: () {
                      var data = snapshot.data!.docs.map((e) {
                        var data = e.data() as Map<String, dynamic>;
                        if ((data['name'] == username.text ||
                                data['email'] == username.text) &&
                            (data['pass'] == password.text)) {
                          snackbarrr(context, msg: "Logging ...");
                          // Navigate(routeName: );
                          return data;
                        }
                      });
                      print(data);
                    },
                  )),
                ],
              ),
            ),
          );
        });
  }
}
