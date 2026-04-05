import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:injectable/injectable.dart';

import 'auth_module.dart';

@test
@Singleton(as: AuthModule)
class AuthModuleStub implements AuthModule {
  late final MockFirebaseAuth _mockFirebaseAuth;

  AuthModuleStub() {
    _mockFirebaseAuth = MockFirebaseAuth();
  }

  @override
  FirebaseAuth get firebaseAuth => _mockFirebaseAuth;
}
