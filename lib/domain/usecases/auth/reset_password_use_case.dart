import 'package:injectable/injectable.dart';

import '../../../data/data_module.dart';

@singleton
class ResetPasswordUseCase {
  final AuthRepository _authRepository;

  ResetPasswordUseCase(this._authRepository);

  Stream<void> call(String email) =>
      _authRepository.sendPasswordResetEmail(email);
}
