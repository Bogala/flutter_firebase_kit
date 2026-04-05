import 'package:flutter/material.dart';

class AuthPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final bool showValidationHints;

  const AuthPasswordField({
    super.key,
    required this.controller,
    this.errorText,
    this.showValidationHints = false,
  });

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: widget.errorText,
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
        helperText: widget.showValidationHints
            ? '8+ characters, uppercase, lowercase, digit'
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password.';
        }
        if (widget.showValidationHints) {
          if (value.length < 8) return 'At least 8 characters required.';
          if (!value.contains(RegExp(r'[A-Z]'))) {
            return 'At least one uppercase letter required.';
          }
          if (!value.contains(RegExp(r'[a-z]'))) {
            return 'At least one lowercase letter required.';
          }
          if (!value.contains(RegExp(r'[0-9]'))) {
            return 'At least one digit required.';
          }
        }
        return null;
      },
    );
  }
}
