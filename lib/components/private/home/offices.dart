import 'package:flutter/material.dart';

import '../../../core/utilils/app_colors.dart';
import '../../../shared/bottom_nav_bar.dart';

class OfficePage extends StatefulWidget {
  var routeName = '/office';

  @override
  _OfficePageState createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offices parks'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  //alignment: Alignment.,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                // Aligns the text widget to the left of its parent
                                child: Text(
                                  'Office Eats',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  // Aligns the text widget to the left of its parent
                                  child: Text(
                                    'enjoy effortless, delicious meals delivered right to your office door.',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  )),
                            ],
                          )),
                          Image.asset(
                            'assets/images/image1.webp',
                            width: 160,
                            height: 160,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 1,
      ),
    );
  }
}
