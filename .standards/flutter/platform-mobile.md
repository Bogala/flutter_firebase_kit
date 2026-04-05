# Platform: Mobile

Mobile is a secondary target. Web-first, mobile when needed.

## Rules
- Use Flutter's automatic platform adaptations — do not manually re-implement Material/Cupertino differences
- Handle app lifecycle (background/foreground) via `AppLifecycleListener`
- Use go_router for deep linking — same route definitions as web
- Use `SafeArea` for all root page layouts
- Offline-first: cache critical data locally, sync when connectivity returns

## Platform Adaptations
Flutter adapts automatically (scrolling physics, text selection, transitions). Override only when the Design System requires it:
```dart
if (Theme.of(context).platform == TargetPlatform.iOS) {
  HapticFeedback.lightImpact(); // iOS-specific haptic
}
```

## App Lifecycle
Use `AppLifecycleListener` (preferred over `WidgetsBindingObserver`):
```dart
class AppLifecycleHandler extends StatefulWidget {
  const AppLifecycleHandler({super.key, required this.child});
  final Widget child;

  @override
  State<AppLifecycleHandler> createState() => _AppLifecycleHandlerState();
}

class _AppLifecycleHandlerState extends State<AppLifecycleHandler> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onPause: () => getIt<SessionBloc>().add(const SessionEvent.suspend()),
      onResume: () => getIt<SessionBloc>().add(const SessionEvent.resume()),
    );
  }

  @override
  void dispose() { _listener.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => widget.child;
}
```

## Deep Linking with go_router
Same routes as web — go_router handles platform-specific deep link parsing:
```
Android: intent filter in AndroidManifest.xml
iOS: Associated Domains in Runner.entitlements
Routes: /app/users/:userId works on all platforms
```

## Push Notifications
```dart
@injectable
class NotificationHandler {
  final GoRouter _router;
  NotificationHandler(this._router);

  void handleTap(Map<String, dynamic> data) {
    final route = data['route'] as String?;
    if (route != null) _router.go(route);
  }
}
```

## Offline-First
- Cache API responses in repository layer (not in Bloc)
- Show stale data with refresh indicator rather than empty/error states
- Sync pending mutations when connectivity returns

```dart
@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserApiClient _api;
  final UserLocalSource _local;
  UserRepositoryImpl(this._api, this._local);

  @override
  Future<List<User>> getUsers() async {
    try {
      final dtos = await _api.getUsers();
      await _local.cacheUsers(dtos);
      return dtos.map((d) => d.toDomain()).toList();
    } on DioException {
      return (await _local.getCachedUsers()).map((d) => d.toDomain()).toList();
    }
  }
}
```

## Exceptions
- `Platform.isIOS` / `Platform.isAndroid` acceptable for native plugin config (camera, biometrics), never for layout
- Offline mode is optional for admin-only features where real-time data is critical
