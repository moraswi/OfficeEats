import 'package:flutter/material.dart';

import 'app_colors.dart';

class RoundedBottomBar extends StatefulWidget {
  RoundedBottomBar({Key? key, required this.selectedIndex}) : super(key: key);
  final int selectedIndex;

  @override
  _RoundedBottomBarState createState() => _RoundedBottomBarState();
}

class _RoundedBottomBarState extends State<RoundedBottomBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Color activeIconColor = AppColors.primaryColor;
  Color inactiveIconColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              unselectedLabelColor: inactiveIconColor,
              labelStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400),
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
                    color: _tabController.index == 0
                        ? activeIconColor
                        : inactiveIconColor,
                  ),
                  text: 'Town Shop',
                ),
                Tab(
                  icon: Icon(
                    Icons.info,
                    size: 23.0,
                    color: _tabController.index == 1
                        ? activeIconColor
                        : inactiveIconColor,
                  ),
                  text: 'History',
                ),
                Tab(
                  icon: Icon(
                    Icons.help,
                    size: 23.0,
                    color: _tabController.index == 2
                        ? activeIconColor
                        : inactiveIconColor,
                  ),
                  text: 'Rate App',
                ),
                Tab(
                  icon: Icon(
                    Icons.account_circle,
                    size: 23.0,
                    color: _tabController.index == 3
                        ? activeIconColor
                        : inactiveIconColor,
                  ),
                  text: 'Profile',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _tabController.index = index; // Update the selected tab index
                });

                if (index == 0) {
                  Navigator.pushNamed(context, '/townshop');
                } else if (index == 1) {
                  Navigator.pushNamed(context, '/history');
                } else if (index == 2) {
                  Navigator.pushNamed(context, '/feedback');
                } else if (index == 3) {
                  Navigator.pushNamed(context, '/profilelanding');
                }
              },
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
