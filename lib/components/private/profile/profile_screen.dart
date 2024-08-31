import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:eats/shared/app_buttons.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../shared/app_colors.dart';

class ProfileLandingPage extends StatefulWidget {
  var routeName = '/profilelanding';

  @override
  _ProfileLandingPageState createState() => _ProfileLandingPageState();
}

class _ProfileLandingPageState extends State<ProfileLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.of(context).pop();
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.shopping_cart_sharp, size: 28,),
        //     onPressed: () {
        //       Navigator.of(context).pushNamedAndRemoveUntil(
        //           '/cart', (Route<dynamic> route) => true);
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('assets/images/food3.jpeg'),
                )),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Blessing Mothapo",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
            ),
            const Text(
              "Bless@gmail.com",
              style: TextStyle( fontSize: 15),
            ),
            SizedBox(height: 20,),

            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    side: BorderSide.none,
                    shape: StadiumBorder()),
                child: Text('Edit Profile', style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 30,),
            Divider(),
            SizedBox(height: 30,),

            // Text("Profile Details", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),),
            // SizedBox(height: 20,),
            //
            // Text("Change Password", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),),
            // SizedBox(height: 20,),
            //
            // // Text("Title here", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),),
            // // SizedBox(height: 20,),
            //
            // Text("Office Address", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),),
            // // ListTile(
            //   leading: Container(
            //     width: 40,
            //     height: 40,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(100),
            //       color: AppColors.tertiaryColor
            //     ),
            //     child: Icon(LineAwesomeIcons.copy, color: AppColors.secondaryColor,),
            //   ),
            //   title: Text("Title here", style: TextStyle(fontWeight: FontWeight.w600),),
            //
            //   trailing: Container(
            //     width: 30,
            //     height: 30,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(100),
            //       color: AppColors.tertiaryColor,
            //     ),
            //     child: Icon(LineAwesomeIcons.address_book, size: 18,color: AppColors.secondaryColor,),
            //   ),
            // )
          ],
        ),
      )),
    );
  }
}
