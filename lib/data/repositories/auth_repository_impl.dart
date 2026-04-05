import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../core/core_module.dart';
import '../../domain/domain_module.dart';
import '../dto/dto_module.dart';
import 'auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(AuthModule authModule) : _firebaseAuth = authModule.firebaseAuth;

  @override
  Stream<AuthUser> signUp(String email, String password) async* {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw const AuthException(
          type: AuthErrorType.unknown,
          message: 'Account creation failed. Please try again.',
        );
      }
      yield AuthUser.fromDto(AuthUserDto.fromFirebaseUser(user));
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  @override
  Stream<AuthUser> signIn(String email, String password) async* {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw const AuthException(
          type: AuthErrorType.unknown,
          message: 'Sign-in failed. Please try again.',
        );
      }
      yield AuthUser.fromDto(AuthUserDto.fromFirebaseUser(user));
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  @override
  Stream<void> signOut() async* {
    try {
      await _firebaseAuth.signOut();
      yield null;
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  @override
  Stream<void> sendPasswordResetEmail(String email) async* {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      yield null;
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  @override
  Stream<AuthUser?> watchAuthState() {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return AuthUser.fromDto(AuthUserDto.fromFirebaseUser(user));
    });
  }

  AuthException _mapFirebaseException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return const AuthException(
          type: AuthErrorType.emailAlreadyInUse,
          message: 'This email is already associated with an account.',
        );
      case 'wrong-password':
      case 'user-not-found':
      case 'invalid-credential':
        return const AuthException(
          type: AuthErrorType.invalidCredentials,
          message: 'Invalid email or password.',
        );
      case 'weak-password':
        return const AuthException(
          type: AuthErrorType.weakPassword,
          message: 'Password is too weak. Use at least 8 characters with mixed case and a digit.',
        );
      case 'invalid-email':
        return const AuthException(
          type: AuthErrorType.invalidEmail,
          message: 'The email address format is invalid.',
        );
      case 'network-request-failed':
        return const AuthException(
          type: AuthErrorType.networkError,
          message: 'No internet connection. Please check your network and try again.',
        );
      case 'too-many-requests':
        return const AuthException(
          type: AuthErrorType.tooManyRequests,
          message: 'Too many attempts. Please wait a moment and try again.',
        );
      default:
        return AuthException(
          type: AuthErrorType.unknown,
          message: 'An unexpected error occurred. Please try again later.',
        );
    }
  }
}
