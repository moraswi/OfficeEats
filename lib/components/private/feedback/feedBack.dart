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
        leading: IconButton(
          icon: const Icon(Icons.cancel, color: Color(0Xff434344)),
          onPressed: () {
            Navigator.of(context).pop();
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
          padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Please rate your experience',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'How satisfied are you with our app?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //Rating
                Row(
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

                const SizedBox(
                  height: 40,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'How can we improve?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                      // Too expensive
                      Row(
                        children: <Widget>[
                          Transform.scale(
                            scale: 1.1,
                            // Increase the size by adjusting the scale factor
                            child: Checkbox(
                              value: overallService,
                              onChanged: (bool? value) {
                                setState(() {
                                  overallService = value!;
                                  if (overallService) {
                                    improve = "Overall service";
                                    print('Checked: $improve');
                                  }
                                });
                              },
                              activeColor: Colors.red,
                            ),
                          ),
                          const Text(
                            'Overall service',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xFF434344)),
                          ),
                        ],
                      ),

                      //Switching to another insurer
                      Row(
                        children: <Widget>[
                          Transform.scale(
                            scale: 1.1,
                            // Increase the size by adjusting the scale factor
                            child: Checkbox(
                              value: deliveryService,
                              onChanged: (bool? value) {
                                setState(() {
                                  deliveryService = value!;
                                  if (deliveryService) {
                                    improve = "Delivery Service";
                                    print('Checked: $improve');
                                  }
                                });
                              },
                              activeColor: Colors.red,
                            ),
                          ),
                          const Text(
                            'Delivery Service',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xFF434344)),
                          ),
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Transform.scale(
                            scale: 1.1,
                            // Increase the size by adjusting the scale factor
                            child: Checkbox(
                              value: SpeedEfficiency,
                              onChanged: (bool? value) {
                                setState(() {
                                  SpeedEfficiency = value!;
                                  if (SpeedEfficiency) {
                                    improve = "Speed and efficiency";
                                    print('Checked: $improve');
                                  }
                                });
                              },
                              activeColor: Colors.red,
                            ),
                          ),
                          const Text(
                            'Speed and efficiency',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xFF434344)),
                          ),
                        ],
                      ),

                      //Don’t need cover anymore
                      // Row(
                      //   children: <Widget>[
                      //     Transform.scale(
                      //       scale: 1.1,
                      //       // Increase the size by adjusting the scale factor
                      //       child: Checkbox(
                      //         value: customerSupport,
                      //         onChanged: (bool? value) {
                      //           setState(() {
                      //             customerSupport = value!;
                      //             if (customerSupport) {
                      //               improve = "Customer support";
                      //               print('Checked: $improve');
                      //             }
                      //           });
                      //         },
                      //         activeColor: Colors.red,
                      //       ),
                      //     ),
                      //     const Text(
                      //       'Customer support',
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.w400,
                      //           fontSize: 16,
                      //           color: Color(0xFF434344)),
                      //     ),
                      //   ],
                      // ),

                      // Other reason
                      Row(
                        children: <Widget>[
                          Transform.scale(
                            scale: 1.1,
                            // Increase the size by adjusting the scale factor
                            child: Checkbox(
                              value: otherChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  otherChecked = value!;
                                  if (otherChecked) {
                                    improve = "Other";
                                    print('Checked:  $improve');
                                  }
                                });
                              },
                              activeColor: Colors.red,
                            ),
                          ),
                          const Text(
                            'Other',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xFF434344)),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: feedbackController,
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            hintText: "Tell us about your experience..."
                            // contentPadding: EdgeInsets.symmetric(vertical: 70.0),
                            ),
                      )
                    ],
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
