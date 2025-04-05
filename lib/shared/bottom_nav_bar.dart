import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  int getUserId = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    getSharedPreferenceData();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      getUserId = prefs.getInt('userId') ?? 0;
    });

  }


  @override
  Widget build(BuildContext context) {
    return TabBar(
              labelColor: inactiveIconColor,
              unselectedLabelColor: inactiveIconColor,
              labelStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400),

              indicatorColor: Colors.black54,
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.home,
                    size: 23.0,
                    color: inactiveIconColor,
                  ),
                  text: 'Town Shop',
                ),
                Tab(
                  icon: Icon(
                    Icons.info,
                    size: 23.0,
                    color: inactiveIconColor,
                  ),
                  text: 'History',
                ),
                Tab(
                  icon: Icon(
                    Icons.help,
                    size: 23.0,
                    color:inactiveIconColor,
                  ),
                  text: 'Rate App',
                ),
                Tab(
                  icon: Icon(
                    Icons.account_circle,
                    size: 23.0,
                    color:inactiveIconColor,
                  ),
                  text: 'Profile',
                ),

                if(getUserId == 0)
                  Tab(
                    icon: Icon(
                      Icons.login,
                      size: 23.0,
                      color: Colors.red,
                    ),
                    child: Text(
                      'LogIn',
                      style: TextStyle(color: Colors.red),
                    ),
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
                else if (index == 4 ) {
                  Navigator.pushNamed(context, '/logIn');
                }
              },
              controller: _tabController,
            );
  }
}
