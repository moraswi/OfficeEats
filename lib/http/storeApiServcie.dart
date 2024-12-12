import 'dart:convert';

import 'package:eats/http/shared/apiService.dart';

class storeApiServcie {
  Apiservice apiService = Apiservice();

  //getOfficesReq
  Future<void> getOfficesReq() async {
    try {
      var results = await apiService.getOffices();

      if(results.statusCode == 200){
        print('successful');
      }
    } catch (e) {

      print('getOfficesReq Error: $e');
      rethrow;
    }
  }

  //getOfficesReq
  Future<void> getStoresReq(int officeId) async {
    try {
      var results = await apiService.getStores(officeId);

      if(results.statusCode == 200){
        print('successful');
      }
    } catch (e) {

      print('getStoresReq Error: $e');
      rethrow;
    }
  }

  //getOfficesReq
  Future<void> getStoreMenuByCategoryIdReq(int officeId) async {
    try {
      var results = await apiService.getStoreMenuByCategoryId(officeId);

      if(results.statusCode == 200){
        print('successful');
      }
    } catch (e) {

      print('getStoreMenuByCategoryIdReq Error: $e');
      rethrow;
    }
  }

  //getStoreMenuPromotionMealsReq
  Future<void> getStoreMenuPromotionMealsReq(int storeId) async {
    try {
      var results = await apiService.getStoreMenuPromotionMeals(storeId);

      if(results.statusCode == 200){
        print('successful');
      }
    } catch (e) {

      print('getStoreMenuPromotionMealsReq Error: $e');
      rethrow;
    }
  }

  //getStoreMenuTopMealsReq
  Future<void> getStoreMenuTopMealsReq(int storeId) async {
    try {
      var results = await apiService.getStoreMenuTopMeals(storeId);

      if(results.statusCode == 200){
        print('successful');
      }
    } catch (e) {

      print('getStoreMenuTopMealsReq Error: $e');
      rethrow;
    }
  }

  //getStoreMenuTopMealsReq
  Future<void> getStoreMenuCategoriesReq(int storeId) async {
    try {
      var results = await apiService.getStoreMenuCategories(storeId);

      if(results.statusCode == 200){
        print('successful');
      }
    } catch (e) {

      print('getStoreMenuTopMealsReq Error: $e');
      rethrow;
    }
  }

  //getOrdersReq
  Future<void> getOrdersReq(int userid) async {
    try {
      var results = await apiService.getOrders(userid);

      if(results.statusCode == 200){
        print('successful');
      }
    } catch (e) {

      print('getOrdersReq Error: $e');
      rethrow;
    }
  }

  //placeOrderReq
  Future<void> placeOrderReq(
      int userId,
      int foodId,
      int quantity,
      double itemPrice,
      String deliveryAddress,
      String paymentMethod,
      int shopId) async {
    try {
      var results = await apiService.placeOrder(
          userId,
           foodId,
           quantity,
           itemPrice,
           deliveryAddress,
           paymentMethod,
           shopId);

      if(results.statusCode == 200){
        print('successful');
      }
    } catch (e) {

      print('placeOrderReq Error: $e');
      rethrow;
    }
  }
}
