import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistence/profile/modal/profile_modal.dart';
import 'package:persistence/util/constant.dart';

class profile_provider extends ChangeNotifier {
  profile_provider({
    this.collectionname = 'userSignUp',
    this.docName = 'userSignUptest',
  });

  String collectionname;
  String docName;
  late UserCredential credential;
  var user;
  profile_modal? pro_modal;

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
    await auth.authStateChanges().listen((User? user) {
      if (user != null) {
        this.pro_modal = profile_modal(
          name: user.displayName.toString(),
          emailAddress: user.email.toString(),
          profilePhoto: user.photoURL.toString(),
          provider: user.providerData.toString(),
          uid: user.uid,
        );
        print("user data :${user.uid}");
      }
    });
    return this.pro_modal;
  }
}
