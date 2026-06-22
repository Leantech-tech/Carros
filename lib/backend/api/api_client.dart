import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';

class ApiClient {
  ApiClient._();

  static final http.Client _client = http.Client();
  static const _tokenKey = 'carros_api_token';

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<Map<String, String>> _buildHeaders() async {
    final headers = {'Content-Type': 'application/json'};
    final token = await _getToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  static Uri _buildUri(String path, Map<String, String>? queryParams) {
    final uri = Uri.parse(kApiBaseUrl + path);
    if (queryParams != null && queryParams.isNotEmpty) {
      return uri.replace(queryParameters: queryParams);
    }
    return uri;
  }

  static Future<dynamic> get(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    final response = await _client.get(
      _buildUri(path, queryParams),
      headers: await _buildHeaders(),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.post(
      _buildUri(path, null),
      headers: await _buildHeaders(),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> patch(
    String path,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.patch(
      _buildUri(path, null),
      headers: await _buildHeaders(),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String path) async {
    final response = await _client.delete(
      _buildUri(path, null),
      headers: await _buildHeaders(),
    );
    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    }

    String message;
    try {
      final decoded = jsonDecode(response.body);
      message = decoded['error'] ?? decoded['message'] ?? response.body;
    } catch (_) {
      message = response.body.isNotEmpty ? response.body : 'Erro ${response.statusCode}';
    }

    throw Exception('Erro na API (${response.statusCode}): $message');
  }
}
