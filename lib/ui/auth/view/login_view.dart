import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../auth_bloc.dart';
import '../auth_event.dart';
import '../auth_state.dart';
import 'components/auth_email_field.dart';
import 'components/auth_password_field.dart';
import 'components/auth_submit_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _signInEmailController.dispose();
    _signInPasswordController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 48),
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Sign In'),
                  Tab(text: 'Sign Up'),
                ],
              ),
              const SizedBox(height: 24),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  final errorMessage = state is AuthError ? state.message : null;

                  return Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildSignInTab(isLoading, errorMessage),
                        _buildSignUpTab(isLoading, errorMessage),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInTab(bool isLoading, String? errorMessage) {
    return Form(
      key: _signInFormKey,
      child: ListView(
        children: [
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                errorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          AuthEmailField(controller: _signInEmailController),
          const SizedBox(height: 16),
          AuthPasswordField(controller: _signInPasswordController),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.go('/login/forgot-password'),
              child: const Text('Forgot password?'),
            ),
          ),
          const SizedBox(height: 16),
          AuthSubmitButton(
            label: 'Sign In',
            isLoading: isLoading,
            onPressed: () {
              if (_signInFormKey.currentState?.validate() ?? false) {
                context.read<AuthBloc>().add(AuthEvent.signInRequested(
                      email: _signInEmailController.text.trim(),
                      password: _signInPasswordController.text,
                    ));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpTab(bool isLoading, String? errorMessage) {
    return Form(
      key: _signUpFormKey,
      child: ListView(
        children: [
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                errorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          AuthEmailField(controller: _signUpEmailController),
          const SizedBox(height: 16),
          AuthPasswordField(
            controller: _signUpPasswordController,
            showValidationHints: true,
          ),
          const SizedBox(height: 24),
          AuthSubmitButton(
            label: 'Create Account',
            isLoading: isLoading,
            onPressed: () {
              if (_signUpFormKey.currentState?.validate() ?? false) {
                context.read<AuthBloc>().add(AuthEvent.signUpRequested(
                      email: _signUpEmailController.text.trim(),
                      password: _signUpPasswordController.text,
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
}
