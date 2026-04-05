import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain_module.dart';
import 'auth_event.dart';
import 'auth_interactor.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthInteractor _interactor;
  StreamSubscription<AuthUser?>? _authStateSubscription;

  AuthBloc(this._interactor) : super(const AuthState.initial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<AuthStateChanged>(_onAuthStateChanged);

    _authStateSubscription = _interactor.watchAuthState().listen(
      (user) => add(AuthEvent.authStateChanged(user: user)),
    );
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await for (final user in _interactor.signUp(event.email, event.password)) {
        emit(AuthState.authenticated(user: user));
      }
    } on AuthException catch (e) {
      emit(AuthState.error(type: e.type, message: e.message));
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await for (final user in _interactor.signIn(event.email, event.password)) {
        emit(AuthState.authenticated(user: user));
      }
    } on AuthException catch (e) {
      emit(AuthState.error(type: e.type, message: e.message));
    }
  }

  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await for (final _ in _interactor.resetPassword(event.email)) {}
      emit(const AuthState.unauthenticated());
    } on AuthException catch (e) {
      emit(AuthState.error(type: e.type, message: e.message));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await for (final _ in _interactor.signOut()) {}
      emit(const AuthState.unauthenticated());
    } on AuthException catch (e) {
      emit(AuthState.error(type: e.type, message: e.message));
    }
  }

  void _onAuthStateChanged(
    AuthStateChanged event,
    Emitter<AuthState> emit,
  ) {
    if (event.user != null) {
      emit(AuthState.authenticated(user: event.user!));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }
}
