import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zoftcares_mt/core/colors/colors.dart';
import 'package:zoftcares_mt/core/constants/endpoints.dart';
import 'package:zoftcares_mt/core/securestorage/secure_storage.dart';
import 'package:zoftcares_mt/data/models/posts_model.dart';
import 'package:http/http.dart' as http;
import 'package:zoftcares_mt/presentation/login/pages/login_screen.dart';

class PostServices {
  Future<PaginatedResponse> fetchPosts(BuildContext context,
      {int page = 1, int size = 10}) async {
    final accessToken = await getAccessToken();

    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    final url = Uri.parse('${Endpoints.postsUrl}?page=$page&size=$size');
    final response = await http.get(
      url,
      headers: {
        "x-auth-key": accessToken,
      },
    );

    if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'session expired.Please Login',
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: kwhite,
      ));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    } else if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return PaginatedResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load posts');
    }
    throw Exception('Failed to load posts');
  }
}
