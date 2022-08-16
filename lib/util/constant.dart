import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String user_name_to_chanege = "";
String user_email_to_chanege = "";

TextStyle appbarTextStyle = TextStyle(
  fontSize: 12,
);
var fire = FirebaseFirestore.instance;
final Stream<QuerySnapshot> userSignUpReferColle =
    fire.collection('userSignUp').snapshots();
Stream<QuerySnapshot> userSignUpDoc = fire.collection('userSignUp').snapshots();
FirebaseAuth auth = FirebaseAuth.instance;