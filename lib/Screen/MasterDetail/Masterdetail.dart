import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_admin/Screen/AddAttendance/Attendance.dart';
import 'package:school_admin/Screen/AddStudent/Student.dart';
import 'package:school_admin/Screen/Class_Subject_Setup/ClassWithSubject.dart';
import 'package:school_admin/Screen/CreateHomework/Homework.dart';
import 'package:school_admin/Screen/MasterDetail/indexNotifier.dart';

import '../../main.dart';
import 'CollapsingNavigationBar.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

class MasterDetail extends StatefulWidget {
  @override
  _MasterDetailState createState() => _MasterDetailState();
}

class _MasterDetailState extends State<MasterDetail>
    with SingleTickerProviderStateMixin {
  double maxWidth = 260;
  double minWidth = 60;
  Animation<double> widthAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: minWidth, end: maxWidth)
        .animate(animationController);
  }

  Widget screen;
  @override
  Widget build(BuildContext context) {
    setState(() {
      screen = null;
    });
    return Scaffold(
        drawer: CollapsingNavigationDrawer(),
        body: Row(
          children: <Widget>[
            MediaQuery.of(context).size.width > 420 ?CollapsingNavigationDrawer():SizedBox(),
            Consumer<NavIndex>(
              builder: (context, navindex, child) {
                print(navindex.getCounter());
                if (navindex.getCounter() == 0) {
                  screen = MyHomePage(
                    title: "home",
                  );
                } else if (navindex.getCounter() == 1) {
                  screen = ClassWithSubject();
                } else if (navindex.getCounter() == 2) {
                  screen = Student();
                } else if (navindex.getCounter() == 3) {
                  screen = Homework();
                } else if (navindex.getCounter() == 4) {
                  screen = Attendance();
                } else if (navindex.getCounter() == 5) {
                  screen = ClassWithSubject();
                }
                return Expanded(child: screen);
              },
            ),
          ],
        ));
  }
}

class Page extends StatelessWidget {
  const Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text("hi"),
        ),
      ),
    );
  }
}
