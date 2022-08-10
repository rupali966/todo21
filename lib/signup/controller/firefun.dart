import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persistence/signup/modal/signup_data.dart';

writing_data({required user_signup_modal data}) async {
  dynamic collectionRef = FirebaseFirestore.instance.collection("userSignUp");
  final docRef = collectionRef
      .withConverter(
        fromFirestore: user_signup_modal.fromFirestore,
        toFirestore: (user_signup_modal, options) => data.toFirestore(),
      )
      .doc("userSignUptest");
  await docRef.set(data);
}

get_data({
  required String collectionname,
  required String docName,
}) async {
  dynamic collectionRef = FirebaseFirestore.instance.collection(collectionname);
  final refrenceof = collectionRef.doc(docName);
  refrenceof.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      return data;
    },
  );
  Map<String, dynamic> data = {
    "null": "null",
  };
  return data;
}
