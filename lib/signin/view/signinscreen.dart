import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/signin/provider/signinprovider.dart';
import 'package:persistence/signup/provider/firefun.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/defaut_widgets.dart';
import 'package:persistence/util/dialog.dart';
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
                          // getting input from the user
                          String usrname = username.text;
                          String pass = password.text;

                          // provider object for working with the provider

                          // object Declaration for performing operations
                          fireOper fireop = fireOper(
                              docName: 'userSignUptest',
                              collectionname: 'userSignUp');

                          await fireop.fire_Signin(context,
                              e_mail: usrname, passWord: pass);

                          await fireop.fire_auth();

                          if (await fireop.user_sign_in) {
                            await confirm_alertbox(
                                context: context,
                                editWidget: Text('data'),
                                warnig_to_display:
                                    'would you like to verify your email id ?');
                            snackbarrr(ctx, msg: "Logging ...");
                            Navigator.pushNamed(context, '/');
                          } else {
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
