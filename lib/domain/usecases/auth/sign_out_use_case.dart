import 'package:injectable/injectable.dart';

import '../../../data/data_module.dart';

@singleton
class SignOutUseCase {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  Stream<void> call() => _authRepository.signOut();
}
