
import 'package:eats/http/shared/apiService.dart';

class AuthApiService {

  ApiService apiService = ApiService();

  //login
  Future<bool> loginReq( String email, String password) async {
    try {
      print(email);
      print(password);
        var results = await apiService.login(email,password);

          print(results);

        if (results.statusCode == 200) {
          print('Login successful');
          return true;
        } else {
          print('Login failed with status: ${results.statusCode}');
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
