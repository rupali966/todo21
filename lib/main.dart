import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:persistence/home/view/homescreen.dart';
import 'package:persistence/profile/provider/profile_provider.dart';
import 'package:persistence/profile/view/profilescreen.dart';
import 'package:persistence/signin/view/signinscreen.dart';
import 'package:persistence/signup/view/signupscreen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'signin/provider/signinprovider.dart';
import 'signup/modal/signup_data.dart';
import 'signup/provider/firefun.dart';
import 'work/view/workscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Web.
//   await FirebaseFirestore.instance.enablePersistence();
//
// All other platforms.
//   FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<dataOperation>(create: (_) => dataOperation()),
        ListenableProvider<signupProvider>(create: (_) => signupProvider()),
        ListenableProvider<sign_in_provider>(create: (_) => sign_in_provider()),
        ListenableProvider<fireOper>(
            create: (_) => fireOper(
                docName: 'userSignUptest', collectionname: 'userSignUp')),
        ListenableProvider<profile_provider>(create: (_) => profile_provider()),
      ],
      child: MaterialApp(
        title: 'Reading and Writing Files',
        debugShowCheckedModeBanner: false,
        // initialRoute: 'signin',
        routes: {
          '/': (context) => HomeScreen(),
          'profile': (context) => ProfileScreen(),
          'signin': (context) => SignInScreen(),
          'signup': (context) => SignUpScreen(),
          'workscreen': (context) => WorkingScreen(),
        },
      ),
    ),
  );
}
