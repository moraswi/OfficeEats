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

  // @override
  void initState() {
    super.initState();

    // Set length based on the number of tabs you will show.
    int tabCount = getUserId != 0 ? 4 : 4; // Or modify this logic based on your condition

    _tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
  }



  // @override
  // void initState() {
  //   super.initState();
  //
  //   // Calculate the number of tabs dynamically based on your conditions
  //   int tabCount = 3; // Start with 3 common tabs (Rate App, Profile/Login, etc.)
  //
  //   if (getUserId != 0) {
  //     tabCount++; // Add the Profile tab if user is logged in
  //   } else {
  //     tabCount++; // Add the LogIn tab if user is not logged in
  //   }
  //
  //   _tabController = TabController(
  //     length: tabCount,
  //     vsync: this,
  //     initialIndex: widget.selectedIndex,
  //   );
  // }

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
                print('getUserId');
                print(getUserId);
                if (index == 0) {
                  Navigator.pushNamed(context, '/townshop');
                } else if (index == 1) {
                  Navigator.pushNamed(context, '/history');
                } else if (index == 2) {
                  Navigator.pushNamed(context, '/feedback');
                } else if (index == 3 ) {
                  // && getUserId != 0
                  Navigator.pushNamed(context, '/profilelanding');
                }
                else if (index == 4  && getUserId == 0) {
                  Navigator.pushNamed(context, '/logIn');
                }
              },
              controller: _tabController,
            );
  }
}
