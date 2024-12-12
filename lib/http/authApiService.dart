
import 'package:eats/http/shared/apiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/loading_dialog.dart';

class AuthApiService {

  ApiService apiService = ApiService();

  //login
  Future<bool> loginReq(BuildContext context, String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email and Password are required!')),
        );
        return false;
      }

      // Show the loading dialog
      LoadingDialog.show(context);
        var results = await apiService.login(email,password);

        if (results.statusCode == 200) {

          // hide loading dialog
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
    }
  }

  //registerReq
  Future<void> registerReq(String fullName, String phoneNumber, String email, String password, String role) async {
    try {
      var results = await apiService.register(fullName, phoneNumber, email, password, role);

      print(results);
      if(results.statusCode == 200){
        print('successful');
      }
    } catch (e) {

      print('registerReq Error: $e');
      rethrow;
    }
  }

  //changePasswordReq
  Future<void> changePasswordReq(int userId, String string, String newPassword) async {
    try {
      var results = await apiService.changePassword( userId, string, newPassword);

      if(results.statusCode == 200){
        print('successful');
      }
    } catch (e) {

      print('changePasswordReq Error: $e');
      rethrow;
    }
  }

  //deleteProfileReq
  Future<void> deleteProfileReq(int id) async {
    try {
      var results = await apiService.deleteProfile(id);

      if(results.statusCode == 200){
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

      if(results.statusCode == 200){
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

      if(results.statusCode == 200){
        print('successful');
      }
    } catch (e) {

      print('deleteProfileReq Error: $e');
      rethrow;
    }
  }

}
