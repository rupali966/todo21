import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  XFile image = XFile('');
  profile_modal pro_modal = profile_modal(
    pass: '',
    provider: '',
    uid: '',
    name: '',
    emailAddress: '',
    profilePhoto: '',
  );

  initialize_data(snapshot) {
    snapshot.data!.docs.forEach((e) {
      if (e.id == 'userSignUptest') {
        var dataref = e.data() as Map<String, dynamic>;
        pro_modal.name = dataref['name'].toString();
        pro_modal.pass = dataref['email'].toString();
      }
    });
    notifyListeners();
  }

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

  Future<profile_modal> retrive_details() async {
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
            Alrt_Title: 'Verify your email',
            context: context,
            Input_wid: Text('data'),
            warnig: 'Would you like to verify your email id.',
            Yes_Press: () async {
              await retrive_details(); // init detail the send email for verification
              await send_email_for_verification();
              Navigator.pushNamed(context, '/');
              Navigator.pop(context);
              print('--Yes--');
            },
            No_Press: () async {
              // if the pressed no the homescreen
              Navigator.pushNamed(context, '/');
              Navigator.pop(context);
              print('--No--');
            });
      }
    });
  }

  update_username({required String name}) async {
    auth.authStateChanges().listen((User? user) {
      user!.updateDisplayName(name);
      print('name update successfully ...${user.displayName}');
    });
    this.pro_modal.name = name;
    notifyListeners();
  }

  update_email({
    required String pass,
    required String previous_mail,
    required String email,
  }) async {
    auth.signInWithEmailAndPassword(email: previous_mail, password: pass).then((usr) {
      usr.user!.updateEmail(email);
      print('Email update successfully ...${user.email}');
    }).onError((error, stackTrace) {
      print('error : ${error}');
    });
    this.pro_modal.emailAddress = email;
    notifyListeners();
  }

  update_image() async {
    final ImagePicker _picker = ImagePicker();
    this.image = (await _picker.pickImage(source: ImageSource.gallery))!;
    notifyListeners();
  }
}
