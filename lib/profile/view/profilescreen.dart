import 'package:flutter/material.dart';
import 'package:persistence/signup/modal/signup_data.dart';
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
          if (value.getData().id1 == 1) {
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
                      text(clr: Colors.blueAccent, str: "Name :", edit: true),
                      text(
                        size: 13,
                        str: "${value.getData().name1}",
                      ),
                      Divider(),
                    ]),
                  ),
                  S(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ListOfText(herizonatal: false, listOfWidget: [
                      text(
                        clr: Colors.blueAccent,
                        str: "Email :",
                        edit: true,
                      ),
                      text(
                        str: "${value.getData().email1}",
                        size: 13,
                      ),
                      Divider(),
                    ]),
                  ),
                  S(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ListOfText(herizonatal: false, listOfWidget: [
                      text(
                          clr: Colors.blueAccent, str: "Contact :", edit: true),
                      text(
                        str: "+919664920749",
                        size: 13,
                      ),
                      Divider(),
                    ]),
                  ),
                  S(),
                  Container(),
                ],
              ),
            );
          } else {
            // /* Navigator.pushNamed(context, 'signup');*/
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 200,
                    child: Expanded(
                      child: text(
                        size: 20,
                        str: "No Data Is Avalible Go To SignIn or SignUp",
                      ),
                    ),
                  ),
                  S(),
                  Button(context, str: "Sign-Up", routeName: 'signup'),
                  S(height: 10),
                  Button(context, str: "Sign-In", routeName: 'signin')
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
