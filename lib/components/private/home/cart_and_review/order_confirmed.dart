import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:eats/shared/app_buttons.dart';

class OrderConfirmed extends StatefulWidget {
  var routeName = '/orderconfirmed';

  @override
  State<OrderConfirmed> createState() => _OrderConfirmedState();
}

class _OrderConfirmedState extends State<OrderConfirmed> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.cancel, color: Color(0Xff434344)),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => true);
          },
        ),
        title: const Text(
          'Order Submitted',
          style: TextStyle(
            color: Colors.black,
            fontSize: 29,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 90,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(14, 15, 14, 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFEFF0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/feedback/solar_like-bold.png',
                        width: 122,
                        height: 122,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        'Thank you',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      const Text(
                        'Your order has been submitted!',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      //button
                      CustomButton(
                        label: 'Track Order',
                        onTap: () {
                          // Handle button press
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/history', (Route<dynamic> route) => true);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
