import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../auth_bloc.dart';
import '../auth_interactor.dart';
import 'forgot_password_view.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(GetIt.instance<AuthInteractor>()),
      child: const ForgotPasswordView(),
    );
  }
}
