# Routing

## Feature Self-Registration

Features register their own routes. No central route file.

Each feature's `*_module.dart` is a `@singleton` that injects `AppRouter` and calls `addRoute()` in its constructor.

```dart
@singleton
class LoginModule {
  LoginModule(AppRouter router) {
    router.addRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    );
  }
}
```

- Routes are added at DI initialization time
- No central list of routes — each feature owns its path

## transitionGoRoute() — Mandatory Wrapper

Never use `GoRoute(...)` directly. Always use `transitionGoRoute()`.

```dart
// ✓ Correct
transitionGoRoute(path: '/login', builder: (ctx, state) => LoginPage())

// ✗ Wrong
GoRoute(path: '/login', builder: (ctx, state) => LoginPage())
```

All routes get a uniform 500ms fade transition. No per-route overrides.

## ShellRoute Common Shell

The `ShellRoute` in `AppRouter` wraps all routes. Add app-wide UI (nav bar, bottom bar, global overlay) in the `ShellRoute.builder`, not in individual pages.
