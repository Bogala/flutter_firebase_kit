# Dependency Injection

## Flavor-Scoped Singletons

Use flavor annotations to register different implementations per environment.

```dart
@dev
@Singleton(as: Configuration)
class ConfigurationDev implements Configuration { ... }

@prod @preprod
@Singleton(as: Configuration)
class ConfigurationProd implements Configuration { ... }
```

- Stack multiple annotations to register for multiple flavors
- Custom environments (`@preprod`, `@recette`, `@integration`) declared in `injection.dart` only
- `@dev`, `@prod`, `@test` come from `injectable`

## @Order(-1) for Infrastructure

Configuration and infrastructure singletons must use `@Order(-1)` so they initialize before any dependent singleton.

```dart
@dev
@Order(-1)
@Singleton(as: Configuration)
class ConfigurationDev implements Configuration { ... }
```

## Boot Sequence

Always pass `F.name` (the active flavor) to `configureDependencies()`. Never hardcode an environment string.

```dart
// ✓ Correct
void configureDependencies() => getIt.init(environment: F.name);

// ✗ Wrong
void configureDependencies() => getIt.init(environment: 'dev');
```
