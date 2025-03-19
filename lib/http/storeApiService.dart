import 'dart:convert';

import 'package:eats/http/shared/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/loading_dialog.dart';

class StoreApiService {
  ApiService apiService = ApiService();

  //getOfficesReq
  Future<List<dynamic>> getOfficesReq() async {
    try {
      var results = await apiService.getOffices();

      if (results.statusCode == 200) {
        final data = jsonDecode(results.body);
        return data;
      } else {
        throw Exception('Failed to fetch offices: ${results.statusCode}');
      }
    } catch (e) {
      print('getOfficesReq Error: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> getStoresReq(int officeId) async {
    try {
      var results = await apiService.getStores(officeId);

      if (results.statusCode == 200) {
        final data = jsonDecode(results.body);
        return data;
      } else {
        throw Exception(
            'Failed to fetch stores. Status code: ${results.statusCode}');
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

      if (results.statusCode == 200) {
        final data = jsonDecode(results.body);
        return data;
      } else {
        throw Exception(
            'Failed to fetch stores. Status code: ${results.statusCode}');
      }
    } catch (e) {
      print('getStoreMenuByCategoryIdReq Error: $e');
      rethrow;
    }
  }

  //getStoreMenuPromotionMealsReq
  Future<void> getStoreMenuPromotionMealsReq(int storeId) async {
    try {
      await apiService.getStoreMenuPromotionMeals(storeId);
    } catch (e) {
      print('getStoreMenuPromotionMealsReq Error: $e');
      rethrow;
    }
  }

  //getStoreMenuTopMealsReq
  Future<void> getStoreMenuTopMealsReq(int storeId) async {
    try {
      await apiService.getStoreMenuTopMeals(storeId);
    } catch (e) {
      print('getStoreMenuTopMealsReq Error: $e');
      rethrow;
    }
  }

  //getStoreMenuTopMealsReq
  Future<List<dynamic>> getStoreMenuCategoriesReq(int storeId) async {
    try {
      var results = await apiService.getStoreMenuCategories(storeId);

      if (results.statusCode == 200) {
        final data = jsonDecode(results.body);
        return data;
      } else {
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

      if (results.statusCode == 200) {
        final data = jsonDecode(results.body);
        return data;
      } else {
        throw Exception('Failed to fetch stores.');
      }
    } catch (e) {
      print('getOrdersReq Error: $e');
      rethrow;
    }
  }

  //getOrderDeliveryPartnerIdReq
  Future<List<dynamic>> getOrderDeliveryPartnerIdReq(
      int deliveryPartnerId) async {
    try {
      var results =
          await apiService.getOrderDeliveryPartnerId(deliveryPartnerId);

      if (results.statusCode == 200) {
        final data = jsonDecode(results.body);
        return data;
      } else {
        throw Exception('Failed to fetch orders.');
      }
    } catch (e) {
      print('getOrderDeliveryPartnerIdReq Error: $e');
      rethrow;
    }
  }

  //getOrdersReq
  Future<List<dynamic>> getOrderDeliveryPartnerReq(int officeid) async {
    try {
      var results = await apiService.getOrderDeliveryPartner(officeid);

      if (results.statusCode == 200) {
        final data = jsonDecode(results.body);
        return data;
      } else {
        throw Exception('Failed to fetch stores.');
      }
    } catch (e) {
      print('getOrderDeliveryPartnerReq Error: $e');
      rethrow;
    }
  }

  // getOrderById
  Future<Map<String, dynamic>> getOrderByIdReq(int orderId) async {
    try {
      var results = await apiService.getOrderById(orderId);

      if (results.statusCode == 200) {
        final data = jsonDecode(results.body);
        return data;
      } else {
        throw Exception('Failed to fetch order.');
      }
    } catch (e) {
      print('getOrderReq Error: $e');
      rethrow;
    }
  }

  // getOrderById
  Future<List<dynamic>> getQuestionnaireTitleReq(int storemenuid) async {
    try {
      var results = await apiService.getQuestionnaireTitle(storemenuid);

      if (results.statusCode == 200) {
        final data = jsonDecode(results.body); // Ensure this is a list
        return data as List<dynamic>;
      } else {
        throw Exception('Failed to fetch titles and option.');
      }
    } catch (e) {
      print('getQuestionnaireTitleReq Error: $e');
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
    String storeName,
    int officeId,
    description,
    deliveryFee,
    List<Map<String, dynamic>> items,
  ) async {
    try {
      LoadingDialog.show(context);

      var results = await apiService.placeOrder(
        userId,
        deliveryAddress,
        paymentMethod,
        shopId,
        storeName,
        officeId,
        description,
        deliveryFee,
        items,
      );

      if (results.statusCode == 200) {
        // LoadingDialog.hide(context);

        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList('cartItems', []);

        Navigator.of(context).pushNamedAndRemoveUntil(
          '/orderconfirmed',
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      LoadingDialog.hide(context);
      rethrow;
    } finally {
      LoadingDialog.hide(context);
    }
  }

  Future<void> addStatusReq(BuildContext context, int orderId,
      String orderStatus, int updatedBy) async {
    try {
      LoadingDialog.show(context);

      final response =
          await apiService.addStatus(orderId, orderStatus, updatedBy);

      if (response.statusCode == 200) {
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     '/profilelanding', (Route<dynamic> route) => true);
      } else {
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     '/profilelanding', (Route<dynamic> route) => true);
        print('API Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add status');
    } finally {
      LoadingDialog.hide(context);
    }
  }

  //placeOrderReq
  Future<void> rateAppReq(BuildContext context, int userId, String message,
      int rating, String improve) async {
    try {
      // Show the loading dialog
      LoadingDialog.show(context);

      var results = await apiService.rateApp(userId, message, rating, improve);

      if (results.statusCode == 200) {
        LoadingDialog.hide(context);

        Navigator.of(context).pushNamedAndRemoveUntil(
            '/feedbackconfirmed', (Route<dynamic> route) => true);
      }
    } catch (e) {
      rethrow;
    }
  }

// addChatbotMessage
  Future<dynamic> addChatbotMessageReq(
    int userId,
    String message,
    int orderId,
    int storeId,
  ) async {
    try {
      // Call the API service
      var results = await apiService.addChatbotMessage(
        userId,
        message,
        orderId,
        storeId,
      );

      // getChatbotMessages
      // getChatbotMessagesReq(orderId);
    } catch (e) {
      // Handle errors properly
      rethrow;
    }
  }

  // getChatbotMessagesReq
  Future<dynamic> getChatbotMessagesReq(
    int orderId,
  ) async {
    try {
      // Call the API service
      var results = await apiService.getChatbotMessages(
        orderId,
      );

      return results;
    } catch (e) {
      // Handle errors properly
      rethrow;
    }
  }

  // getStoreBankingDetailsReq
  Future<dynamic> getStoreBankingDetailsReq(
    int storeId,
  ) async {
    try {
      // Call the API service
      var results = await apiService.getStoreBankingDetails(
        storeId,
      );

      return results;
    } catch (e) {
      // Handle errors properly
      rethrow;
    }
  }

//updateOrderReq
  Future<void> updateOrderReq(
    BuildContext context,
    int id,
    int deliveryPartnerId,
  ) async {
    try {
      LoadingDialog.show(context);

      // Call the updated `placeOrder` function with the items list
      var results = await apiService.updateOrder(
        id,
        deliveryPartnerId,
      );

      if (results.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Succesful')),
        );
      }
    } catch (e) {
      LoadingDialog.hide(context);
      rethrow;
    } finally {
      LoadingDialog.hide(context);
    }
  }
}
