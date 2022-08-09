import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/signup/modal/signup_data.dart';
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
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.person),
        ),
        title: Text('Profile '),
      ),
      body: Consumer<signupProvider>(builder: (context, value, child) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
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
                            str: "Email :",
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

                                    // final user = <String, dynamic>{
                                    //   "first": "Ada",
                                    //   "last": "Lovelace",
                                    //   "born": 1815
                                    // };
                                    // dynamic db = FirebaseFirestore.instance;
                                    // db.collection("users").add(user).then((DocumentReference doc) =>
                                    //     print('DocumentSnapshot added with ID: ${doc.id}'));
                                    // await db.collection("users").get().then((event) {
                                    //   for (var doc in event.docs) {
                                    //     print("${doc.id} => ${doc.data()}");
                                    //   }
                                    // });
                                    // db.collection("users").doc("1bnwOYfUUB5dLRnzI0F9").set({"first": "xxxxxx"});
                                    // db.collection("users").doc("1bnwOYfUUB5dLRnzI0F9").delete().then(
                                    //       (doc) => print("Document deleted"),
                                    //   onError: (e) => print("Error updating document $e"),
                                    // );

                                    Navigator.of(context).pop();
                                  },
                                  onNo_Pressed: () {
                                    Navigator.of(context).pop();
                                  });
                            }),
                        text(size: 13, str: "${value.Data.email1}"),
                        Divider(),
                      ]),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListOfText(herizonatal: false, listOfWidget: [
                        text(
                            clr: Colors.blueAccent,
                            str: "Name :",
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
                        text(size: 13, str: "${value.Data.name1}"),
                        Divider(),
                      ]),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
