import 'package:flutter/material.dart';

class Homework extends StatefulWidget {
  Homework({Key key}) : super(key: key);

  @override
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Homework"),
      ),
    );
  }
}
