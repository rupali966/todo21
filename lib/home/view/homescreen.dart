import 'package:flutter/material.dart';
import 'package:persistence/util/persnal_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'profile');
                  },
                  icon: Icon(Icons.person),
                  tooltip: 'Profile',
                ),
              ],
            ),
          ),
          title: Text("Timer"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Button(
                context,
                str: "Sign-Up",
                routeName: 'signup',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Button(
                context,
                str: "Sign-In",
                routeName: 'signin',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
