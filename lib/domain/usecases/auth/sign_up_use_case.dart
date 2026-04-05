import 'package:injectable/injectable.dart';

import '../../../data/data_module.dart';
import '../../domain_module.dart';

@singleton
class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Stream<AuthUser> call(String email, String password) {
    final validationError = _validatePassword(password);
    if (validationError != null) {
      return Stream.error(AuthException(
        type: AuthErrorType.weakPassword,
        message: validationError,
      ));
    }
    return _authRepository.signUp(email, password);
  }

  String? _validatePassword(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit.';
    }
    return null;
  }
}
