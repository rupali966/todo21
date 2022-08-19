import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistence/signup/modal/signup_data.dart';
import 'package:persistence/util/persnal_widgets.dart';


class fireOper extends ChangeNotifier {
  fireOper({required this.collectionname, required this.docName});

  bool user_sign_in = false;
  String collectionname;
  String docName;
  final fire = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isRegistrationexist = true;
  Map<String, dynamic> signin_true = {'signin': true};
  Map<String, dynamic> signin_false = {'signin': false};
  late UserCredential credential;

  // final docRef = FirebaseFirestore.instance.collection("${collectionname}").doc("$docName");
  doc_ref() {
    notifyListeners();
    return fire.collection("${collectionname}").doc("$docName");
  }

  // document will write at an condition
  force_write_for_usersignup({
    required user_signup_modal data,
  }) async {
    dynamic collectionRef = fire.collection("${collectionname.toString()}");
    final docRef = collectionRef
        .withConverter(
          fromFirestore: user_signup_modal.fromFirestore,
          toFirestore: (user_signup_modal, options) => data.toFirestore(),
        )
        .doc("${docName.toString()}");
    await docRef.set(data);
  }

  // check is data exist and if yes then no write with curent crendit
  safe_write_usersignup(
    context, {
    required user_signup_modal data,
  }) async {
    dynamic curr_dt = await get_data();
    if (curr_dt['name'] == data.name1 &&
        curr_dt['pass'] == data.pass1 &&
        curr_dt['email'] == data.email1 &&
        curr_dt['id'] == data.id1) {
      snackbarrr(
        context,
        msg: 'User already exists go to Sign-in',
        action: SnackBarAction(
          textColor: Colors.yellowAccent,
          label: 'Sign-In',
          onPressed: () {
            Navigator.pushNamed(context, 'signin');
          },
        ),
      );
    } else {
      force_write_for_usersignup(data: data);
      snackbarrr(context, msg: 'Saving ...', bgclr: Colors.green);
    }
    notifyListeners();
  }

  // user for data retriver
  get_data() async {
    final docRef = fire.collection(collectionname).doc(docName);
    var data = docRef.get().then(
      (DocumentSnapshot doc) {
        print(doc.data());
        return doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print("Error getting document: $e"),
    );
    notifyListeners();

    return data;
  }

  SendEmail_For_Authntication() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // user for email registration
  fire_registration({
    String? email,
    String? pass,
  }) async {
    Map<String, dynamic> data = await get_data();
    print(data);

    try {
      credential = await auth.createUserWithEmailAndPassword(
          email: email.toString(), password: pass.toString());
      isRegistrationexist = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        isRegistrationexist = true;
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
    return isRegistrationexist;
  }

  // and do the sign in
  fire_Signin(
    context, {
    required String e_mail,
    required String passWord,
  }) async {
    await fire_auth();
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: e_mail, password: passWord);
      await fire.collection('userSignUp').doc('Sign-In').set(signin_true);
      this.user_sign_in = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        snackbarrr(context, msg: 'No user found for that email.');
        // print('No user found for that email.');
        this.user_sign_in = false;
      } else if (e.code == 'wrong-password') {
        snackbarrr(context, msg: 'Wrong password provided for that user.');
        this.user_sign_in = false;
        // print('Wrong password provided for that user.');
      }
    }
    notifyListeners();

    // print("Done");
  }

  // sign out method
  fire_sign_out() async {
    await auth.signOut();
    this.user_sign_in = false;
    fire.collection('userSignUp').doc('userSignUptest').set({});
    fire.collection('userSignUp').doc('Sign-In').set(signin_false);
    // print('Sign-Out');
    notifyListeners();
  }

  // user for checking is user is sign in or not
  fire_auth() async {
    await auth.authStateChanges().listen((User? user) {
      if (user == null) {
        // print('User is currently signed out!');
        fire.collection('userSignUp').doc('Sign-In').set(signin_false);
        this.user_sign_in = false;
      } else {
        // print('User is signed in!');
        fire.collection('userSignUp').doc('Sign-In').set(signin_true);
        this.user_sign_in = true;
      }
    });
    notifyListeners();
    return 'firebase authentication';
  }
}
