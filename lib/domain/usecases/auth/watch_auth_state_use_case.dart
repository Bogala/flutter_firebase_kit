import 'package:injectable/injectable.dart';

import '../../../data/data_module.dart';
import '../../domain_module.dart';

@singleton
class WatchAuthStateUseCase {
  final AuthRepository _authRepository;

  WatchAuthStateUseCase(this._authRepository);

  Stream<AuthUser?> call() => _authRepository.watchAuthState();
}
