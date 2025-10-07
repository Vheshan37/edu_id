import 'dart:convert';
import 'dart:io';

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
      Uri.parse('$baseUrl/auth_user/login'),
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
      return json;
    } else {
      throw Exception(json['message'] ?? 'Unknown error');
    }
  }
}
