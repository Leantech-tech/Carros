import 'dart:async';

import 'api_auth_manager.dart';
import 'api_user_provider.dart';

export 'api_auth_manager.dart';
export 'api_user_provider.dart';

final _authManager = ApiAuthManager();
ApiAuthManager get authManager => _authManager;

String get currentUserEmail => currentUser?.email ?? '';

String get currentUserUid => currentUser?.uid ?? '';

String get currentUserDisplayName => currentUser?.displayName ?? '';

String get currentUserPhoto => currentUser?.photoUrl ?? '';

String get currentPhoneNumber => currentUser?.phoneNumber ?? '';

bool get currentUserEmailVerified => currentUser?.emailVerified ?? false;

String? _currentJwtToken;

/// Stream que reflete mudanças no token JWT do usuário.
Stream<String?> get jwtTokenStream => _authManager.onAuthStateChange
    .map(
      (user) => _currentJwtToken = user?.loggedIn == true ? 'active' : null,
    )
    .asBroadcastStream();

/// Inicializa o estado de autenticação a partir do armazenamento local.
Future<BaseAuthUser?> initializeAuth() => _authManager.initialize();
