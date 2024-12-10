import 'package:shared_preferences/shared_preferences.dart';

import 'httpService.dart';
import 'dart:io';

class apiService {
  HttpService httpService = HttpService();

  //login
  Future<dynamic> login(String email, String password) async {
    final endpoint = 'login';
    final data = {'email': email, 'password': password};
    return await httpService.post(endpoint, data);
  }

  //register
  Future<dynamic> register(String fullName, String phoneNumber, String email, String password, String role) async {
    final endpoint = 'register';
    final data = {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'role': role
    };
    return await httpService.post(endpoint, data);
  }

  //changePassword
  Future<dynamic> changePassword(int userId, String string, String newPassword) async {
    final endpoint = 'register';
    final data = {
      'userId': userId,
      'string': string,
      'newPassword': newPassword,
    };
    return await httpService.post(endpoint, data);
  }

  //deleteProfile
  Future<dynamic> deleteProfile(int id) async {
    final endpoint = 'register/$id';
    return await httpService.delete(endpoint);
  }

  //getOffices
  Future<dynamic> getOffices() async {
    final endpoint = 'offices';
    return await httpService.get(endpoint);
  }

  //getStores
  Future<dynamic> getStores(int officeId) async {
    final endpoint = 'shop/$officeId';
    return await httpService.get(endpoint);
  }


  //getStoreMenuByCategoryId
  Future<dynamic> getStoreMenuByCategoryId(int categoryId) async {
    final endpoint = 'store-menu/category/$categoryId';
    return await httpService.get(endpoint);
  }

  //getStoreMenuPromotionMeals
  Future<dynamic> getStoreMenuPromotionMeals(int storeId) async {
    final endpoint = '/store-menu/promotion-meals/$storeId';
    return await httpService.get(endpoint);
  }

  //getStoreMenuTopMeal
  Future<dynamic> getStoreMenuTopMeals(int storeId) async {
    final endpoint = 'store-menu/top-meals/$storeId';
    return await httpService.get(endpoint);
  }

  //getStoreMenuCategories
  Future<dynamic> getStoreMenuCategories(int storeId) async {
    final endpoint = 'menu-category/$storeId';
    return await httpService.get(endpoint);
  }

  //getStoreMenuCategories
  Future<dynamic> getUserAddress(int userid) async {
    final endpoint = 'addresses/$userid';
    return await httpService.get(endpoint);
  }

  //getStoreMenuCategories
  Future<dynamic> getOrders(int userid) async {
    final endpoint = 'order/user/$userid';
    return await httpService.get(endpoint);
  }
}
