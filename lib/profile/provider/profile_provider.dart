import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistence/profile/modal/profile_modal.dart';
import 'package:persistence/util/constant.dart';
import 'package:persistence/util/dialog.dart';
import 'package:persistence/util/persnal_widgets.dart';

class profile_provider extends ChangeNotifier {
  profile_provider({
    this.collectionname = 'userSignUp',
    this.docName = 'userSignUptest',
  });

  String collectionname;
  String docName;
  bool isVerfied = false;
  late UserCredential credential;
  var user;
  profile_modal pro_modal = profile_modal(
    provider: '',
    uid: '',
    name: '',
    emailAddress: '',
    profilePhoto: '',
  );

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

  get_credential() async {
    var data = await get_data();
    if (data != null) {
      credential = await auth.signInWithEmailAndPassword(
          email: data['email'], password: data['pass']);
      this.user = credential.user;
      return credential;
    }
  }

  get_user_uid() {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        print(user.uid);
      }
    });
  }

  retrive_details() async {
    // use for retrival of common details
    await auth.authStateChanges().listen((User? user) {
      if (user != null) {
        this.pro_modal.name = user.displayName.toString();
        this.pro_modal.emailAddress = user.email.toString();
        this.pro_modal.profilePhoto = user.photoURL.toString();
        this.pro_modal.provider = user.providerData.toString();
        this.pro_modal.uid = user.uid.toString();
      }
    });
    return pro_modal;
  }

  // use for email verification
  send_email_for_verification() async {
    await auth.authStateChanges().listen((User? user) {
      if (user!.emailVerified) {
        print('Email is Verfied');
      } else {
        user.sendEmailVerification();
        print('email is not verified');
      }
    });
  }

  is_mail_verifired(context) async {
    await auth.authStateChanges().listen((User? user) async {
      // hare we are checking is email verifired is yes login else ask for verification
      if (user!.emailVerified == true) {
        print('email verification = ${user.emailVerified}');
        snackbarrr(context, msg: "Logging ...");
        Navigator.pushNamed(context, '/');
      } else {
        print('email verification = ${user.emailVerified}');
        await confirm_alertbox(
            alrt_title: 'Verify your email',
            context: context,
            editWidget: Text('data'),
            warnig_to_display: 'Would you like to verify your email id.',
            onYes_Pressed: () async {
              await retrive_details(); // init detail the send email for verification
              await send_email_for_verification();
              Navigator.pushNamed(context, '/');
              Navigator.pop(context);
              print('--Yes--');
            },
            onNo_Pressed: () async {
              // if the pressed no the homescreen
              Navigator.pushNamed(context, '/');
              Navigator.pop(context);
              print('--No--');
            });
      }
    });
  }
}
