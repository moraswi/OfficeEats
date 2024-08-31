import 'package:flutter/material.dart';

import '../../../shared/app_colors.dart';
import '../../../shared/bottom_nav_bar.dart';

class TrackOrderPage extends StatefulWidget {
  var routeName = '/trackorder';

  @override
  _TrackOrderPageState createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
      ),
      body: SingleChildScrollView(
      child:Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                // Aligns the text widget to the left of its parent
                child: Text(
                  'Address',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                //alignment: Alignment.,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unit 54, Mogale Tech',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                // Aligns the text widget to the left of its parent
                child: Text(
                  'User Detail',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                //alignment: Alignment.,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mpho Molepo',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '078 321 1232',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                // Aligns the text widget to the left of its parent
                child: Text(
                  'Payment',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                //alignment: Alignment.,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Method: Card',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Total: R200.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Order: WAODAO23Q',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                // Aligns the text widget to the left of its parent
                child: Text(
                  'Order Status',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                //alignment: Alignment.,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Submitted',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Collected',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Received',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
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
