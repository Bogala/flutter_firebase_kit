# Dependency Injection (injectable)

Use `get_it` + `injectable` for compile-time dependency injection.

## Annotations
```dart
@injectable          // New instance per request
@singleton           // Single instance for app lifetime
@lazySingleton       // Singleton, created on first use
```

## Registration
Mark constructor with `@factoryMethod`:
```dart
@injectable
class UserInfoRepository {
  final Authentication _auth;

  @factoryMethod
  UserInfoRepository(this._auth);
}
```

For classes with no dependencies, `@factoryMethod` is optional.

## Resolution
```dart
// In Bloc constructor (lazy resolution)
final interactor = getIt<LoginInteractor>();

// Via injected constructor (preferred for Blocs)
@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginInteractor interactor) : super(...);
}
```

## Lifecycle with streams
Singletons that own StreamControllers must implement `@disposeMethod`:
```dart
@singleton
class GetUser {
  final StreamController<UserEntity> _controller = StreamController();

  @disposeMethod
  void dispose() => _controller.close();
}
```

## Code generation
After adding/changing `@injectable` annotations:
```bash
dart run build_runner build --delete-conflicting-outputs
```
