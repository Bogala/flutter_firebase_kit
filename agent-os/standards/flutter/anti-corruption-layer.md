# Anti-Corruption Layer — DTOs and Entities

DTOs are internal to `data/`. Domain entities cross layer boundaries.

**Rule:**
- DTOs: only created and used in `data/`
- Entities: the only type returned from repositories to `domain/` and `ui/`
- Conversion: `Entity.fromDto(dto)` called in the repository implementation, never outside
- BLoC states must hold entities, never DTOs
- Streams must emit entities, never DTOs

```dart
// ✓ Repository (data/) converts before returning
Future<User> getUser(int id) async {
  final dto = await _client.getUser(id);
  return User.fromDto(dto); // DTO never leaves data/
}

// ✓ Entity factory constructor in domain/
class User {
  factory User.fromDto(UserDto dto) => User(name: dto.name);
}

// ✗ DTO in BLoC state
class MyState {
  final UserDto user; // Wrong — use User entity
}
```
