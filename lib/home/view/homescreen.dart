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
          leading: Column(
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
          title: Text("Timer"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Button(
                onTap: () {
                  Navigate(context, routeName: 'signup');
                },
                context,
                str: "Sign-Up",
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Button(
                onTap: () {
                  Navigate(context, routeName: 'signin');
                },
                context,
                str: "Sign-In",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
