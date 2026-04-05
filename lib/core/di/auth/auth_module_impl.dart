import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '/injection.dart';
import 'auth_module.dart';

@dev
@integration
@recette
@preprod
@prod
@Singleton(as: AuthModule)
class AuthModuleImpl implements AuthModule {
  @override
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
