import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:eats/shared/app_buttons.dart';
import 'package:eats/http/authApiService.dart';

class SignUp extends StatefulWidget {
  var routeName = '/signUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final AuthApiService authService = AuthApiService();

  bool isChecked = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  // register
  Future<void> register() async {
    String firstName = firstNameController.text;
    String lastName = surnameController.text;
    String email = emailController.text;
    String phoneNumber = phoneNumberController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String role = "customer";

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required!')),
      );
    } else if (phoneNumber.length < 10 || phoneNumber.length > 15) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid Phone number')),
      );
    }else if (!RegExp(r'^\d{10,15}$').hasMatch(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number must contain only digits!')),
      );
    }else if (!RegExp(r'^\d{10,}$').hasMatch(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number must contain only digits!')),
      );
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address!')),
      );
    }else if (password.length < 5 || password.length > 20) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be between 5 and 20 characters!')),
      );
    }  else if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!')),
      );
    } else {
      await authService.registerReq(context, firstName, lastName, phoneNumber,
          email, password, role, confirmPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Registration',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const Text(
                'Personal Details',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 23),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.all(8),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: surnameController,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.all(8),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email/Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.all(8),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Phone number
                    TextFormField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.all(8),
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
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
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
                  ],
                ),
              ),

              const SizedBox(height: 20),

              CustomButton(label: 'Register', onTap: register),

              const SizedBox(height: 15),

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
                        color: Colors.red,
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
