# Data Model: Authentication System with Firebase Auth

**Branch**: `001-firebase-auth` | **Date**: 2026-04-05

## Entities

### AuthUser (Domain Entity)

Represents an authenticated user in the domain layer.

| Field | Type | Description |
|-------|------|-------------|
| `uid` | `String` | Unique identifier from Firebase |
| `email` | `String` | User's email address |
| `displayName` | `String?` | Optional display name |
| `isEmailVerified` | `bool` | Whether email has been verified |

**Freezed**: Yes — immutable value object.

**Factory**: `AuthUser.fromDto(AuthUserDto dto)` for
data→domain conversion.

### AuthUserDto (Data Layer DTO)

Thin wrapper around Firebase `User` for the data layer.

| Field | Type | Source |
|-------|------|--------|
| `uid` | `String` | `User.uid` |
| `email` | `String?` | `User.email` |
| `displayName` | `String?` | `User.displayName` |
| `isEmailVerified` | `bool` | `User.emailVerified` |

**Note**: This DTO is constructed directly from the Firebase
`User` object in the repository, not from JSON serialization.
No `*.g.dart` generation needed.

### AuthErrorType (Domain Enum)

Categorizes authentication failures.

| Value | Firebase Code(s) | User-Facing Meaning |
|-------|-------------------|---------------------|
| `invalidCredentials` | `wrong-password`, `user-not-found` | Email or password incorrect |
| `emailAlreadyInUse` | `email-already-in-use` | Account already exists |
| `weakPassword` | `weak-password` | Password too simple |
| `invalidEmail` | `invalid-email` | Email format invalid |
| `networkError` | `network-request-failed` | No internet connection |
| `tooManyRequests` | `too-many-requests` | Rate limited |
| `unknown` | (all others) | Unexpected error |

### AuthState (BLoC State)

| State | Fields | When |
|-------|--------|------|
| `AuthInitial` | none | App just started, checking auth |
| `AuthAuthenticated` | `AuthUser user` | User signed in |
| `AuthUnauthenticated` | none | No active session |
| `AuthLoading` | none | Sign-in/sign-up in progress |
| `AuthError` | `AuthErrorType type, String message` | Operation failed |

**Freezed**: Yes — union type.

## Relationships

```
FirebaseAuth.User (external)
       │
       ▼ (constructed in AuthRepositoryImpl)
   AuthUserDto (data layer)
       │
       ▼ (AuthUser.fromDto)
   AuthUser (domain entity)
       │
       ▼ (via Use Case → Interactor)
   AuthState.authenticated(user) (UI layer)
```

## Validation Rules

- Email: validated by `FR-002` (format check before submission);
  Firebase also validates server-side.
- Password: minimum 8 characters, at least 1 uppercase, 1 lowercase,
  1 digit (`FR-003`). Validated client-side before Firebase call.
- Error messages: MUST NOT reveal whether an email exists in the
  system (`FR-005`). `wrong-password` and `user-not-found` both
  map to `invalidCredentials`.

## State Transitions

```
AuthInitial
    │
    ├─ authStateChanges() emits User → AuthAuthenticated
    └─ authStateChanges() emits null → AuthUnauthenticated

AuthUnauthenticated
    │
    ├─ SignInRequested → AuthLoading → AuthAuthenticated (success)
    ├─ SignInRequested → AuthLoading → AuthError (failure)
    ├─ SignUpRequested → AuthLoading → AuthAuthenticated (success)
    └─ SignUpRequested → AuthLoading → AuthError (failure)

AuthAuthenticated
    │
    └─ SignOutRequested → AuthUnauthenticated

AuthError
    │
    └─ (user retries) → AuthLoading → ...
```
