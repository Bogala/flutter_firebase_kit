import 'package:firebase_auth/firebase_auth.dart';

class AuthUserDto {
  final String uid;
  final String? email;
  final String? displayName;
  final bool isEmailVerified;

  const AuthUserDto({
    required this.uid,
    this.email,
    this.displayName,
    required this.isEmailVerified,
  });

  factory AuthUserDto.fromFirebaseUser(User user) => AuthUserDto(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        isEmailVerified: user.emailVerified,
      );
}
