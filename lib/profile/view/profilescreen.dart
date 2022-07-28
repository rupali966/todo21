import 'package:flutter/material.dart';
import 'package:persistence/util/persnal_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          height: 50,
          width: 50,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.person),
        ),
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Text("Profle"),
          Container(),
        ],
      ),
    );
  }
}
