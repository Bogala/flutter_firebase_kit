import 'package:injectable/injectable.dart';

import '../../../data/data_module.dart';
import '../../domain_module.dart';

@singleton
class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Stream<AuthUser> call(String email, String password) =>
      _authRepository.signIn(email, password);
}
