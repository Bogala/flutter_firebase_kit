import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Sign-Up steps

Future<void> theUserIsOnTheSignUpScreen(WidgetTester tester) async {
  // Navigate to sign-up tab
  final signUpTab = find.text('Sign Up');
  if (signUpTab.evaluate().isNotEmpty) {
    await tester.tap(signUpTab);
    await tester.pumpAndSettle();
  }
}

Future<void> theyEnterAValidEmailAndPasswordAndSubmit(
    WidgetTester tester) async {
  await tester.enterText(
    find.byType(TextFormField).first,
    'test@example.com',
  );
  await tester.enterText(
    find.byType(TextFormField).last,
    'Password1',
  );
  await tester.tap(find.text('Create Account'));
  await tester.pumpAndSettle();
}

// Sign-In steps

Future<void> theUserIsOnTheSignInScreen(WidgetTester tester) async {
  final signInTab = find.text('Sign In');
  if (signInTab.evaluate().isNotEmpty) {
    await tester.tap(signInTab);
    await tester.pumpAndSettle();
  }
}

Future<void> theyEnterValidCredentialsAndSubmit(WidgetTester tester) async {
  await tester.enterText(
    find.byType(TextFormField).first,
    'test@example.com',
  );
  await tester.enterText(
    find.byType(TextFormField).last,
    'Password1',
  );
  await tester.tap(find.text('Sign In'));
  await tester.pumpAndSettle();
}

// Sign-Out steps

Future<void> theUserIsAuthenticated(WidgetTester tester) async {
  // Verify user is on home screen
  expect(find.text('Home'), findsOneWidget);
}

Future<void> theyTapSignOut(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.logout));
  await tester.pumpAndSettle();
}

// Assertions

Future<void> theyAreRedirectedToTheHomeScreen(WidgetTester tester) async {
  expect(find.text('Welcome!'), findsOneWidget);
}

Future<void> theyAreRedirectedToTheSignInScreen(WidgetTester tester) async {
  expect(find.text('Welcome'), findsOneWidget);
  expect(find.text('Sign In'), findsOneWidget);
}
