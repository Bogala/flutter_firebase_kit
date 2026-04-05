import 'package:injectable/injectable.dart';

import '../../domain/domain_module.dart';

@singleton
class AuthInteractor {
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final SignOutUseCase _signOutUseCase;
  final WatchAuthStateUseCase _watchAuthStateUseCase;

  AuthInteractor(
    this._signUpUseCase,
    this._signInUseCase,
    this._resetPasswordUseCase,
    this._signOutUseCase,
    this._watchAuthStateUseCase,
  );

  Stream<AuthUser> signUp(String email, String password) =>
      _signUpUseCase(email, password);

  Stream<AuthUser> signIn(String email, String password) =>
      _signInUseCase(email, password);

  Stream<void> resetPassword(String email) =>
      _resetPasswordUseCase(email);

  Stream<void> signOut() => _signOutUseCase();

  Stream<AuthUser?> watchAuthState() => _watchAuthStateUseCase();
}
