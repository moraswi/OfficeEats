import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:eats/shared/app_buttons.dart';

class LogIn extends StatefulWidget {
  var routeName = '/logIn';

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isChecked = false;
  bool isPasswordVisible = false;

  bool isFingerprintClicked = false;
  bool isAuthenticationClicked = false;
  String message = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            children: [
              const SizedBox(height: 200),

              // Logo
              // Image.asset(
              //   'assets/logo.png',
              //   width: 160,
              //   height: 160,
              // ),
              //
              // const SizedBox(height: 10),

              // Text
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'please',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 23),

              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.emailAddress,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(8),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              CustomButton(
                label: 'Log In',
                onTap: () {
                  // Handle button press
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => true);
                },
              ),

              const SizedBox(height: 20),
              //forgot Password
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/forgotPassword', (Route<dynamic> route) => true);
                },
                child: const Text(
                  'Forgot my password',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),

              const SizedBox(height: 11),

              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Don’t have an account?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' Sign up',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/signUp', (Route<dynamic> route) => true);
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
