import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence/signup/modal/signup_data.dart';
import 'package:persistence/util/persnal_widgets.dart';

writing_data_for_usersignup({
  required user_signup_modal data,
  String? collection_name,
  String? document_name,
}) async {
  final fire = FirebaseFirestore.instance;
  dynamic collectionRef = fire.collection("${collection_name.toString()}");
  final docRef = collectionRef
      .withConverter(
        fromFirestore: user_signup_modal.fromFirestore,
        toFirestore: (user_signup_modal, options) => data.toFirestore(),
      )
      .doc("${document_name.toString()}");
  await docRef.set(data);
}

Future<Map<String, dynamic>> get_data({
  required String collectionname,
  required String docName,
}) async {
  final fire = FirebaseFirestore.instance;
  final docRef = fire.collection("$collectionname").doc("$docName");
  docRef.get().then(
    (DocumentSnapshot doc) {
      final data1 = doc.data() as Map<String, dynamic>;
      return (data1);
    },
  );
  return {};
}

class fireOper {
  fireOper({required this.collectionname, required this.docName});

  String collectionname;
  String docName;
  final fire = FirebaseFirestore.instance;

  // final docRef = FirebaseFirestore.instance.collection("${collectionname}").doc("$docName");
  doc_ref() {
    return fire.collection("${collectionname}").doc("$docName");
  }

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
      snackbarrr(context, msg: 'Saving ...',bgclr: Colors.green);
    }
  }

  get_data() {
    final docRef = fire.collection(collectionname).doc(docName);
    var data = docRef.get().then(
      (DocumentSnapshot doc) {
        return doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return data;
  }
}
