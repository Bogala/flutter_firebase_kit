import '../../domain/domain_module.dart';

abstract class AuthRepository {
  Stream<AuthUser> signUp(String email, String password);
  Stream<AuthUser> signIn(String email, String password);
  Stream<void> signOut();
  Stream<void> sendPasswordResetEmail(String email);
  Stream<AuthUser?> watchAuthState();
}
