import 'package:flutter/material.dart';
import 'package:persistence/util/constant.dart';

class sign_in_provider extends ChangeNotifier {
  dynamic data;
  bool signin = false;
  String? name;
  String? pass;
  String? email;
  var dtt;

  void getdt({
    String? name,
    String? pass,
    String? email,
  }) {
    this.name = name as String;
    this.pass = pass as String;
    this.email = email as String;
  }

  bool validate({
    String? name,
    String? pass,
    String? email,
  }) {
    if ((name == this.name && pass == this.pass) || (email == this.email)) {
      this.signin = true;
      return true;
    } else {
      this.signin = false;
      return false;
    }
  }

  void setdata({dynamic dt}) {
    data = dt;
  }

  void sign_in(bool signin_val) {
    if (signin_val) {
      var data = {"signin": true};
      fire.collection("userSignUp").doc("Sign-In").set(
            data,
          );
    } else {
      var data = {"signin": false};
      fire.collection("userSignUp").doc("Sign-In").set(
            data,
          );
    }

    print("Value is Changing ..");
    this.signin = signin_val;
  }

  void is_signIn() async {
    var k = fire
        .collection('userSignUp')
        .doc('Sign-In')
        .snapshots()
        .listen((event) {
      print(event.data()!['signin']);
      this.dtt = event.data()!['signin'];
    });
    k;
  }
}
