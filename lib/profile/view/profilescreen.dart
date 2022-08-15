import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/signup/modal/signup_data.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          height: 50,
          width: 50,
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.person),
        ),
        title: Text('Profile '),
      ),
      body: Consumer<signupProvider>(builder: (context, value, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: userSignUpDoc,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return hasErrorWidget();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loddingWidget();
              }
              if (snapshot.connectionState == ConnectionState.active) {
                // data = snapshot.data!.docs.map((e) {
                //   Map<String, dynamic> data = e.data()! as Map<String, dynamic>;
                //   return data['name'];
                // });

                data = snapshot.data!.docs.map((e) {
                  if (e.id == 'userSignUptest') {
                    // print(e.data());
                    name = e['name'];
                    email = e['email'];
                    return e['name'];
                  }
                });

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
                        child: ListOfText(herizonatal: false, listOfWidget: [
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
                                      value.change_email(
                                        email: userchange_email.text,
                                      );

                                      Navigator.of(context).pop();
                                    },
                                    onNo_Pressed: () {
                                      Navigator.of(context).pop();
                                    });
                              }),
                          text(size: 13, str: "${email}"),
                          Divider(),
                        ]),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ListOfText(herizonatal: false, listOfWidget: [
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
                                    editWidget:
                                        textInput(editcntrl: userchange_name),
                                    onYes_Pressed: () {
                                      value.change_name(
                                          name: userchange_name.text);
                                      Navigator.of(context).pop();
                                    },
                                    onNo_Pressed: () {
                                      Navigator.of(context).pop();
                                    });
                              }),
                          text(size: 13, str: "${name}"),
                          Divider(),
                        ]),
                      ),
                    ],
                  ),
                );
              }
              return Container(
                color: Colors.green,
              );
            });
      }),
    );
  }
}
