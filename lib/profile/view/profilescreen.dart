import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/profile/modal/profile_modal.dart';
import 'package:persistence/profile/provider/profile_provider.dart';
import 'package:persistence/signup/provider/firefun.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/defaut_widgets.dart';
import 'package:persistence/util/dialog.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController userchange_name = TextEditingController();
  TextEditingController userchange_email = TextEditingController();
  var data;
  String name = "";
  String email = "";
  fireOper fireop =
      fireOper(docName: 'userSignUptest', collectionname: 'userSignUp');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(),
      body:
          Consumer<profile_provider>(builder: (context, logic_provider, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: userSignUpDoc,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return hasErrorWidget();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                fireop.fire_auth();

                return loddingWidget();
              }
              if (snapshot.connectionState == ConnectionState.active) {
                snapshot.data!.docs.forEach((e) {
                  if (e.id == 'userSignUptest') {
                    var dataref = e.data() as Map<String, dynamic>;
                    name = dataref['name'].toString();
                    email = dataref['email'].toString();
                  }
                });
                if (name == 'null' && email == 'null') {
                  return Login_required(log_in_required: 'Login required');
                } else {
                  if (fireop.user_sign_in) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            radius: 120,
                          ),
                          S(),
                          text(str: ""),
                          Align(
                            alignment: Alignment.centerLeft,
                            child:
                                ListOfText(herizonatal: false, listOfWidget: [
                              text(
                                  clr: Colors.blueAccent,
                                  str: "Name : ",
                                  edit: true,
                                  onPresd: () async {
                                    await confirm_alertbox(
                                        getdata: true,
                                        context: context,
                                        warnig_to_display:
                                            "Do you really want to edit ?",
                                        editWidget: textInput(
                                            editcntrl: userchange_name),
                                        onYes_Pressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        onNo_Pressed: () {
                                          Navigator.of(context).pop();
                                        });
                                  }),
                              //showing the user name
                              text(size: 13, str: "${name}"),
                              Divider(),
                            ]),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child:
                                ListOfText(herizonatal: false, listOfWidget: [
                              text(
                                  clr: Colors.blueAccent,
                                  str: "Email : ",
                                  edit: true,
                                  onPresd: () async {
                                    await confirm_alertbox(
                                        getdata: true,
                                        context: context,
                                        warnig_to_display:
                                            "Do you really want to edit ?",
                                        editWidget: textInput(
                                          editcntrl: userchange_email,
                                        ),
                                        onYes_Pressed: () async {
                                          Navigator.of(context).pop();
                                        },
                                        onNo_Pressed: () {
                                          Navigator.of(context).pop();
                                        });
                                  }),
                              // showing the email
                              text(size: 13, str: "${email}"),
                              Divider(),
                              Center(
                                child: Button(str: 'test', context,
                                    onTap: () async {
                                  print('test');

                                  profile_modal data =
                                      await logic_provider.retrive_details();
                                  print(data.uid);
                                }),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Login_required(log_in_required: 'Login required');
                  }
                }
              }
              return Login_required(log_in_required: 'Login required');
            });
      }),
    );
  }
}
