import 'package:flutter/material.dart';

class sign_in_provider extends ChangeNotifier {
  dynamic data;
  bool signin = false;
  String? name;
  String? pass;
  String? email;

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
      false;
    }
    this.signin = false;
    return false;
  }

  void setdata({dynamic dt}) {
    data = dt;
  }

  void sign_in(bool signin_val) {
    print("Value is Changing ..");
    this.signin = signin_val;
  }

  bool is_user_is_sign_in() {
    return this.signin;
  }
}
