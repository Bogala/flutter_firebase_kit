# Bloc Pattern

## Layer Flow
```
DTO → Repository → UseCase → Interactor → Bloc → UI
```

Each feature's state management is split across three files:
```
feature/bloc/
├── feature_bloc.dart    # Bloc class
├── feature_event.dart   # Events (inputs)
└── feature_state.dart   # State (outputs)
```

## Interactor as ACL (Anti-Corruption Layer)
Blocs never call UseCases or Repositories directly. An **Interactor** sits between them, orchestrating UseCases and exposing domain-friendly methods:

```dart
@singleton
class LoginInteractor {
  final LoginUser _loginUser;
  final GetUser _getUser;

  LoginInteractor(this._loginUser, this._getUser);

  Future<void> login() => _loginUser();
  Future<void> call() => _getUser();
  Stream<UserEntity> get user => _getUser.stream;
}
```

Bloc consumes the Interactor:
```dart
@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final interactor = getIt<LoginInteractor>();
    on<LoginEventInit>((event, emit) async {
      await emit.onEach(interactor.user, onData: (user) {
        emit(user is AuthenticatedEntity
            ? LoginStateAuthentified(user)
            : LoginStateAnonymous());
      });
    });
  }
}
```

## Events
```dart
abstract class FeatureEvent extends Equatable {
  const FeatureEvent();
  @override List<Object?> get props => [];
}

class EmailChanged extends FeatureEvent {
  const EmailChanged(this.email);
  final String email;
  @override List<Object> get props => [email];
}
```

## State
Use `enum` for status + `copyWith` for updates. Equatable or Freezed — be consistent within a feature:

```dart
enum FeatureStatus { initial, loading, success, failure }

class FeatureState extends Equatable {
  const FeatureState({this.status = FeatureStatus.initial});
  final FeatureStatus status;

  bool get isLoading => status == FeatureStatus.loading;

  FeatureState copyWith({FeatureStatus? status}) =>
      FeatureState(status: status ?? this.status);

  @override List<Object?> get props => [status];
}
```

## Exception: Pure form state
Blocs that manage only local form state (no domain calls) may omit the Interactor:
```dart
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  // No interactor — manages validation state only
}
```

## DI scopes
- Interactors: `@singleton` — long-lived, own stream controllers
- UseCases: `@injectable` or `@singleton` depending on whether they hold state
- Repositories: `@injectable` — stateless adapters
