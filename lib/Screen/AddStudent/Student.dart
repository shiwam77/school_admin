import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:school_admin/Screen/Class_Subject_Setup/ClassWithSubject.dart';

class Student extends StatefulWidget {
  Student({Key key}) : super(key: key);


  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  List<DropdownMenuItem<Session>> _dropdownMenuItems;
  Session _selectedSession;

  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(
      gutterSize: 0,
    );
    _dropdownMenuItems = buildDropDownMenuItems(Session.getSession);
    setState(() {
      _selectedSession = _dropdownMenuItems[0].value;
      //subjectList = getSubject.toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: BootstrapContainer(
            fluid: false,
            padding: const EdgeInsets.only(top: 10),
            children: <Widget>[
            BootstrapRow(
            height:MediaQuery.of(context).size.height,
            children: <BootstrapCol>[
              BootstrapCol(
                sizes: 'col-6',
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BootstrapRow(
                      height: 50,
                      children: [
                        BootstrapCol( sizes: 'col-3',child: DropDownWidget(items: _dropdownMenuItems,selected: _selectedSession)),

                        BootstrapCol(sizes: 'col-3',child: DropDownWidget(items: _dropdownMenuItems,selected: _selectedSession)),
                      ],
                    ),

                    SizedBox(height: 10,),
                    ContentWidget(
                      text: 'col 2 of 2',
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              BootstrapCol(
                //offsets: ,
                //orders: ,
                sizes: 'col-6',
                child: ContentWidget(
                  text: 'col 2 of 2',
                  color: Colors.red,
                ),
              ),
            ]),

    ]));

  }
  List<DropdownMenuItem<Session>> buildDropDownMenuItems(
      List<Session> getSession) {
    List<DropdownMenuItem<Session>> items = List();
    for (Session session in getSession) {
      items.add(DropdownMenuItem(
        value: session,
        child: Text(session.year),
      ));
    }
    return items;
  }

  Widget DropDownWidget({List<DropdownMenuItem<dynamic>> items,dynamic selected}){
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
        child: DropdownButton(
          icon: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF718096),
            ),
          ),
          underline: Container(
            height: 1,
            color: Colors.transparent,
          ),
          items: items,
          value: selected,
          onChanged: (dynamic session) {
            setState(() {
              selected = session;
            });
          },
        ),
      ),
    );
  }
}
class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key key,
    this.text,
    this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 50,
      color: color,
      child: Text(text),
    );
  }
}