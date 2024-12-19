import 'package:eats/http/shared/apiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/loading_dialog.dart';

class AuthApiService {
  ApiService apiService = ApiService();

  //login
  Future<bool> loginReq(
      BuildContext context, String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email and Password are required!')),
        );
        return false;
      }

      // Show the loading dialog
      LoadingDialog.show(context);

      var results = await apiService.login(email, password);

      if (results.statusCode == 200) {
        LoadingDialog.hide(context);
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/office',
          (Route<dynamic> route) => false,
        );
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
      String role) async {
    try {
      // Validation: Ensure all fields are filled
      if (firstName.isEmpty ||
          lastName.isEmpty ||
          phoneNumber.isEmpty ||
          email.isEmpty ||
          password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('All fields are required!')),
        );
        return false; // Stay on the same page
      }

      // Validation: Check if passwords match
      // if (password != confirmPassword) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Passwords do not match!')),
      //   );
      //   return false; // Stay on the same page
      // }

      // Show the loading dialog
      LoadingDialog.show(context);

      // Call API for registration
      var results = await apiService.register(
          firstName, lastName, phoneNumber, email, password, role);

      if (results.statusCode == 201) {
        // Success
        LoadingDialog.hide(context);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully registered!')),
        );

        // Navigate to the login page
        Navigator.of(context).pushNamed('/login');
        return true;
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
      // Assuming apiService.changePassword returns a Response object
      final response =
          await apiService.changePassword(userId, currentPassword, newPassword);

      if (response.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/profilelanding', (Route<dynamic> route) => true);
        return true; // Password changed successfully
      } else {
        print('API Error: ${response.statusCode}, ${response.body}');
        return false; // Password change failed
      }
    } catch (e) {
      print('changePasswordReq Error: $e');
      throw Exception('Failed to change password');
    }
  }

  //deleteProfileReq
  Future<void> deleteProfileReq(int id) async {
    try {
      var results = await apiService.deleteProfile(id);

      if (results.statusCode == 200) {
        print('successful');
      }
    } catch (e) {
      print('deleteProfileReq Error: $e');
      rethrow;
    }
  }

  //deleteUserAddressReq
  Future<void> deleteUserAddressReq(int id) async {
    try {
      var results = await apiService.deleteUserAddress(id);

      if (results.statusCode == 200) {
        print('successful');
      }
    } catch (e) {
      print('deleteProfileReq Error: $e');
      rethrow;
    }
  }

  //deleteProfileReq
  Future<void> getUserAddressReq(int userid) async {
    try {
      var results = await apiService.getUserAddress(userid);

      if (results.statusCode == 200) {
        print('successful');
      }
    } catch (e) {
      print('deleteProfileReq Error: $e');
      rethrow;
    }
  }
}
