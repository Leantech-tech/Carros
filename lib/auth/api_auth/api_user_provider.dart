import 'dart:async';

import '/auth/base_auth_user_provider.dart';

class CarrosApiUser extends BaseAuthUser {
  CarrosApiUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.isAdmin = false,
  });

  @override
  final String uid;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;
  @override
  final String? phoneNumber;
  final bool isAdmin;

  @override
  bool get loggedIn => true;

  @override
  bool get emailVerified => true;

  @override
  AuthUserInfo get authUserInfo => AuthUserInfo(
        uid: uid,
        email: email,
        displayName: displayName,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
      );

  @override
  Future? delete() =>
      throw UnsupportedError('The delete user operation is not yet supported.');

  @override
  Future? updateEmail(String email) async {
    throw UnsupportedError('The update email operation is not yet supported.');
  }

  @override
  Future? updatePassword(String newPassword) async {
    throw UnsupportedError(
        'The update password operation is not yet supported.');
  }

  @override
  Future? sendEmailVerification() => throw UnsupportedError(
      'The send email verification operation is not yet supported.');

  @override
  Future refreshUser() async {}
}

/// Stream que emite o estado atual do usuário.
/// Emite um usuário vazio quando não há sessão ativa.
Stream<BaseAuthUser> carrosApiUserStream() async* {
  // A sessão é gerenciada pelo ApiAuthManager. Sempre que o currentUser
  // for atualizado, esse stream pode ser notificado externamente.
  yield currentUser ?? _emptyUser();
}

BaseAuthUser _emptyUser() => _CarrosApiGuestUser();

class _CarrosApiGuestUser extends BaseAuthUser {
  @override
  bool get loggedIn => false;

  @override
  bool get emailVerified => false;

  @override
  AuthUserInfo get authUserInfo => const AuthUserInfo();

  @override
  String get uid => '';

  @override
  Future? delete() => null;

  @override
  Future? updateEmail(String email) => null;

  @override
  Future? updatePassword(String newPassword) => null;

  @override
  Future? sendEmailVerification() => null;

  @override
  Future refreshUser() async {}
}
