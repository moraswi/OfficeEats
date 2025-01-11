import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  String baseUrl = 'https://10.0.2.2:7067/api/';

  // String apiKey = '';

  // HttpService({required this.baseUrl, required this.apiKey});

  Future<dynamic> get(String endpoint) async {
    final url = '$baseUrl$endpoint';
    final response = await http.get(
      Uri.parse(url),
      // headers: {'ApiKey': apiKey},
    );

    return response;
  }

  // when submitting object
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final url = '$baseUrl$endpoint';

    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'ApiKey': apiKey
        },
        body: jsonEncode(data));

    return response;
  }

  // when submitting array
  Future<dynamic> postList(String endpoint, List<dynamic> dataList) async {
    final url = '$baseUrl$endpoint';

    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'ApiKey': apiKey
        },
        body: jsonEncode(dataList));

    return response;
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final url = '$baseUrl$endpoint';

    final response = await http.put(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'ApiKey': apiKey
        },
        body: jsonEncode(data));

    return response;
  }

  Future<dynamic> delete(String endpoint) async {
    final url = '$baseUrl$endpoint';
    final response = await http.delete(
      Uri.parse(url),
      // headers: {'ApiKey': apiKey},
    );

    return response;
  }
}
