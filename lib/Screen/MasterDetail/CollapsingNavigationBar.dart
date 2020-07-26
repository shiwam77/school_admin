import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Theme.dart';
import 'CollapsingListTileWidget.dart';
import 'Model/NavigationModel.dart';
import 'indexNotifier.dart';

AnimationController animationController;

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 260;
  double minWidth = 60;
  bool isCollapsed = false;
  double maxHeight = 160;
  double minHeight = 0;
  Animation<double> widthAnimation;
  Animation<double> heightAnimation;

  int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(animationController);
    heightAnimation = Tween<double>(begin: maxHeight, end: minHeight)
        .animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    String imgUrl =
        "https://www.bing.com/images/search?view=detailV2&ccid=PevlNpL4&id=C02EA35C1BCDB9383E4B4B866499F709965BC614&thid=OIP.PevlNpL4WtC43VEqkK185gHaFj&mediaurl=http%3a%2f%2fcdn.tourradar.com%2fs3%2fserp%2foriginal%2f2182_FtX8VdFq.jpg&exph=1440&expw=1920&q=image&simid=608002906011469135&ck=BDF69CC39484C627AD19F35D11B8963F&selectedIndex=0";

    return Material(
        elevation: 80.0,
        child: Consumer<NavIndex>(builder: (context, navindex, child) {
          return SafeArea(
            child: Container(
              width: widthAnimation.value,
              color: drawerBackgroundColor,
              child: Column(
                children: <Widget>[
                  (widthAnimation.value >= 190) &&
                          (heightAnimation.value >= 140)
                      ? Container(
                          height: heightAnimation.value,
                          width: widthAnimation.value,
                          color: Colors.black12,
                          child: UserAccountsDrawerHeader(
                            accountName: Text("Shiwam Karn"),
                            accountEmail: Text("shiwamkarn77@gmail.com"),
                            currentAccountPicture: CircleAvatar(
                              child: Image.network(
                                imgUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: SizedBox(
                              child: Icon(
                            Icons.person,
                            size: 20,
                          )),
                        ),
                  Container(
                    color: Colors.grey,
                    width: widthAnimation.value,
                    height: .5,
                    margin: EdgeInsets.only(bottom: 6),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, counter) {
                        return Divider(
                          height: 12.0,
                          thickness: .5,
                          //color: Colors.grey,
                        );
                      },
                      itemBuilder: (context, counter) {
                        return CollapsingListTile(
                          onTap: () {
                            setState(() {
                              currentSelectedIndex = counter;
                              navindex.changeIndex(counter);
                            });
                          },
                          isSelected: currentSelectedIndex == counter,
                          title: navigationItems[counter].title,
                          icon: navigationItems[counter].icon,
                          animationController: animationController,
                        );
                      },
                      itemCount: navigationItems.length,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                        isCollapsed
                            ? animationController.forward()
                            : animationController.reverse();
                      });
                    },
                    child: AnimatedIcon(
                      icon: AnimatedIcons.close_menu,
                      progress: animationController,
                      color: selectedColor,
                      size: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
