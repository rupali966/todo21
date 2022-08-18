import 'package:flutter/material.dart';
import 'package:persistence/signup/provider/firefun.dart';
import 'package:persistence/util/defaut_widgets.dart';
import 'package:persistence/util/persnal_widgets.dart';

class WorkingScreen extends StatefulWidget {
  const WorkingScreen({Key? key}) : super(key: key);

  @override
  State<WorkingScreen> createState() => _WorkingScreenState();
}

class _WorkingScreenState extends State<WorkingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late fireOper fireop;

  @override
  void initState() {
    // TODO: implement initState
    fireop = fireOper(docName: 'userSignUptest', collectionname: 'userSignUp');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Align(
                alignment: Alignment.center,
                child: ListTile(
                  title: Text('Timer',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      )),
                  subtitle: Text(
                    'Scaibu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Button(
                    hgt: 30,
                    rad: 5,
                    onTap: () async {
                      fireop.fire_sign_out();
                    },
                    context,
                    str: "Sign-Out",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      endDrawer: defaultDrawer(context),
      appBar: defaultAppBar(),
      // bottomSheet: showBottomSheet(context: context, builder: builder)
      body: Container(),
    );
  }
}
