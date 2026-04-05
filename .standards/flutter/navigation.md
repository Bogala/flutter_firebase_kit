# Flutter Navigation

## AppRouter Wrapper

Always use `AppRouter` methods — never call `GoRouter` directly.

```dart
// Good
getIt<AppRouter>().go('/dashboard');
getIt<AppRouter>().push('/profile');
getIt<AppRouter>().replace('/home');
getIt<AppRouter>().pop();

// Bad — bypasses OTel tracing; some methods also corrupt AppRouter state
context.go('/dashboard');
goRouter.go('/dashboard');
```

- `go/push/replace/pop` auto-record OTel navigation spans to SigNoz
- Bypassing `AppRouter` silently loses traces; for some methods it also corrupts router state

## Deferred Lazy Loading

All deferred routes MUST wrap `loadLibrary()` with `_traceModuleLoad()`:

```dart
import 'package:my_feature/my_feature.dart' deferred as feature;

GoRoute(
  path: '/feature',
  builder: (context, state) => FutureBuilder(
    future: _traceModuleLoad('feature', feature.loadLibrary),
    builder: (context, snapshot) =>
        snapshot.connectionState == ConnectionState.done
            ? feature.FeaturePage()
            : const CircularProgressIndicator(),
  ),
)
```

- Mandatory for every deferred import — no exceptions
- Records load duration and errors for SigNoz performance monitoring

## Redirect Tracing

All route redirects MUST go through `_traceRedirect()`:

```dart
redirect: (context, state) async {
  return await _traceRedirect(
    route: '/protected',
    redirectLogic: () => _checkPermission(),
  );
},
```

- All redirects use `_traceRedirect` — including static path redirects
- Records auth state, redirect reason, and duration
- Errors in redirect logic are caught and recorded; navigation never crashes
