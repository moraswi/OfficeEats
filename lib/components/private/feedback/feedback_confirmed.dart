import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:eats/shared/app_buttons.dart';

class FeedBackConfirmed extends StatefulWidget {
  var routeName = '/feedbackconfirmed';

  @override
  State<FeedBackConfirmed> createState() => _FeedBackConfirmedState();
}

class _FeedBackConfirmedState extends State<FeedBackConfirmed> {
  bool overallService = false;
  bool SpeedEfficiency = false;
  bool customerSupport = false;
  bool otherChecked = false;

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
          'Feedback',
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
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/feedback/solar_like-bold.png',
                        width: 122,
                        height: 122,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Text(
                        'Thank you',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Text(
                        'Your feedback is appreciated!',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      //button
                      CustomButton(
                        label: 'Ok',
                        onTap: () {
                          // Handle button press
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/feedback', (Route<dynamic> route) => true);
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
