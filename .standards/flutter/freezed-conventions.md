# Freezed Conventions

## DTOs (Data Transfer Objects)
Use `@Freezed` with JSON serialization for network/API data:

```dart
@Freezed(fromJson: true, toJson: true)
sealed class UserDto with _$UserDto {
  const factory UserDto({
    @JsonKey(name: 'sub') required String uuid,
    required String email,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
```

## Domain Entities
Use `@Freezed` WITHOUT JSON — domain entities must not know about serialization:

```dart
@Freezed(fromJson: false, toJson: false)
sealed class User with _$User {
  const factory User({
    required String uuid,
    required String email,
  }) = _User;
}
```

- No `fromJson`/`toJson` on domain entities — no exceptions
- Repositories are responsible for mapping: `DTO → Entity`
- Serialization is an infrastructure concern, not a domain concern

## Value Objects
Wrap primitive types in Freezed value objects for domain safety:

```dart
@Freezed(fromJson: false, toJson: false)
sealed class UserId with _$UserId {
  const factory UserId(String value) = _UserId;
}

@Freezed(fromJson: false, toJson: false)
sealed class Email with _$Email {
  const factory Email(String value) = _Email;
  const Email._();

  bool get isValid => RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
}
```

Use value objects in domain entities — never raw `String` for IDs or emails:
```dart
@Freezed(fromJson: false, toJson: false)
sealed class User with _$User {
  const factory User({
    required UserId id,
    required Email email,
    required String name,
  }) = _User;
}
```

## Result<T> Union Type
Use a Freezed union for success/failure results from use cases:

```dart
@Freezed(fromJson: false, toJson: false)
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(String message) = Failure<T>;
}
```

Usage in use cases:
```dart
Future<Result<UserProfile>> execute(UserId id) async {
  try {
    final user = await _repository.getUser(id);
    return Result.success(UserProfile(user: user));
  } on RepositoryException catch (e) {
    return Result.failure(e.message);
  }
}
```

## Bloc Events and States
Events and states use `@Freezed` without JSON. Named factory constructors define each variant:

```dart
// Events — one factory per user action
@Freezed(fromJson: false, toJson: false)
sealed class UserEvent with _$UserEvent {
  const factory UserEvent.load(String userId) = UserLoadEvent;
  const factory UserEvent.refresh() = UserRefreshEvent;
  const factory UserEvent.delete(String userId) = UserDeleteEvent;
}

// States — one factory per screen state
@Freezed(fromJson: false, toJson: false)
sealed class UserState with _$UserState {
  const factory UserState.initial() = UserInitialState;
  const factory UserState.loading() = UserLoadingState;
  const factory UserState.loaded(User user) = UserLoadedState;
  const factory UserState.error(String message) = UserErrorState;
}
```

Consume in Bloc with `when`/`maybeWhen`:
```dart
result.when(
  success: (profile) => emit(UserState.loaded(profile)),
  failure: (error) => emit(UserState.error(error)),
);
```

## Read-Only DTO
For API responses that are never sent back (most GET responses):
```dart
@Freezed(fromJson: true, toJson: false)
sealed class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String email,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
```

## Write-Only DTO
For request payloads that are never deserialized:
```dart
@Freezed(fromJson: false, toJson: true)
sealed class CreateUserDto with _$CreateUserDto {
  const factory CreateUserDto({
    required String email,
    required String name,
  }) = _CreateUserDto;
}
```

## Summary Table

| Layer / Purpose       | Annotation                                 | fromJson | toJson |
|-----------------------|--------------------------------------------|----------|--------|
| DTO (full)            | `@Freezed(fromJson: true, toJson: true)`   | Yes      | Yes    |
| DTO (read-only)       | `@Freezed(fromJson: true, toJson: false)`  | Yes      | No     |
| DTO (write-only)      | `@Freezed(fromJson: false, toJson: true)`  | No       | Yes    |
| Domain Entity         | `@Freezed(fromJson: false, toJson: false)` | No       | No     |
| Value Object          | `@Freezed(fromJson: false, toJson: false)` | No       | No     |
| Bloc Event / State    | `@Freezed(fromJson: false, toJson: false)` | No       | No     |
| Result<T>             | `@Freezed(fromJson: false, toJson: false)` | No       | No     |
