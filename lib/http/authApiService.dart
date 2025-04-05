import 'dart:convert';

import 'package:eats/http/shared/apiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/loading_dialog.dart';

class AuthApiService {
  ApiService apiService = ApiService();

  //login
  Future<bool> loginReq(
      BuildContext context, String email, String password) async {
    try {
      // Show the loading dialog
      LoadingDialog.show(context);

      var results = await apiService.login(email, password);

      if (results.statusCode == 200) {
        var userData = jsonDecode(results.body);

        final prefs = await SharedPreferences.getInstance();

        prefs.setInt('userId', userData['id']);
        prefs.setString('firstName', userData['firstName']);
        prefs.setString('lastName', userData['lastName']);
        prefs.setString('phoneNumber', userData['phoneNumber']);
        prefs.setString('email', userData['email']);
        prefs.setString('role', userData['role']);
        prefs.setInt('deliveryPartnerOfficeId', userData['officeId'] ?? 0);

        // LoadingDialog.hide(context);

        if (userData['role'] == "customer") {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/townshop',
            (Route<dynamic> route) => false,
          );
        } else if (userData['role'] == "deliverypartner") {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/deliveryorder',
            (Route<dynamic> route) => false,
          );
        }
        // else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Ask service provider to give you a role')),
        //   );
        // }
        return true;
      } else {
        // Show a failure message if login is not successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password')),
        );
        return false;
      }
    } catch (e) {
      print('loginReq Error: $e');
      rethrow;
    } finally {
      LoadingDialog.hide(context);
    }
  }

  Future<bool> registerReq(
      BuildContext context,
      String firstName,
      String lastName,
      String phoneNumber,
      String email,
      String password,
      String role,
      String confirmPassword) async {
    try {
      // Validation: Ensure all fields are filled

      // Show the loading dialog
      LoadingDialog.show(context);

      // Call API for registration
      var results = await apiService.register(
          firstName, lastName, phoneNumber, email, password, role);

      var data = json.decode(results.body);
      var message = data['message'];

      if (results.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/logIn',
              (Route<dynamic> route) => false,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully registered!')),
        );
        LoadingDialog.hide(context);

        return true;
      } else if (results.statusCode == 400) {
        // Failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        return false; // Stay on the same page
      } else {
        // Failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed! Try again.')),
        );
        return false; // Stay on the same page
      }
    } catch (e) {
      print('registerReq Error: $e');
      rethrow;
    } finally {
      // Ensure the loading dialog is hidden in all cases
      LoadingDialog.hide(context);
    }
  }

  //changePasswordReq
  Future<bool> changePasswordReq(BuildContext context, int userId,
      String currentPassword, String newPassword) async {
    try {
      LoadingDialog.show(context);

      final response =
          await apiService.changePassword(userId, currentPassword, newPassword);

      if (response.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/profilelanding', (Route<dynamic> route) => true);
        return true;
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/profilelanding', (Route<dynamic> route) => true);
        print('API Error: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      throw Exception('Failed to change password');
    } finally {
      // LoadingDialog.hide(context);
    }
  }

  // updateProfileReq
  Future<bool> updateProfileReq(BuildContext context, int id, String firstName,
      String lastName, String phoneNumber, String email, String role) async {
    try {
      LoadingDialog.show(context);

      final response = await apiService.updateProfile(
          id, firstName, lastName, phoneNumber, email, role);

      if (response.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/profilelanding', (Route<dynamic> route) => true);
        return true;
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/profilelanding', (Route<dynamic> route) => true);
        return false;
      }
    } catch (e) {
      throw Exception('Failed to change password');
    } finally {
      // LoadingDialog.hide(context);
    }
  }

  //deleteProfileReq
  Future<void> deleteProfileReq(int id) async {
    try {
      var results = await apiService.deleteProfile(id);

      if (results.statusCode == 200) {
        print('Successful');
      }
    } catch (e) {
      print('deleteProfileReq Error: $e');
      rethrow;
    }
  }

  //deleteUserAddressReq
  Future<void> deleteUserAddressReq(BuildContext context, int id) async {
    try {
      LoadingDialog.show(context);

      var results = await apiService.deleteUserAddress(id);

      if (results.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successful')),
        );

        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     '/office', (Route<dynamic> route) => false);
      }
    } catch (e) {
      print('Something went wrong');
      rethrow;
    } finally {
      LoadingDialog.hide(context);
    }
  }

  // addAddressReq
  Future<void> addAddressReq(
      BuildContext context,
      int userId,
      String recipientName,
      String recipientPhoneNumber,
      String streetAddress,
      String building,
      String suburb,
      String city,
      String postalCode,
      String province) async {
    try {
      LoadingDialog.show(context);

      var results = await apiService.addAddress(
          userId,
          recipientName,
          recipientPhoneNumber,
          streetAddress,
          building,
          suburb,
          city,
          postalCode,
          province);

      if (results.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successful')),
        );
      }
    } catch (e) {
      print('Something went wrong $e');
      rethrow;
    } finally {
      LoadingDialog.hide(context);
    }
  }

  //deleteProfileReq
  Future<Map<String, dynamic>> getUserAddressReq(int userId) async {
    try {
      final results = await apiService.getUserAddress(userId);

      if (results.statusCode == 200) {
        return jsonDecode(results.body);
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      print('Error in getUserAddressReq: $e');
      rethrow;
    }
  }

  // getUserByIdReq
  Future<dynamic> getUserByIdReq(BuildContext context, userid) async {
    try {
      // LoadingDialog.hide(context);

      var results = await apiService.getUserById(userid);

      if (results.statusCode == 200) {
        final data = jsonDecode(results.body);
        return data;
      } else {
        throw Exception("failed to get user");
      }
    } catch (e) {
      print('getUserByIdReq Error: $e');
      rethrow;
    } finally {
      // Ensure the loading dialog is hidden in all cases
      // LoadingDialog.hide(context);
    }
  }
}
