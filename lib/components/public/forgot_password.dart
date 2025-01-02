import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:eats/shared/app_buttons.dart';

class ForgotPassword extends StatefulWidget {
  var routeName = '/forgotPassword';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController phoneNumberController = TextEditingController();

  bool isChecked = false;
  bool isPasswordVisible = false;

  bool isFingerprintClicked = false;
  bool isAuthenticationClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/logIn', (Route<dynamic> route) => true);
          },
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            children: [
              const SizedBox(height: 30),

              // Text
              const Text(
                'Forgot password',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Enter',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: ' details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 23),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              CustomButton(
                label: 'Next',
                onTap: () {
                  // Handle button press
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/resetPassword', (Route<dynamic> route) => true);
                },
              ),

              const SizedBox(height: 25),

              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'You want to login?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' Log in',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/logIn', (Route<dynamic> route) => true);
                        },
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
