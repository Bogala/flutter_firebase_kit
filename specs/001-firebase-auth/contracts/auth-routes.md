# Contract: Authentication Routes

**Layer**: `ui/` — registered via `AuthModule.configure()`

## Routes

| Path | Page | Auth Required | Description |
|------|------|---------------|-------------|
| `/login` | LoginPage | No | Sign-in + sign-up entry point |
| `/login/forgot-password` | ForgotPasswordPage | No | Password reset form |

## Redirect Rules

| Condition | Current Route | Redirect To |
|-----------|---------------|-------------|
| User is NOT authenticated | Any protected route | `/login` |
| User IS authenticated | `/login` or `/login/*` | `/` |
| User IS authenticated | Any protected route | (no redirect) |

## Navigation Flows

### Sign-Up Flow
```
/login → (sign-up tab) → submit → success → / (home)
                                 → error → stay on /login
```

### Sign-In Flow
```
/login → (sign-in tab) → submit → success → / (home)
                                 → error → stay on /login
```

### Password Reset Flow
```
/login → "Forgot password" → /login/forgot-password
     → submit email → confirmation shown → back to /login
```

### Sign-Out Flow
```
(any page) → sign-out action → /login
```
