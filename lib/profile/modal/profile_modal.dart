class profile_modal {
  String provider;

  profile_modal({
    required this.pass,
    required this.provider,
    required this.uid,
    required this.name,
    required this.emailAddress,
    required this.profilePhoto,
  });

  String pass;
  String uid;
  String name;
  String emailAddress;
  String profilePhoto;

  void change_name({String? name}) {
    this.name = name.toString();
  }
}
