# Quickstart: Authentication System with Firebase Auth

**Branch**: `001-firebase-auth`

## Prerequisites

1. Flutter SDK installed (version >=3.10.2)
2. Firebase project created with Authentication enabled
   (Email/Password provider activated)
3. FlutterFire CLI installed: `dart pub global activate flutterfire_cli`
4. `google-services.json` (Android) and `GoogleService-Info.plist`
   (iOS) configured per flavor

## Setup

```bash
# 1. Switch to the feature branch
git checkout 001-firebase-auth

# 2. Install dependencies
flutter pub get

# 3. Generate code (DI, Freezed, etc.)
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app (dev flavor)
flutter run --flavor dev -t lib/main_dev.dart
```

## Verify It Works

### Sign-Up
1. Launch the app — you should be redirected to `/login`
2. Switch to the "Sign Up" tab
3. Enter a valid email and a password (8+ chars, mixed case, 1 digit)
4. Tap "Create Account"
5. You should land on the home screen

### Sign-In
1. Sign out (if signed in)
2. Enter the credentials from step 3 above
3. Tap "Sign In"
4. You should land on the home screen

### Password Reset
1. On the login screen, tap "Forgot password"
2. Enter the email from sign-up
3. You should see a confirmation message
4. Check email for the reset link

### Session Persistence
1. Sign in
2. Force-close the app
3. Reopen — you should land directly on the home screen

### Sign-Out
1. While authenticated, trigger the sign-out action
2. You should be redirected to `/login`
3. Pressing back should NOT return to the home screen

## Run Tests

```bash
# All tests
flutter test

# Analyze (zero warnings required)
flutter analyze
```

## Troubleshooting

- **`Firebase not initialized`**: Ensure `Firebase.initializeApp()`
  runs in `main.dart` before `configureDependencies()`.
- **`No Firebase App '[DEFAULT]' has been created`**: Run
  `flutterfire configure` to generate `firebase_options.dart`.
- **Build errors after adding files**: Run
  `dart run build_runner build --delete-conflicting-outputs`.
- **DI resolution fails**: Ensure new classes have `@singleton` or
  `@injectable` annotations and `build_runner` has been re-run.
