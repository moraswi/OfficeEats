import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:eats/shared/app_buttons.dart';

class SignUp extends StatefulWidget {
  var routeName = '/signUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isChecked = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/landingPage', (Route<dynamic> route) => true);
          },
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Create',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: ' your',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'new',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: ' account',
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
                    TextFormField(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Phone number
                    TextFormField(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
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
                    const SizedBox(height: 16),

                    // Confirm Password
                    TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
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
                              isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                            });
                          },
                          child: Icon(
                            isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.orange,
              //     // Set the background color to orange
              //     minimumSize: Size(double.infinity, 0),
              //     // Set width to 100%
              //     padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(11.0),
              //       // Set border radius
              //     ),
              //   ),
              //   onPressed: () {
              //     Navigator.of(context).pushNamedAndRemoveUntil(
              //         '/logIn', (Route<dynamic> route) => true);
              //   },
              //   child: Text(
              //     'Register',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),

              CustomButton(
                label: 'Register',
                onTap: () {
                  // Handle button press
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/logIn', (Route<dynamic> route) => true);
                },
              ),

              const SizedBox(height: 10),

              //LOGIN
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: 'Log In',
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
