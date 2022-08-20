import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/profile/provider/profile_provider.dart';
import 'package:persistence/signin/provider/signinprovider.dart';
import 'package:persistence/signup/provider/firefun.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/defaut_widgets.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:persistence/work/view/workscreen.dart';
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
  fireOper fireop =
      fireOper(docName: 'userSignUptest', collectionname: 'userSignUp');
  profile_provider profile_pr = profile_provider();

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
              fireop.fire_auth();
              return loddingWidget();
            }

            if (fireop.user_sign_in) {
              return WorkingScreen();
            } else {
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

                            // check is user is sign in
                            if (await fireop.user_sign_in) {
                              print(
                                  'user is signin = ${await fireop.user_sign_in}');
                              // check is verified the dont sow the dialog and directly log in

                              await profile_pr.is_mail_verifired(context);

                              // await auth
                              //     .authStateChanges()
                              //     .listen((User? user) async {
                              //   // hare we are checking is email verifired is yes login else ask for verification
                              //   if (user!.emailVerified == true) {
                              //     print(
                              //         'email verification = ${user.emailVerified}');
                              //     snackbarrr(ctx, msg: "Logging ...");
                              //     Navigator.pushNamed(context, '/');
                              //   } else {
                              //     print(
                              //         'email verification = ${user.emailVerified}');
                              //     await confirm_alertbox(
                              //         alrt_title: 'Verify your email',
                              //         context: context,
                              //         editWidget: Text('data'),
                              //         warnig_to_display:
                              //             'Would you like to verify your email id.',
                              //         onYes_Pressed: () async {
                              //           await profile_pr
                              //               .retrive_details(); // init detail the send email for verification
                              //           await profile_pr
                              //               .send_email_for_verification();
                              //           Navigator.pushNamed(context, '/');
                              //           Navigator.pop(context);
                              //           print('--Yes--');
                              //         },
                              //         onNo_Pressed: () async {
                              //           // if the pressed no the homescreen
                              //           Navigator.pushNamed(context, '/');
                              //           Navigator.pop(context);
                              //           print('--No--');
                              //         });
                              //   }
                              // });
                            } else {
                              snackbarrr(ctx,
                                  msg: "Wrong User-Name or PassWord");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
