import 'package:injectable/injectable.dart';

import '../router.dart';
import 'view/forgot_password_page.dart';
import 'view/login_page.dart';

@singleton
class AuthUiModule {
  AuthUiModule(AppRouter appRouter) {
    appRouter.addRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    );
    appRouter.addRoute(
      path: '/login/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    );
  }
}
