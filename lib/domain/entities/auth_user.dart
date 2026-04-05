import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/data_module.dart';

part 'auth_user.freezed.dart';

@freezed
sealed class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String uid,
    required String email,
    String? displayName,
    required bool isEmailVerified,
  }) = _AuthUser;

  factory AuthUser.fromDto(AuthUserDto dto) => AuthUser(
        uid: dto.uid,
        email: dto.email ?? '',
        displayName: dto.displayName,
        isEmailVerified: dto.isEmailVerified,
      );
}
