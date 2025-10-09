import 'dart:convert';
import 'dart:io';

import 'package:eduid/core/exception/login_exception.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http show Client;

abstract class UserRemoteDataSource {
  Future<Map<String, dynamic>> requestLogin();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final http.Client client;
  final String email;
  final String password;

  UserRemoteDataSourceImpl({
    required this.client,
    required this.email,
    required this.password,
  });

  @override
  Future<Map<String, dynamic>> requestLogin() async {
    final String baseUrl;
    if (Platform.isAndroid) {
      baseUrl = "http://10.0.2.2:3000/";
    } else if (Platform.isIOS) {
      baseUrl = "http://127.0.0.1:3000/";
    } else {
      baseUrl = "http://localhost:3000/";
    }
    final response = await client.post(
      Uri.parse('${baseUrl}auth_user/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    debugPrint('Response: $response');
    debugPrint('Response (Status): ${response.statusCode}');
    final json = await jsonDecode(response.body);

    if (response.statusCode == 200) {
      // request success
      debugPrint('Response JSON: $json');
      return json;
    } else if (response.statusCode == 401 &&
        json['message'] == "Authentication failed") {
      throw LoginException(
        title: 'Authentication Failed',
        message:
            'The email or password you entered is incorrect. Please try again.',
      );
    } else if (response.statusCode == 500) {
      throw LoginException(
        title: 'Server Error',
        message:
            'We are currently experiencing issues. Please try again later.',
      );
    } else {
      throw LoginException(
        title: 'Login Failed',
        message:
            'An unexpected error occurred. Please check your connection and try again.',
      );
    }
  }
}
