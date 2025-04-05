import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:eats/shared/app_buttons.dart';
import 'package:eats/http/authApiService.dart';

class LogIn extends StatefulWidget {
  var routeName = '/logIn';

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthApiService authService = AuthApiService();

  bool isChecked = false;
  bool isPasswordVisible = false;

  bool isFingerprintClicked = false;
  bool isAuthenticationClicked = false;
  String message = '';

  @override
  void initState() {
    super.initState();
  }

  // handleLogin
  Future<void> handleLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text;

    try {
      await authService.loginReq(context, email, password);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              const SizedBox(height: 70),

              // Logo
              // Image.asset(
              //   'assets/logo.png',
              //   width: 160,
              //   height: 160,
              // ),
              //
              // const SizedBox(height: 10),

              // Text
              // const Text(
              //   'Welcome',
              //   style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
              // ),
              // RichText(
              //   text: const TextSpan(
              //     children: [
              //       TextSpan(
              //         text: 'please',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 32,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       TextSpan(
              //         text: ' login',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 32,
              //           fontWeight: FontWeight.w700,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/motorbike2.png',
                  height: 150,
                ),
              ),
              const SizedBox(height: 50),

              Text(
                'Authorization',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),

              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Please log in to place an order. If you'd like to browse our menu, click",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' here to view our stores.',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/townshop', (Route<dynamic> route) => true);
                        },
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 30),

              TextFormField(
                controller: emailController,
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

              const SizedBox(height: 13),

              TextFormField(
                controller: passwordController,
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

              const SizedBox(height: 30),

              CustomButton(label: 'Log In', onTap: handleLogin),

              const SizedBox(height: 20),
              //forgot Password
              // InkWell(
              //   onTap: () {
              //     Navigator.of(context).pushNamedAndRemoveUntil(
              //         '/forgotPassword', (Route<dynamic> route) => true);
              //   },
              //   child: const Text(
              //     'Forgot my password',
              //     style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              //   ),
              // ),
              //
              // const SizedBox(height: 11),


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
                      text: ' Register',
                      style: const TextStyle(
                        color: Colors.red,
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
