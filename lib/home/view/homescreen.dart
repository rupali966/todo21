import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/signup/provider/firefun.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/defaut_widgets.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:persistence/work/view/workscreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> _usersStream =
      fire.collection('userSignUp').snapshots();
  fireOper fireop =
      fireOper(docName: 'userSignUptest', collectionname: 'userSignUp');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<fireOper>(
        builder: (context, value, child) {
          value.fire_auth();
          return StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return hasErrorWidget();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loddingWidget();
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  print('is User Sign in ${fireop.user_sign_in}');

                  if (value.user_sign_in) {
                    return WorkingScreen();
                  } else {
                    return Scaffold(
                      appBar: AppBar(
                        leading: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'profile');
                              },
                              icon: Icon(Icons.person),
                              tooltip: 'Profile',
                            ),
                          ],
                        ),
                        title: Text("Timer"),
                      ),
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Button(
                              onTap: () {
                                Navigate(context, routeName: 'signup');
                              },
                              context,
                              str: "Sign-Up",
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Button(
                              onTap: () {
                                Navigate(context, routeName: 'signin');
                              },
                              context,
                              str: "Sign-In",
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
                return Stream_Done_Widget(done_msg: "Done");
              });
        },
      ),
    );
  }
}
