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

  //address
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController recipientPhoneNumberController =
      TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController suburbController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController provinceController = TextEditingController();

  final AuthApiService authService = AuthApiService();
  final StoreApiService storeService = StoreApiService();

  var getAddress;
  var getOfficePacks;
  var userData;

  String Recipient = "";
  String RecipientPhoneNumber = "";
  String RecipientAddress = "";
  int addressId = 0;
  String? addSelectedOfficePack;
  int? getUserId;
  String deliveryBottomBar = "";

  final List<String> provinces = [
    'Gauteng',
    'Limpopo',
    'Mpumalanga',
    'Kwazulu-Natal',
    'Eastern Cape',
    'Free State',
    'Western Cape',
    'Northern Cape',
    'North West'
  ];

  // The selected province
  String? selectedProvince;

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
                //Recipient Name
                TextField(
                  controller: recipientNameController,
                  decoration: InputDecoration(
                    labelText: 'Recipient Name',
                  ),
                ),

                // Recipient Phone Number
                TextField(
                  controller: recipientPhoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Recipient Phone Number',
                  ),
                ),

                // Street Address
                TextField(
                  controller: streetAddressController,
                  decoration: InputDecoration(
                    labelText: 'Street Address',
                  ),
                ),

                // Company/Building(Optional)
                TextField(
                  controller: buildingController,
                  decoration: InputDecoration(
                    labelText: 'Company/Building',
                  ),
                ),

                // Company/Building(Optional)
                TextField(
                  controller: suburbController,
                  decoration: InputDecoration(
                    labelText: 'Suburb',
                  ),
                ),
                // Company/Building(Optional)
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: 'City/Town',
                  ),
                ),

                DropdownButtonFormField<String>(
                  value: selectedProvince,
                  onChanged: (newValue) {
                    setState(() {
                      selectedProvince = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Province',
                  ),
                  items: provinces.map((province) {
                    return DropdownMenuItem<String>(
                      value: province,
                      child: Text(province),
                    );
                  }).toList(),
                ),

                //Postal Code
                TextField(
                  controller: postalCodeController,
                  decoration: InputDecoration(
                    labelText: 'Postal Code (Optional)',
                  ),
                ),
                SizedBox(height: 20),
                // DropdownButton<String>(
                //   hint: Text('Select Office Pack'),
                //   value: addSelectedOfficePack,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       addSelectedOfficePack = newValue;
                //     });
                //   },
                //   items: getOfficePacks.map<DropdownMenuItem<String>>((office) {
                //     return DropdownMenuItem<String>(
                //       value: office['officeName'],
                //       child: Text(office['officeName']),
                //     );
                //   }).toList(),
                // ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    String recipientName = recipientNameController.text;
                    String recipientPhoneNumber =
                        recipientPhoneNumberController.text;
                    String streetAddress = streetAddressController.text;
                    String building = buildingController.text;
                    String suburb = suburbController.text;
                    String city = cityController.text;
                    String province = provinceController.text;

                    // Save the address
                    if (recipientName.isNotEmpty &&
                        recipientPhoneNumber.isNotEmpty &&
                        streetAddress.isNotEmpty &&
                        building.isNotEmpty &&
                        suburb.isNotEmpty &&
                        city.isNotEmpty &&
                        selectedProvince != null) {
                      Navigator.pop(context);
                    } else {
                      // Handle validation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please fill in required fields')),
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
                // Close dialog
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

      setState(() {
        getAddress = [response];

        Recipient = getAddress[0]['recipientName'];
        RecipientPhoneNumber = getAddress[0]['recipientMobileNumber'];
        RecipientAddress = getAddress[0]['apartment'] +
            "; " +
            getAddress[0]['suburb'] +
            "; " +
            getAddress[0]['streetAddress'];
        addressId = getAddress[0]['id'] ?? 0;
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
        RecipientAddress = "";
        Recipient = "";
        RecipientPhoneNumber = "";
      });

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete address')),
      );
    }
  }

  // addAddressReq
  Future<void> addAddressReq() async {
    try {
      String recipientName = recipientNameController.text;
      String recipientPhoneNumber = recipientPhoneNumberController.text;
      String streetAddress = streetAddressController.text;
      String building = buildingController.text;
      String suburb = suburbController.text;
      String city = cityController.text;
      String postalCode = postalCodeController.text;
      String province = selectedProvince.toString();

      await authService.addAddressReq(
          context,
          getUserId!,
          recipientName,
          recipientPhoneNumber,
          streetAddress,
          building,
          suburb,
          city,
          postalCode,
          province);

      setState(() {
        getUserAddressReq();
      });

      Navigator.pop(context);
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

            deliveryBottomBar != "deliverypartner" && (RecipientAddress.isEmpty)
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
                              if (Recipient.isNotEmpty)
                                Text(
                                  Recipient,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              Text(
                                RecipientPhoneNumber,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              if (RecipientAddress.isNotEmpty)
                                Text(RecipientAddress,
                                    style: TextStyle(fontSize: 14)),

                              // Row(
                              //   children: [
                              //     const Icon(Icons.location_on,
                              //         color: AppColors.primaryColor,
                              //         size: 20),
                              //     Text(RecipientAddress,
                              //         style: TextStyle(fontSize: 16)),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        if (RecipientAddress.isNotEmpty)
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

            if (getUserId != 0)
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
