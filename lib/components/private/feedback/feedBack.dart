import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:eats/http/storeApiService.dart';
import 'package:eats/shared/app_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/bottom_nav_bar.dart';

class FeedBack extends StatefulWidget {
  var routeName = '/feedback';

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final StoreApiService storeService = StoreApiService();

  TextEditingController feedbackController = TextEditingController();

  bool overallService = false;
  bool SpeedEfficiency = false;
  bool deliveryService = false;
  bool customerSupport = false;
  bool otherChecked = false;

  String improve = "";
  double rating = 1.0;
  String result = "";
  int getUserId = 0;

  void _submitForm() {
    // Display the results of the checked checkboxes in the terminal
    if (overallService) {
      result += 'Overall service\n';
    }

    if (deliveryService) {
      result += 'Selivery Service\n';
    }

    if (SpeedEfficiency) {
      result += 'Speed and efficiency\n';
    }

    if (otherChecked) {
      result += 'Other\n';
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      getUserId = prefs.getInt('userId') ?? 0;
    });
  }

  // _feedback
  Future<void> _feedback() async {
    try {
      _submitForm();
      int rate = rating.toInt();
      String improveResult = improve;
      String message = feedbackController.text;

      if (improveResult.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Select options')),
        );
        return;
      }

      if (message.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Write a comment')),
        );
        return;
      }

      await storeService.rateAppReq(
          context, getUserId, message, rate, improveResult);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.cancel, color: Color(0Xff434344)),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        automaticallyImplyLeading: false,
        title: const Text(
          'Feedback',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),

                SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('assets/images/userprofile.png'),
                    )),
                 // Align(
                  // alignment: Alignment.center,
                  // child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //     'Please rate your experience',
                      //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      //   ),
                      // ),


                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'How was your experience?',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                            initialRating: 1,
                            minRating: 1,
                            direction: Axis.horizontal,
                            // allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, index) {
                              // Determine which picture to display based on the rating
                              if (index < rating) {
                                return Image.asset(
                                  'assets/images/feedback/starFill.png',
                                );
                              } else {
                                return Image.asset(
                                  'assets/images/feedback/starOutlined.png',
                                );
                              }
                            },
                            onRatingUpdate: (newRating) {
                              setState(() {
                                rating = newRating;
                              });
                              print(rating);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                // ),
                // const SizedBox(
                //   height: 10,
                // ),

                //Rating


                const SizedBox(
                  height: 30,
                ),
                // const Align(
                //   alignment: Alignment.topLeft,
                //   child: Text(
                //     'How can we improve?',
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),


                TextField(
                  controller: feedbackController,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8))),
                      hintText: "Tell us about your experience..."
                    // contentPadding: EdgeInsets.symmetric(vertical: 70.0),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                CustomButton(
                  label: 'Submit',
                  onTap: () {
                    _feedback();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 2,
      ),
    );
  }
}
