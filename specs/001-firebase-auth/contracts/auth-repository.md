# Contract: AuthRepository

**Layer**: `domain/` (abstract) → `data/` (implementation)

## Interface

```
AuthRepository
├── signUp(email, password) → Stream<AuthUser>
├── signIn(email, password) → Stream<AuthUser>
├── signOut() → Stream<void>
├── sendPasswordResetEmail(email) → Stream<void>
└── watchAuthState() → Stream<AuthUser?>
```

## Method Contracts

### signUp(email, password)

- **Input**: Valid email (String), password meeting complexity rules (String)
- **Output**: Stream emitting the newly created `AuthUser`
- **Errors**: `AuthErrorType.emailAlreadyInUse`, `AuthErrorType.weakPassword`,
  `AuthErrorType.invalidEmail`, `AuthErrorType.networkError`
- **Side effect**: User is automatically signed in after creation

### signIn(email, password)

- **Input**: Email (String), password (String)
- **Output**: Stream emitting the authenticated `AuthUser`
- **Errors**: `AuthErrorType.invalidCredentials` (covers both wrong
  password and non-existent account), `AuthErrorType.networkError`,
  `AuthErrorType.tooManyRequests`

### signOut()

- **Input**: None
- **Output**: Stream emitting void on completion
- **Errors**: `AuthErrorType.networkError`
- **Side effect**: Local session cleared, `watchAuthState()` emits `null`

### sendPasswordResetEmail(email)

- **Input**: Email (String)
- **Output**: Stream emitting void on completion
- **Errors**: `AuthErrorType.networkError`
- **Note**: MUST NOT reveal whether email exists (`FR-005`)

### watchAuthState()

- **Input**: None
- **Output**: Continuous stream — emits `AuthUser` when signed in,
  `null` when signed out or session expired
- **Lifecycle**: Active for app duration, typically subscribed once
  at startup

## Error Contract

All methods that can fail MUST emit an error on the stream
of type `AuthException` containing:
- `type`: `AuthErrorType` enum value
- `message`: User-friendly localized message
