
import 'dart:convert';

import 'package:eats/http/shared/apiService.dart';
import 'package:flutter/widgets.dart';

import '../shared/loading_dialog.dart';

class StoreApiService {
  ApiService apiService = ApiService();

  //getOfficesReq
  Future<List<dynamic>> getOfficesReq() async {
    try {
      var results = await apiService.getOffices();

      if (results.statusCode == 200) {
        final data = jsonDecode(results.body);

        return data; // Return the decoded data to the caller
      } else {
        throw Exception('Failed to fetch offices: ${results.statusCode}');
      }
    } catch (e) {
      print('getOfficesReq Error: $e');
      rethrow; // Rethrow the error to be handled by the caller
    }
  }

    Future<List<dynamic>> getStoresReq(int officeId) async {
      try {
        var results = await apiService.getStores(officeId);

        if (results.statusCode == 200) {
          final data = jsonDecode(results.body);
          return data;
        } else {
          // Handle non-200 status codes
          print('Error: ${results.statusCode} - ${results.reasonPhrase}');
          throw Exception('Failed to fetch stores. Status code: ${results.statusCode}');
        }
      } catch (e) {
        print('getStoresReq Error: $e');
        rethrow;
      }
    }


    //getOfficesReq
  Future<List<dynamic>> getStoreMenuByCategoryIdReq(int categoryId) async {
    try {
      var results = await apiService.getStoreMenuByCategoryId(categoryId);

      if(results.statusCode == 200){
        final data = jsonDecode(results.body);
        return data;
      } else {
        // Handle non-200 status codes
        print('Error: ${results.statusCode} - ${results.reasonPhrase}');
        throw Exception('Failed to fetch stores. Status code: ${results.statusCode}');
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
  Future<List<dynamic>> getStoreMenuCategoriesReq(int storeId) async {
    try {
      var results = await apiService.getStoreMenuCategories(storeId);

      if(results.statusCode == 200){
        final data = jsonDecode(results.body);
        return data;
      }else {
        // Handle non-200 status codes
        print('Error: ${results.statusCode} - ${results.reasonPhrase}');
        throw Exception('Failed to fetch stores.');
      }
    } catch (e) {
      print('getStoreMenuTopMealsReq Error: $e');
      rethrow;
    }
  }

  //getOrdersReq
  Future<List<dynamic>> getOrdersReq(int userid) async {
    try {
      var results = await apiService.getOrders(userid);

      if(results.statusCode == 200){
        final data = jsonDecode(results.body);
        return data;
      }else{
        // Handle non-200 status codes
        print('Error: ${results.statusCode} - ${results.reasonPhrase}');
        throw Exception('Failed to fetch stores.');
      }
    } catch (e) {

      print('getOrdersReq Error: $e');
      rethrow;
    }
  }

  //placeOrderReq
  Future<void> placeOrderReq(
      BuildContext context,
      int userId,
      String deliveryAddress,
      String paymentMethod,
      int shopId,
      String orderCode,
      String storeName,
      List<Map<String, dynamic>> items,

      ) async {
    try {
      LoadingDialog.show(context);

      // Call the updated `placeOrder` function with the items list
      var results = await apiService.placeOrder(
        userId,
        deliveryAddress,
        paymentMethod,
        shopId,
        orderCode,
        storeName,
        items,

      );

      print(results);
      print(results.body);
      print(results.statusCode);

      if (results.statusCode == 200) {
        LoadingDialog.hide(context);

        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   '/orderreview',
        //       (Route<dynamic> route) => true,
        // );
        print('Order placed successfully');
      }

    } catch (e) {
      LoadingDialog.hide(context);

      print('placeOrderReq Error: $e');
      rethrow;
    }
  }


  //placeOrderReq
  Future<void> rateAppReq(
      BuildContext context,
      int userId,
      String message,
      int rating,
      String improve) async {
    try {
      // Show the loading dialog
      LoadingDialog.show(context);

      var results = await apiService.rateApp(
          userId,
          message,
          rating,
          improve);

      if(results.statusCode == 200){
        LoadingDialog.hide(context);

        Navigator.of(context).pushNamedAndRemoveUntil(
            '/feedbackconfirmed', (Route<dynamic> route) => true);
      }
    } catch (e) {

      print('placeOrderReq Error: $e');
      rethrow;
    }
  }
}
