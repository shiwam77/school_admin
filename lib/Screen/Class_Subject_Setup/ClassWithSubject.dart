import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popup_box/popup_box.dart';

class ClassWithSubject extends StatefulWidget {
  ClassWithSubject({Key key}) : super(key: key);

  @override
  _ClassWithSubjectState createState() => _ClassWithSubjectState();
}

class _ClassWithSubjectState extends State<ClassWithSubject> {
  List<DropdownMenuItem<Session>> _dropdownMenuItems;
  Session _selectedSession;
  final ScrollController _scrollController = ScrollController();
  int currentSelectedIndex = 0;
  bool subjectField = false;

  final GlobalKey<AnimatedListState> subjectListKey = GlobalKey();
  List<Subject> subjectList = List(); // getSubject.toList();
  final TextEditingController subjectTextCtrl = new TextEditingController();
  final TextEditingController classTextCtrl = new TextEditingController();
  final TextEditingController subTileCtrl = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(Session.getSession);
    setState(() {
      _selectedSession = _dropdownMenuItems[0].value;
      //subjectList = getSubject.toList();
    });
  }

  List<Class> getClass;
  @override
  Widget build(BuildContext context) {
    setState(() {
      getClass = Class.getClass
          .where((element) => element.sessionId == _selectedSession.id)
          .toList();
    });


    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: 160,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Center(
                    child: Container(
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
                          items: _dropdownMenuItems,
                          value: _selectedSession,
                          onChanged: (Session session) {
                            setState(() {
                              _selectedSession = session;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                getClass.length > 0 ? classListTile() : SizedBox(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () async {
                        await pupUp();
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width:MediaQuery.of(context).size.width > 935?500:300,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.brown[50],
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subject',
                        style: TextStyle(
                            fontSize: 13,
                            color: const Color(0xFF595959),
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w500)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          subjectField = true;
                        });
                      },
                      child: Icon(Icons.add_circle_outline,
                          size: 18,
                          color: const Color(0xFF5567C9).withOpacity(.5)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width > 935?500:300,
                height: 40,
                child: TextField(
                  controller: subjectTextCtrl,
                  enabled: subjectField,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    hintText: 'Add Subject then press Enter',
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      print(value);
                      Subject subject =
                          Subject(UniqueKey().toString(), '0', value);
                      subjectList.add(subject);
                      int sindex = subjectList.indexOf(subject);
                      print(subjectList.length);
                      subjectListKey.currentState.insertItem(sindex);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('$value is Saved'),
                      ));
                      subjectTextCtrl.clear();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
               width: 500,
                child: Scrollbar(
                  child: ReorderableListView(
                    scrollDirection: Axis.vertical,
                     onReorder: _onReorder,
                    children: [
                      AnimatedList(
                        shrinkWrap: true,
                        key: subjectListKey,
                        initialItemCount: subjectList.length,
                        itemBuilder: (context, index, animation) {
                          return buildItem(context, index, animation);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Spacer(),
        ],
      ),
    );
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

  dynamic pupUp() async {
    return await PopupBox.showPopupBox(
        context: context,
        button: IconButton(icon: Icon(Icons.clear),iconSize: 20,
        onPressed: (){
          Navigator.of(context).pop();
        },),
        willDisplayWidget: Container(
          height: 100,
          width: 400,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 40,
                child: TextField(
                  controller:classTextCtrl,
                  enabled: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'Class',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    hintText: 'Enter Class then press Enter',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onSubmitted: (value) {
                    if(value.isNotEmpty){
                      Class _class = Class(UniqueKey().toString(), _selectedSession.id, value) ;
                      Class.getClass.add(_class);
                      setState(() {

                      });
                    }

                    classTextCtrl.clear();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }
  var choiceAction;
  Widget classListTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: MediaQuery.of(context).size.height - 200,
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              itemCount: getClass.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      currentSelectedIndex = index;

                    });

                  },
                  onDoubleTap: (){


                  },
                  child: Container(
                    width: 160,
                    height: 65,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 16.5,
                                backgroundColor: currentSelectedIndex == index
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              CircleAvatar(
                                  radius: 15,
                                  child: Text(
                                    getClass[index].className[0],
                                  )),
                            ],
                          ),
                          Text(getClass[index].className,
                              style: TextStyle(
                                  fontSize:
                                      currentSelectedIndex == index ? 13 : 12,
                                  fontWeight: FontWeight.w700,
                                  color: currentSelectedIndex == index
                                      ? Colors.blue
                                      : Colors.black54))
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
 bool subjTileText = false;
  Widget buildItem(
      BuildContext context, int index, Animation<double> animation) {
    String initial = subjectList[index].subjectName;
    return ScaleTransition(
      scale: animation,
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            subjTileText = true;
          });
          },
        onLongPress: (){
          setState(() {
            subjTileText = true;
          });
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.cyan,
            child: Text(
              subjectList[index].subjectName[0],
              style: TextStyle(color: Colors.white),
            ),
          ),
          title:TextField(controller: TextEditingController(text:initial),enabled:subjTileText,onSubmitted: (value){
            setState(() {
              initial = value;
              subjectList[index].subjectName = value;
            });
          },
          onEditingComplete: (){
            setState(() {
              subjTileText = false;
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none
          ),),// Text(subjectList[index].subjectName),
          trailing: GestureDetector(
            child: Icon(
              Icons.delete,
              color: Colors.blueAccent,
            ),
            onTap: () {
              Subject itemToRemove = subjectList[index];
              subjectListKey.currentState.removeItem(index,
                  (context, animation) => buildItem(context, index, animation),
                  duration: Duration(milliseconds: 500));
              Future.delayed(
                  Duration(seconds: 1), () => subjectList.remove(itemToRemove));
              setState(() {});
            },
          ),

        ),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Subject item = subjectList.removeAt(oldIndex);
      subjectList.insert(newIndex, item);
    });
  }
}

class Session {
  String id;
  String year;
  Session(this.id, this.year);

  static List<Session> getSession = [
    Session('0', '2015'),
    Session('1', '2016'),
    Session('2', '2017'),
    Session('3', '2018'),
    Session('4', '2019'),
    Session('5', '2020'),
  ];
}

class Class {
  String id;
  String sessionId;
  String className;
  Class(this.id, this.sessionId, this.className);
  static List<Class> getClass = [
    Class('0', '0', 'One'),
    Class('0', '0', 'five'),
    Class('1', '0', 'Two'),
    Class('2', '1', 'One'),
    Class('3', '1', 'Two'),
    Class('4', '1', 'Three'),
    Class('5', '0', 'Three'),
    Class('0', '0', 'One'),
    Class('1', '0', 'Two'),
    Class('2', '1', 'One'),
    Class('3', '1', 'Two'),
    Class('4', '1', 'Three'),
    Class('5', '0', 'Three'),
    Class('0', '0', 'One'),
    Class('1', '0', 'Two'),
    Class('2', '1', 'One'),
    Class('3', '1', 'Two'),
    Class('4', '1', 'Three'),
    Class('5', '0', 'Three'),
    Class('1', '3', 'one'),
    Class('2', '3', 'two'),
    Class('3', '3', 'Three'),
    Class('4', '3', 'four'),
    Class('5', '3', 'five'),
  ];
}

class Subject {
  String id;
  String classId;
  String subjectName;
  Subject(this.id, this.classId, this.subjectName);
}

List<Subject> getSubject = [
  Subject('0', '0', 'Science'),
  Subject('1', '0', 'Social'),
  Subject('2', '0', 'English'),
  Subject('3', '0', 'Nepali'),
  Subject('4', '0', 'Math'),
  Subject('5', '0', 'Health'),
];
class menuButton{
  static const String Edit = 'Edit';
  static const String Delete = 'Delete';
  static const List<String> choices = <String>[
    Edit,
    Delete,
  ];
}

PopupMenuButton<String> pupUpButton(dynamic choiceAction){
  return PopupMenuButton<String>(
    onSelected: choiceAction,
    itemBuilder: (BuildContext context){
      return menuButton.choices.map((String choice){
        return PopupMenuItem<String>(
          value: choice,
          child: Text(choice),
        );
      }).toList();
    },
  );
}