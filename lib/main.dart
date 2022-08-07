import 'package:flutter/material.dart';
import 'package:persistence/home/view/homescreen.dart';
import 'package:persistence/profile/view/profilescreen.dart';
import 'package:persistence/signin/view/signinscreen.dart';
import 'package:persistence/signup/view/signupscreen.dart';
import 'package:provider/provider.dart';

import 'signup/modal/signup_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<dataOperation>(create: (_) => dataOperation()),
        ListenableProvider<signupProvider>(create: (_) => signupProvider()),
      ],
      child: MaterialApp(
        title: 'Reading and Writing Files',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => HomeScreen(),
          'profile': (context) => ProfileScreen(),
          'signin': (context) => SignInScreen(),
          'signup': (context) => SignUpScreen(),
        },
      ),
    ),
  );
}
