import 'package:flutter/material.dart';

import '../../shared/app_buttons.dart';

class ResetPassword extends StatefulWidget {
  var routeName = '/resetPassword';

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

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
                '/forgotPassword', (Route<dynamic> route) => true);
          },
        ),
        title: const Text(
          'Reset Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 29,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            children: [
              const Text(
                'Please enter and confirm',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const Text(
                'your new desired password.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 40),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //new password
                    TextFormField(
                      controller: newPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isNewPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.all(8),

                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isNewPasswordVisible = !isNewPasswordVisible;
                            });
                          },
                          child: Icon(
                            isNewPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    //new password
                    TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Confirm New Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
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

                    const SizedBox(height: 25),

                    CustomButton(
                      label: 'Submit',
                      onTap: () {
                        // Handle button press
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/logIn', (Route<dynamic> route) => true);
                      },
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          )),
    );
  }
}
