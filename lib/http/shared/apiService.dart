import 'httpService.dart';

class ApiService {
  HttpService httpService = HttpService();

  //login
  Future<dynamic> login(String email, String password) async {
    final endpoint = 'login';
    final data = {'email': email, 'password': password};
    return await httpService.post(endpoint, data);
  }

  //register
  Future<dynamic> register(String firstName, String lastName,
      String phoneNumber, String email, String password, String role) async {
    final endpoint = 'register';
    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'role': role
    };
    return await httpService.post(endpoint, data);
  }

  //changePassword
  Future<dynamic> changePassword(
      int userId, String currentPassword, String newPassword) async {
    final endpoint = 'change-password';
    final data = {
      'userId': userId,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
    return await httpService.post(endpoint, data);
  }

  //updateProfile
  Future<dynamic> updateProfile(int id, String firstName, String lastName,
      String phoneNumber, String email, String role) async {
    final endpoint = 'users/$id';

    final data = {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "email": email,
      "role": role
    };

    return await httpService.put(endpoint, data);
  }

  //deleteProfile
  Future<dynamic> deleteProfile(int id) async {
    final endpoint = 'user/$id';
    return await httpService.delete(endpoint);
  }

  //getOffices
  Future<dynamic> getOffices() async {
    final endpoint = 'offices';
    return await httpService.get(endpoint);
  }

  //getStores
  Future<dynamic> getStores(int officeId) async {
    final endpoint = 'stores/$officeId';
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

  Future<dynamic> placeOrder(
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
    final endpoint = 'place-order';
    final data = {
      'userId': userId,
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
      'shopId': shopId,
      'storeName': storeName,
      'officeId': officeId,
      'description': description,
      'deliveryFee': deliveryFee,
      'items': items.map((item) {
        return {
          'foodId': item['foodId'],
          'quantity': item['quantity'],
          'itemPrice': item['itemPrice'],
          'foodName': item['foodName'],
          'orderCustomizations': item['customizations'] ?? [],
        };
      }).toList(),
    };

    return await httpService.post(endpoint, data);
  }

  //addStatus
  Future<dynamic> addStatus(
      int orderId, String orderStatus, int updatedBy) async {
    final endpoint = 'status';
    final data = {
      "orderId": orderId,
      "status": orderStatus,
      "updatedBy": updatedBy,
    };

    return await httpService.post(endpoint, data);
  }

  //getUserById
  Future<dynamic> getUserById(int userid) async {
    final endpoint = 'user/$userid';
    return await httpService.get(endpoint);
  }

  //getStoreMenuCategories
  Future<dynamic> getUserAddress(int userid) async {
    final endpoint = 'addresses/$userid';
    return await httpService.get(endpoint);
  }

  //deleteUserAddress//
  Future<dynamic> deleteUserAddress(int id) async {
    final endpoint = 'address/$id';
    return await httpService.delete(endpoint);
  }

  //addAddress
  Future<dynamic> addAddress(
      // String officePack,
      // String officeAddress,
      int userId,
      String recipientName,
      String recipientPhoneNumber,
      String streetAddress,
      String building,
      String suburb,
      String city,
      String postalCode,
      String province) async {
    final endpoint = 'address';
    final data = {
      "officePack": "",
      "officeAddress": "",
      "userId": userId,
      "active": true,
      "town": city,
      "province": province,
      "apartment": building,
      "streetAddress": streetAddress,
      "postalCode": postalCode,
      "recipientName": recipientName,
      "recipientMobileNumber": recipientPhoneNumber,
      "suburb": suburb
    };

    return await httpService.post(endpoint, data);
  }

  //rateApp
  Future<dynamic> rateApp(
      int userId, String message, int rating, String improve) async {
    final endpoint = 'rate';
    final data = {
      'userId': userId,
      'message': message,
      'improve': improve,
      'rating': rating,
    };
    return await httpService.post(endpoint, data);
  }

  //getStoreMenuCategories
  Future<dynamic> getOrders(int userid) async {
    final endpoint = 'order/user/$userid';
    return await httpService.get(endpoint);
  }

  //getOrderById
  Future<dynamic> getOrderById(int orderid) async {
    final endpoint = 'order/$orderid';
    return await httpService.get(endpoint);
  }

  //getOrderDeliveryPartnerId
  Future<dynamic> getOrderDeliveryPartnerId(int deliveryPartnerId) async {
    final endpoint = 'order/delivery-partner/$deliveryPartnerId';
    return await httpService.get(endpoint);
  }

  //getOrderDeliveryPartner
  Future<dynamic> getOrderDeliveryPartner(int officeid) async {
    final endpoint = 'all-order/delivery-partner/$officeid';
    return await httpService.get(endpoint);
  }

  //getQuestionnaireTitle
  Future<dynamic> getQuestionnaireTitle(int storemenuid) async {
    final endpoint = 'questionnaire-title/$storemenuid';
    return await httpService.get(endpoint);
  }

  //addChatbotMessage
  Future<dynamic> addChatbotMessage(
      int userId, String message, int orderId, int storeId) async {
    final endpoint = 'message';
    final data = {
      'userId': userId,
      'message': message,
      'orderId': orderId,
      'storeId': storeId,
    };
    return await httpService.post(endpoint, data);
  }

  //getChatbotMessages
  Future<dynamic> getChatbotMessages(int orderid) async {
    final endpoint = 'message/$orderid';
    return await httpService.get(endpoint);
  }

  //getStoreBankingDetails
  Future<dynamic> getStoreBankingDetails(int storeId) async {
    final endpoint = 'store-banking-details/$storeId';
    return await httpService.get(endpoint);
  }

  // updateOrder
  Future<dynamic> updateOrder(
    int id,
    int deliveryPartnerId,
  ) async {
    final endpoint = 'order';

    final data = {
      'id': id,
      'deliveryPartnerId': deliveryPartnerId,
    };

    return await httpService.put(endpoint, data);
  }
}
