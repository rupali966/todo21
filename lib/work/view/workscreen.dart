import 'package:flutter/material.dart';
import 'package:persistence/signup/provider/firefun.dart';
import 'package:persistence/util/defaut_widgets.dart';
import 'package:persistence/util/dialog.dart';
import 'package:persistence/util/persnal_widgets.dart';
import 'package:persistence/work/provider/work_provider.dart';
import 'package:provider/provider.dart';

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
    fireop = fireOper(docName: 'userSignUptest', collectionname: 'userSignUp');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<work_provider>(
      builder: (context, work_logic, Widg) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                drawerheadear(),
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
          endDrawer: defaultDrawer(
            context,
          ),
          appBar: defaultAppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'profile');
                  },
                  icon: Icon(Icons.menu))),
          // bottomSheet: showBottomSheet(context: context, builder: builder)
          body: Container(),
          floatingActionButton: (work_logic.multiple_floting)
              ? FloatingActionButton(
                  onPressed: () {
                    work_logic.change_floting();
                    bottomsheet(context);
                  },
                  child: Icon(Icons.add),
                  tooltip: 'Add task',
                )
              : multiple_flotingactionbutton(context),
        );
      },
    );
  }
}
