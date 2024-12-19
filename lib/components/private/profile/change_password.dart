import 'package:flutter/material.dart';
import 'package:eats/shared/app_buttons.dart';
import 'package:eats/shared/bottom_nav_bar.dart';

class ChangePassword extends StatefulWidget {
  var routeName = '/changepassword';

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Change Password',
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
              'Please enter your old password and then',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const Text(
              'your new desired password.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 63),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //current password
                  TextFormField(
                    controller: currentPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textAlign: TextAlign.center,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Current Password',
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

                  //new password
                  TextFormField(
                    controller: newPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textAlign: TextAlign.center,
                    obscureText: !isNewPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'New Password',
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
                    textAlign: TextAlign.center,
                    obscureText: !isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Confirm New Password',
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
            const SizedBox(height: 40),
            CustomButton(
              label: 'Change Password',
              onTap: () {
                // Handle button press
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/profilelanding', (Route<dynamic> route) => true);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 3,
      ),
    );
  }
}
