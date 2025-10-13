import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eduid/core/exception/login_exception.dart';
import 'package:eduid/core/storage/flutter_secure_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http show Client;

abstract class UserRemoteDataSource {
  Future<Map<String, dynamic>> requestLogin();
  Future<Map<String, dynamic>> verifyToken();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final http.Client client;
  final String? email;
  final String? password;
  final bool? isTeacher;

  UserRemoteDataSourceImpl({
    required this.client,
    this.email,
    this.password,
    this.isTeacher,
  });

  String get baseUrl {
    final String baseUrl;
    if (Platform.isAndroid) {
      baseUrl = "http://10.0.2.2:3000/";
    } else if (Platform.isIOS) {
      baseUrl = "http://127.0.0.1:3000/";
    } else {
      baseUrl = "http://localhost:3000/";
    }
    return baseUrl;
  }

  @override
  Future<Map<String, dynamic>> requestLogin() async {
    try {
      if (email == null ||
          email!.isEmpty ||
          password == null ||
          password!.isEmpty) {
        throw LoginException(
          title: 'Invalid Input',
          message: 'Email and password are required.',
        );
      }

      final response = await client.post(
        Uri.parse('${baseUrl}auth_user/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'isTeacher': isTeacher,
        }),
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
    } catch (e) {
      if (e is LoginException) {
        rethrow;
      } else if (e is SocketException) {
        throw LoginException(
          title: 'Network Error',
          message:
              'Could not connect to the server. Please check your internet connection or try again later — the server may be temporarily unavailable.',
        );
      } else if (e is FormatException) {
        throw LoginException(
          title: 'Invalid Response',
          message:
              'The server returned data in an unexpected format. Please try again later.',
        );
      } else if (e is TimeoutException) {
        throw LoginException(
          title: 'Request Timeout',
          message:
              'The server is taking too long to respond. Please try again later.',
        );
      } else {
        throw LoginException(
          title: 'Unexpected Error',
          message: 'Something went wrong: $e',
        );
      }
    }
  }

  @override
  Future<Map<String, dynamic>> verifyToken() async {
    final storage = SecureStorage.instance.storage;
    final String? accessToken = await storage.read(key: 'accessToken');
    final String? refreshToken = await storage.read(key: 'refreshToken');
    debugPrint('Access Token: $accessToken');
    debugPrint('Refresh Token: $refreshToken');

    final response = await client.post(
      Uri.parse('${baseUrl}verify_token/refresh_token'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      }),
    );

    debugPrint('Response: $response');
    debugPrint('Response (Status): ${response.statusCode}');
    final json = await jsonDecode(response.body);

    debugPrint('Response JSON: $json');

    final status = response.statusCode;
    final state = json['state'];
    debugPrint('State: $state');

    if (status == 200) {
      // request success
      debugPrint('Response JSON: $json');
      return json;
    } else if (status == 400 && state == 'missing_tokens') {
      debugPrint('Response: Missing Tokens');
      throw Exception(json['message']);
    } else if (status == 400 && state == 'valid') {
      debugPrint('Response: Valid');
      return json;
    } else if (status == 401 && state == 'invalid_refresh_token') {
      debugPrint('Response: Invalid Refresh Token');
      throw Exception(json['message']);
    } else if (status == 403 && state == 'invalid_access_token') {
      debugPrint('Response: Invalid Access Token');
      throw Exception(json['message']);
    } else {
      debugPrint('Response: Something Went Wrong');
      throw Exception('Something went wrong');
    }
  }
}
