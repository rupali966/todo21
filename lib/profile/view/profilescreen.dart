import 'package:flutter/material.dart';
import 'package:persistence/signup/modal/signup_data.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/dialog.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      body: Consumer<signupProvider>(
        builder: ((context, value, child) {
          // true condition is == 1 not 0

          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 120,
                ),
                S(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ListOfText(herizonatal: false, listOfWidget: [
                    text(
                        clr: Colors.blueAccent,
                        str: "Name :",
                        edit: true,
                        onPresd: () async {
                          if (await confirm_alertbox(
                            getdata: true,
                            context,
                            warnig_to_display: "Do you really want to edit ?",
                          )) {
                            print("value = ${value.Data.name1}");
                            Provider.of<signupProvider>(context,listen: false).Data.name1 = user_name_to_chanege;
                            print("${value.Data.name1}");

                            print("${user_name_to_chanege}");
                          }
                        }),
                    text(
                      size: 13,
                      str: "${value.Data.name1}"
                    ),

                    Divider(),
                  ]),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ListOfText(herizonatal: false, listOfWidget: [
                    text(
                      clr: Colors.blueAccent,
                      str: "Email :",
                      edit: true,
                    ),
                    text(
                      str: (value.Data.email1 == "")
                          ? ""
                          : "${value.getData().email1}",
                    ),
                    Divider(),
                  ]),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ListOfText(herizonatal: false, listOfWidget: [
                    text(
                      clr: Colors.blueAccent,
                      str: "Contact :",
                      edit: true,
                    ),
                    text(
                      str: "+919664920749",
                    ),
                    Divider(),
                  ]),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
