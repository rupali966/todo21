import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/profile/modal/profile_modal.dart';
import 'package:persistence/profile/provider/profile_provider.dart';
import 'package:persistence/signup/provider/firefun.dart';
import 'package:persistence/util/ErrorScreen.dart';
import 'package:persistence/util/WaitingScreeen.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/defaut_widgets.dart';
import 'package:persistence/util/dialog.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:provider/provider.dart';

import '../../signin/view/login_required_screen.dart';
import '../../util/app_componet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController usrchnge_nm = TextEditingController();
  TextEditingController usrchng_mail = TextEditingController();

  TextEditingController prev_mail = TextEditingController();
  TextEditingController pass = TextEditingController();
  var data;
  String name = "";
  String email = "";
  fireOper fireop = fireOper(
    docName: 'userSignUptest',
    collectionname: 'userSignUp',
  );
  profile_modal? pr;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar', style: appbarTextStyle),
      ),
      body: Consumer<profile_provider>(builder: (context, logic_provider, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: userSignUpDoc,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return ErrorScreen('Error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                fireop.fire_auth();
                logic_provider.retrive_details();
                return WaitingScreen("Loading");
              }
              if (snapshot.connectionState == ConnectionState.active) {
                if (logic_provider.pro_modal.name == 'null' && logic_provider.pro_modal.pass == 'null') {
                  logic_provider.initialize_data(snapshot);
                  return Login_required(log_in_required: 'Login required');
                } else {
                  if (fireop.user_sign_in) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              logic_provider.update_image();
                            },
                            child: (logic_provider.image.path == '')
                                ? CircleAvatar(
                                    backgroundColor: Colors.redAccent,
                                    radius: 120,
                                  )
                                : CircleAvatar(
                                    radius: 120,
                                    foregroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                      logic_provider.image.path,
                                    ),
                                  ),
                          ),
                          SizedBox(height: 20, width: 20),
                          Text(""),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ListOfText(herizonatal: false, listOfWidget: [
                              Row(
                                children: [
                                  Text('Name', style: TextStyle(fontSize: 13, color: Colors.blue)),
                                  Expanded(child: S()),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blueAccent,
                                        size: 24,
                                      )),
                                ],
                              ),
                              text(
                                  clr: Colors.blueAccent,
                                  str: "Name : ",
                                  edit: true,
                                  onPresd: () async {
                                    await confirm_alertbox(
                                        input_from_user: true,
                                        context: context,
                                        warnig: "Do you really want to edit ?",
                                        Input_wid: textInput(editcntrl: usrchnge_nm),
                                        Yes_Press: () {
                                          logic_provider.update_username(
                                            name: usrchnge_nm.text.toString(),
                                          );
                                          Navigator.pushNamed(context, 'profile');
                                          Navigator.pop(context);
                                        },
                                        No_Press: () {
                                          Navigator.pushNamed(context, 'profile');
                                          Navigator.pop(context);
                                        });
                                  }),
                              //showing the user name
                              Text(style: TextStyle(fontSize: 13), "${logic_provider.pro_modal.name}"),
                              Divider(),
                            ]),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ListOfText(herizonatal: false, listOfWidget: [
                              text(
                                  clr: Colors.blueAccent,
                                  str: "Email : ",
                                  edit: true,
                                  onPresd: () async {
                                    await confirm_alertbox(
                                      input_from_user: true,
                                      context: context,
                                      warnig: "Do you really want to edit ?",
                                      Input_wid: Column(
                                        children: [
                                          textInput(
                                            hgt: 50,
                                            lbltxt: 'Enter the previous e-mail',
                                            editcntrl: prev_mail,
                                          ),
                                          S(),
                                          textInput(
                                            hgt: 50,
                                            lbltxt: 'Enter the password',
                                            editcntrl: pass,
                                          ),
                                          S(),
                                          textInput(
                                            hgt: 50,
                                            lbltxt: 'Enter the e-mail for update',
                                            editcntrl: usrchng_mail,
                                          ),
                                        ],
                                      ),
                                      Yes_Press: () async {
                                        logic_provider.update_email(
                                          previous_mail: prev_mail.text.toString(),
                                          pass: pass.text.toString(),
                                          email: usrchng_mail.text.toString(),
                                        );
                                        Navigator.pushNamed(context, 'profile');
                                        Navigator.pop(context);
                                      },
                                      No_Press: () {
                                        Navigator.pushNamed(context, 'profile');
                                        Navigator.pop(context);
                                      },
                                    );
                                  }),
                              // showing the email
                              Text("${logic_provider.pro_modal.emailAddress}", style: TextStyle(fontSize: 13)),
                              Divider(),
                            ]),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return LoginRequiredScreen("Login Is Required ");
                  }
                }
              }
              return LoginRequiredScreen("Login Is Required ");
            });
      }),
    );
  }
}
