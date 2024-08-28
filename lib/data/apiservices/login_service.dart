import 'dart:convert';
import 'package:zoftcares_mt/core/constants/endpoints.dart';
import 'package:zoftcares_mt/core/securestorage/secure_storage.dart';
import 'package:zoftcares_mt/data/models/login_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<LoginResponse> login(String email, String password) async {
    if (email != "test@zoftcares.com" || password != "12345") {
      throw Exception('Invalid credentials');
    }

    final url = Uri.parse(Endpoints.loginUrl);
    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final loginResponse = LoginResponse.fromJson(jsonResponse);
      final accessToken = loginResponse.data.accessToken;
      final expiresIn = loginResponse.data.validity;
      print('Access Token: $accessToken');

      await storeTokens(accessToken, expiresIn);

      return loginResponse;
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
