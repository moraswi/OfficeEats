import 'dart:convert';

import 'package:eats/http/shared/apiService.dart';

class AuthApiService {

  //login
  Future<void> loginReq( String email, String password) async {
    try {

    } catch (e) {

      print('loginReq Error: $e');
      rethrow;
    }
  }

  //registerReq
  Future<void> registerReq(String fullName, String phoneNumber, String email, String password, String role) async {
    try {

    } catch (e) {

      print('registerReq Error: $e');
      rethrow;
    }
  }

  //changePasswordReq
  Future<void> changePasswordReq(int userId, String string, String newPassword) async {
    try {

    } catch (e) {

      print('changePasswordReq Error: $e');
      rethrow;
    }
  }

  //deleteProfileReq
  Future<void> deleteProfileReq(int id) async {
    try {

    } catch (e) {

      print('deleteProfileReq Error: $e');
      rethrow;
    }
  }


}
