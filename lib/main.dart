import 'package:flutter/material.dart';
import 'package:persistence/home/view/homescreen.dart';
import 'package:persistence/profile/view/profilescreen.dart';
import 'package:persistence/signin/view/signinscreen.dart';
import 'package:persistence/signup/view/signupscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(),
        'profile': (context) => ProfileScreen(),
        'signin': (context) => SignInScreen(),
        'signup': (context) => SignUpScreen(),
      },
    ),
  );
}
