import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/signin/provider/signinprovider.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/defaut_widgets.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final Stream<QuerySnapshot> _usersStream =
      fire.collection('userSignUp').snapshots();

  @override
  Widget build(BuildContext context) {
    return Consumer<sign_in_provider>(
      builder: (context, v, _) {
        return StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (ctx, snapshot) {
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
                        ctx,
                        str: 'Sign-In',
                        onTap: () async {
                          String usrname = username.text;
                          String pass = password.text;
                          sign_in_provider pr =
                              Provider.of<sign_in_provider>(ctx, listen: false);
                          dynamic dt = snapshot.data!.docs.map((e) {
                            var currdt = e.data()! as Map<String, dynamic>;
                            if (e.id == 'userSignUptest') {
                              pr.getdt(
                                  name: currdt['name'],
                                  email: currdt['email'],
                                  pass: currdt['pass']);
                            } else {
                              snackbarrr(ctx, msg: "Parsing Error");
                              pr.getdt(name: '', email: '', pass: '');
                            }
                          });
                          print(dt);
                          if ((usrname == pr.name || usrname == pr.email) &&
                              pass == pr.pass) {
                            pr.sign_in(true);
                            snackbarrr(
                              ctx,
                              msg: "Logging ...",
                            );
                            Navigate(ctx, routeName: 'workscreen');
                          } else {
                            pr.sign_in(false);
                            snackbarrr(ctx, msg: "Wrong User-Name or PassWord");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
