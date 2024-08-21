import 'package:flutter/material.dart';

import '../core/utilils/app_colors.dart';

class RoundedBottomBar extends StatefulWidget {
  RoundedBottomBar({Key? key, required this.selectedIndex}) : super(key: key);
  final int selectedIndex;

  @override
  _RoundedBottomBarState createState() => _RoundedBottomBarState();
}

class _RoundedBottomBarState extends State<RoundedBottomBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Color activeIconColor = AppColors.primaryColor; // Set your desired active icon color here
  Color inactiveIconColor =
      Colors.grey; // Set your desired inactive icon color here

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(16.0),
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 10.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(4.0, 4.0),
              ),
            ],
            borderRadius: BorderRadius.circular(83),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            child: Container(
              color: Colors.white,
              height: 67,
              child: TabBar(
                labelColor: activeIconColor,
                // Set the active icon color
                unselectedLabelColor: inactiveIconColor,
                // Set the inactive icon color
                labelStyle:
                TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                  insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                ),
                indicatorColor: Colors.black54,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.home,
                      size: 23.0,
                      color: widget.selectedIndex == 0
                          ? activeIconColor
                          : inactiveIconColor,
                    ),
                    text: 'Office',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.info,
                      size: 23.0,
                      color: widget.selectedIndex == 1
                          ? activeIconColor
                          : inactiveIconColor,
                    ),
                    text: 'Order',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.help,
                      size: 23.0,
                    ),
                    text: 'Help',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.account_circle,
                      size: 23.0,
                      color: widget.selectedIndex == 2
                          ? activeIconColor
                          : inactiveIconColor,
                    ),
                    text: 'Profile',
                  ),

                ],
                onTap: (index) {
                  setState(() {
                    _tabController.index =
                        index; // Update the selected tab index
                  });

                  if (index == 0) {
                    Navigator.pushNamed(context, '/home');
                  } else if (index == 1) {
                    Navigator.pushNamed(context, '/cattlelist');
                  }
                  // else if (index == 2) {
                  //   Navigator.pushNamed(context, '/help');
                  //}
                  else if (index == 2) {
                    Navigator.pushNamed(context, '/familylisttree');
                  } else if (index == 3) {
                    Navigator.pushNamed(context, '/logIn');
                  }
                },
                controller: _tabController,
              ),
            ),
          ),
        ));
  }
}
