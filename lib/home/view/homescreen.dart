import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/signup/provider/firefun.dart';
import 'package:persistence/util/ErrorScreen.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:persistence/work/view/workscreen.dart';
import 'package:provider/provider.dart';

import '../../util/StreamDoneScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> _usersStream = fire.collection('userSignUp').snapshots();
  late fireOper fireop;
  bool? sign_in;

  @override
  void initState() {
    fireop = fireOper(docName: 'userSignUptest', collectionname: 'userSignUp');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<fireOper>(
        builder: (context, value, child) {
          return Scaffold(
            body: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ErrorScreen("Error");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  fireop.fire_auth();
                  return Container(
                    alignment: Alignment.center,
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: text2(str: "Loading")),
                          SizedBox(height: 20, width: 20),
                          CircularProgressIndicator(semanticsLabel: 'Loading'),
                        ],
                      ),
                    ),
                  );
                  // loddingWidget();
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  if (fireop.user_sign_in) {
                    return WorkingScreen();
                  } else {
                    return Scaffold(
                      appBar: AppBar(
                        leading: Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.person),
                              tooltip: 'Profile',
                              onPressed: () {
                                Navigator.pushNamed(context, 'profile');
                              },
                            )
                          ],
                        ),
                        title: Text("Timer"),
                      ),
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'signup');
                            },
                            child: Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                              child: Text('SignUp', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'signin');
                            },
                            child: Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                              child: Text('Sign-In', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
                return StreamDoneScreen('Done');
              },
            ),
          );
        },
      ),
    );
  }
}
