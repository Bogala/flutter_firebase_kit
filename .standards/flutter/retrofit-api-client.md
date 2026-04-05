# Retrofit API Client

## Rules
- Every API client uses `@RestApi` — never write raw Dio calls in repository code
- API clients live in `data/datasources/` within the feature folder
- API clients return DTOs — never domain entities
- Register API clients via `@module` in Injectable — never instantiate manually
- Base URL is empty string (`''`) — Kong proxy handles routing

## @RestApi Pattern
```dart
part 'user_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  @GET('/api/users/{id}')
  Future<UserDto> getUser(@Path('id') String id);

  @GET('/api/users')
  Future<List<UserDto>> getUsers(@Queries() Map<String, dynamic> filters);

  @POST('/api/users')
  Future<UserDto> createUser(@Body() CreateUserDto dto);

  @DELETE('/api/users/{id}')
  Future<void> deleteUser(@Path('id') String id);
}
```

## @module Registration
Third-party deps and generated clients are registered via `@module`:
```dart
@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio(AuthInterceptor auth) => Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ))..interceptors.add(auth);

  @lazySingleton
  UserApiClient userApiClient(Dio dio) => UserApiClient(dio);

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
```

## Repository Integration
Repository consumes the API client and maps DTOs to domain entities:
```dart
@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserApiClient _api;
  UserRepositoryImpl(this._api);

  @override
  Future<User> getUser(UserId id) async {
    final dto = await _api.getUser(id.value);
    return dto.toDomain();
  }
}
```

## Error Handling
Catch `DioException` in the repository — never let it leak to domain or presentation:
```dart
@override
Future<User> getUser(UserId id) async {
  try {
    final dto = await _api.getUser(id.value);
    return dto.toDomain();
  } on DioException catch (e) {
    switch (e.response?.statusCode) {
      case 401: throw const AuthenticationException();
      case 404: throw UserNotFoundException(id);
      default:  throw NetworkException(e.message ?? 'Unknown error');
    }
  }
}
```

## File Structure
```
feature/data/datasources/
├── user_api_client.dart      # @RestApi definition
└── user_api_client.g.dart    # Generated
feature/data/repositories/
└── user_repository_impl.dart # @Injectable(as:) consumes client
feature/domain/repositories/
└── user_repository.dart      # Abstract interface
```

## Code Generation
After adding/changing `@RestApi` definitions:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Exceptions
- Direct Dio usage is acceptable for file uploads with progress tracking
- `baseUrl` may be non-empty for external third-party APIs not proxied through Kong
