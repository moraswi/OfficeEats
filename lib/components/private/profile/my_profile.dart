import 'package:flutter/material.dart';
import 'package:eats/shared/app_buttons.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/shared/app_colors.dart';
import 'package:eats/http/authApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eats/http/storeApiService.dart';
import 'package:eats/shared/delivery_bottom_navbar.dart';

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
  TextEditingController officeAddressController = TextEditingController();

  final AuthApiService authService = AuthApiService();
  final StoreApiService storeService = StoreApiService();

  bool isPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  var getAddress;
  var getOfficePacks;
  var userData;
  String officePackText = '';
  String officeAddressText = '';
  int addressId = 0;
  String? addSelectedOfficePack;
  int? getUserId;
  String deliveryBottomBar = "";

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
    getOffices();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      getUserId = prefs.getInt('userId') ?? 0;
      deliveryBottomBar = prefs.getString('role') ?? "";
    });

    getUserAddressReq();
    getUserByIdReq();
  }

  // Show Add Address Dialog
  void _showAddAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Address'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: officeAddressController,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: 'e.g Company name, Unit 8, 1st Floor'),
                ),
                SizedBox(height: 20),
                DropdownButton<String>(
                  hint: Text('Select Office Pack'),
                  value: addSelectedOfficePack,
                  onChanged: (String? newValue) {
                    setState(() {
                      addSelectedOfficePack = newValue;
                    });
                  },
                  items: getOfficePacks.map<DropdownMenuItem<String>>((office) {
                    return DropdownMenuItem<String>(
                      value: office['officeName'],
                      child: Text(office['officeName']),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    // Save the address
                    if (officeAddressController.text.isNotEmpty &&
                        addSelectedOfficePack != null) {
                      Navigator.pop(context);
                    } else {
                      // Handle validation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields')),
                      );
                    }

                    addAddressReq();
                  },
                  child: Text(
                    'Save Address',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // _showDeleteAccountDialog
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Profile'),
          content: Text(
              'Are you sure you want to delete your profile? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context); // Close dialog
                deleteProfileReq(); // Call the delete function
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // getUserAddressReq
  Future<void> getUserAddressReq() async {
    try {
      Map<String, dynamic> response =
          await authService.getUserAddressReq(getUserId!);

      print(response);
      print(response);
      setState(() {
        getAddress = [response]; // Wrap the response in a list
        officePackText = 'Office: ${getAddress[0]['officePack'] ?? 'N/A'}';
        officeAddressText = getAddress[0]['officeAddress'] ?? 'N/A';
        addressId = getAddress[0]['id'] ?? 0;
        print('Address Details: $getAddress');
      });
    } catch (e) {
      print(getAddress);
    }
  }

  // getUserByIdReq
  Future<void> getUserByIdReq() async {
    try {
      var response = await authService.getUserByIdReq(context, getUserId);
      setState(() {
        userData = response;
        firstNameController.text = userData['firstName'];
        surnameController.text = userData['lastName'];
        emailController.text = userData['email'];
        phoneNumberController.text = userData['phoneNumber'];
      });
    } catch (e) {
      print('Get order failed: $e');
    }
  }

  // deleteUserAddressReq
  Future<void> deleteUserAddressReq() async {
    try {
      await authService.deleteUserAddressReq(context, addressId);

      setState(() {
        officePackText = '';
        officeAddressText = '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete address')),
      );
    }
  }

  // addAddressReq
  Future<void> addAddressReq() async {
    try {
      String? officePack = addSelectedOfficePack;
      String officeAddress = officeAddressController.text;

      await authService.addAddressReq(
          context, officePack, officeAddress, getUserId!);

      setState(() {
        getUserAddressReq();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add address')),
      );
    }
  }

  // getOffices
  Future<void> getOffices() async {
    try {
      List<dynamic> response = await storeService.getOfficesReq();
      setState(() {
        getOfficePacks = response;
      });
    } catch (e) {
      print("failed");
    }
  }

  // deleteProfileReq
  Future<void> deleteProfileReq() async {
    try {
      await authService.deleteProfileReq(getUserId!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  Future<void> updateProfileReq() async {
    String firstName = firstNameController.text;
    String lastName = surnameController.text;
    String phoneNumber = phoneNumberController.text;
    String email = emailController.text;
    String role = deliveryBottomBar;

    try {
      if (firstName.isEmpty ||
          lastName.isEmpty ||
          phoneNumber.isEmpty ||
          email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('empty field not required')),
        );
        return;
      }

      // Call the password change service
      bool isSuccess = await authService.updateProfileReq(
          context, getUserId!, firstName, lastName, phoneNumber, email, role);

      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
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
            // Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/profilelanding', (Route<dynamic> route) => true);
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
            const SizedBox(height: 30),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // First Name
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Surname
                  TextFormField(
                    controller: surnameController,
                    decoration: InputDecoration(
                      labelText: 'Surname',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Email Address
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Phone number
                  TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            deliveryBottomBar != "deliverypartner" &&
                    (officeAddressText.isEmpty || officePackText.isEmpty)
                ? InkWell(
                    onTap: _showAddAddressDialog,
                    child: const Text(
                      "Add Address",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                : Container(),

            const SizedBox(height: 20),

            deliveryBottomBar != "deliverypartner"
                ? Container(
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
                          'assets/images/officepack.png',
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
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (officeAddressText.isNotEmpty)
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: AppColors.primaryColor,
                                        size: 20),
                                    Text(officeAddressText,
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              if (officeAddressText.isEmpty ||
                                  officePackText.isEmpty)
                                Text('Add your office address'),
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
                  )
                : Container(),

            const SizedBox(height: 15),
            InkWell(
              onTap: _showDeleteAccountDialog,
              child: const Text(
                "Delete My Account",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 15),

            deliveryBottomBar != "deliverypartner"
                ? CustomButton(
                    label: 'Save',
                    onTap: () {
                      updateProfileReq();
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     '/profilelanding', (Route<dynamic> route) => true);
                    },
                  )
                : Container(),
            // Add button to show dialog
          ],
        ),
      ),
      bottomNavigationBar: deliveryBottomBar == "deliverypartner"
          ? RoundedDeliveryBottomBar(
              selectedIndex: 2,
            )
          : RoundedBottomBar(
              selectedIndex: 3,
            ),
    );
  }
}
