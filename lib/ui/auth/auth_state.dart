import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/domain_module.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated({required AuthUser user}) =
      AuthAuthenticated;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.error({
    required AuthErrorType type,
    required String message,
  }) = AuthError;
}
