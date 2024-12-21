import 'package:flutter/material.dart';
import 'package:eats/shared/app_buttons.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/shared/app_colors.dart';
import 'package:eats/http/authApiService.dart';

class MyProfile extends StatefulWidget {
  var routeName = '/myprofile';

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final AuthApiService authService = AuthApiService();

  bool isPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  var getAddress;
  var userData;
  String officePackText = '';
  String officeAddressText = '';

  @override
  void initState() {
    super.initState();
    getUserAddressReq();
    getUserByIdReq();
  }

  // getOrdersReq
  Future<void> getUserAddressReq() async {
    try {
      var userId = 0; // Replace with the actual user ID
      Map<String, dynamic> response =
          await authService.getUserAddressReq(userId);
      setState(() {
        getAddress = [response]; // Wrap the response in a list
        officePackText = 'Office Pack: ${getAddress[0]['officePack'] ?? 'N/A'}';
        officeAddressText = getAddress[0]['officeAddress'] ?? 'N/A';
        print('Address Details: $getAddress');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Get address failed: $e')),
      );
    }
  }

  Future<void> getUserByIdReq() async {
    try {
      var userid = 1;
      var response = await authService.getUserByIdReq(context, userid);
      // print(response);
      setState(() {
        userData = response;
        firstNameController.text = userData['firstName'];
        surnameController.text = userData['lastName'];
        emailController.text = userData['email'];
        phoneNumberController.text = userData['phoneNumber'];
        // userData
        // print(userData);
        // isLoading = false;
      });
    } catch (e) {
      // setState(() {
      // isLoading = false;
      // });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Get order failed: $e')),
      );
    }
  }

  Future<void> deleteUserAddressReq() async {
    try {
      int addressId = 2;
      await authService.deleteUserAddressReq(addressId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete address')),
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
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'My Profile',
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
              'Account Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            // const Text(
            //   'your new desired password.',
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            // ),
            const SizedBox(height: 30),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name', // Corrected property name
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: surnameController,
                    decoration: InputDecoration(
                      labelText: 'Surname', // Corrected property name
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address', // Corrected property name
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone number', // Corrected property name
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text("Add Address",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor)),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/officePackImage1.jpg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (officePackText.isNotEmpty)
                          Text(
                            officePackText,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (officeAddressText.isNotEmpty)
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: AppColors.primaryColor, size: 20),
                              Text(officeAddressText,
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        //
                        // Text('Address not found')

                        // if (officeAddressText.isNotEmpty)
                        //   Icon(Icons.location_on,
                        //       color: AppColors.primaryColor, size: 20),
                        // if (officeAddressText.isNotEmpty)
                        //   Text(officeAddressText,
                        //       style: TextStyle(fontSize: 16)),
                        if (officeAddressText.isEmpty || officePackText.isEmpty)
                          Text('Address not found'),
                      ],
                    ),
                  ),
                  if (officeAddressText.isNotEmpty)
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deleteUserAddressReq();
                      },
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            CustomButton(
              label: 'Save',
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
