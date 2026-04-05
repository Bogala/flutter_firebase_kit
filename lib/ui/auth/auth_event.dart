import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/domain_module.dart';

part 'auth_event.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signUpRequested({
    required String email,
    required String password,
  }) = SignUpRequested;

  const factory AuthEvent.signInRequested({
    required String email,
    required String password,
  }) = SignInRequested;

  const factory AuthEvent.signOutRequested() = SignOutRequested;

  const factory AuthEvent.resetPasswordRequested({
    required String email,
  }) = ResetPasswordRequested;

  const factory AuthEvent.authStateChanged({
    AuthUser? user,
  }) = AuthStateChanged;
}
