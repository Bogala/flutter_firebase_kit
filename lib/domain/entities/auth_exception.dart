import 'auth_error_type.dart';

class AuthException implements Exception {
  final AuthErrorType type;
  final String message;

  const AuthException({required this.type, required this.message});

  @override
  String toString() => 'AuthException($type): $message';
}
