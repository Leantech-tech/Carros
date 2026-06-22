import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/auth/auth_manager.dart';
import '/auth/base_auth_user_provider.dart';
import '/backend/api/api_client.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'api_user_provider.dart';

export '/auth/base_auth_user_provider.dart';

class ApiAuthManager extends AuthManager with EmailSignInManager {
  static const _tokenKey = 'carros_api_token';
  static const _userKey = 'carros_api_user';

  final _authStateController = StreamController<BaseAuthUser?>.broadcast();
  Stream<BaseAuthUser?> get onAuthStateChange => _authStateController.stream;

  /// Carrega o usuário salvo localmente, se existir.
  Future<BaseAuthUser?> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null && userJson.isNotEmpty) {
      try {
        final userData = json.decode(userJson) as Map<String, dynamic>;
        currentUser = CarrosApiUser(
          uid: userData['id']?.toString() ?? '',
          email: userData['login']?.toString(),
          displayName: userData['nome']?.toString(),
          isAdmin: userData['is_admin'] == true,
        );
        _authStateController.add(currentUser);
        return currentUser;
      } catch (e) {
        print('Erro ao carregar usuário salvo: $e');
      }
    }
    currentUser = null;
    _authStateController.add(null);
    return null;
  }

  Future<void> _persistUser(String token, Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userKey, json.encode(userData));
  }

  Future<void> _clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  /// Retorna o token JWT armazenado.
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  @override
  Future signOut() async {
    await _clearUser();
    currentUser = null;
    _authStateController.add(null);
  }

  @override
  Future deleteUser(BuildContext context) async {
    print('Error: delete user attempted with no backend support!');
  }

  @override
  Future updateEmail({
    required String email,
    required BuildContext context,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Update email is not supported yet')),
    );
  }

  Future updatePassword({
    required String newPassword,
    required BuildContext context,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Update password is not supported yet')),
    );
  }

  @override
  Future resetPassword({
    required String email,
    required BuildContext context,
    String? redirectTo,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset is not supported yet')),
    );
  }

  @override
  Future<BaseAuthUser?> signInWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    return _signInOrCreateAccount(
      context,
      () => _login(email, password),
    );
  }

  @override
  Future<BaseAuthUser?> createAccountWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    return _signInOrCreateAccount(
      context,
      () => _register(email, password),
    );
  }

  Future<Map<String, dynamic>?> _login(String email, String password) async {
    final response = await ApiClient.post('/auth/login', {
      'login': email,
      'password': password,
    });
    return response as Map<String, dynamic>?;
  }

  Future<Map<String, dynamic>?> _register(String email, String password) async {
    final response = await ApiClient.post('/auth/register', {
      'nome': email.split('@').first,
      'login': email,
      'password': password,
    });
    return response as Map<String, dynamic>?;
  }

  Future<BaseAuthUser?> _signInOrCreateAccount(
    BuildContext context,
    Future<Map<String, dynamic>?> Function() authFunc,
  ) async {
    try {
      final data = await authFunc();
      if (data == null || data['token'] == null) {
        return null;
      }

      final token = data['token'] as String;
      final userData = data['user'] as Map<String, dynamic>? ?? {};

      await _persistUser(token, userData);

      final authUser = CarrosApiUser(
        uid: userData['id']?.toString() ?? '',
        email: userData['login']?.toString(),
        displayName: userData['nome']?.toString(),
        isAdmin: userData['is_admin'] == true,
      );

      currentUser = authUser;
      _authStateController.add(authUser);
      AppStateNotifier.instance.update(authUser);
      return authUser;
    } catch (e) {
      final message = e.toString();
      final errorMsg = message.contains('já cadastrado')
          ? 'Error: The email is already in use by a different account'
          : 'Error: ${message.replaceFirst('Exception: ', '')}';
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
      return null;
    }
  }
}
