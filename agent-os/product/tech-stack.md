# Tech Stack

## Framework

- Flutter (Dart SDK ^3.10.2)
- Target: Web (path URL strategy), mobile

## State Management

- flutter_bloc ^9.1.1 — BLoC pattern for all feature screens

## Dependency Injection

- get_it ^9.2.1 — service locator
- injectable ^2.7.1 — annotation-driven DI code generation

## Navigation

- go_router ^17.1.0 — declarative routing with dynamic route injection

## Networking

- dio ^5.9.2 — HTTP client
- retrofit ^4.9.2 — type-safe API clients via code generation
- dio_cache_interceptor ^4.0.5 — response caching
- dio_mocked_responses ^1.6.5 — mock interceptor for tests

## Data / Serialization

- json_annotation + json_serializable — DTO serialization
- freezed + freezed_annotation — immutable value objects and sealed states
- hive ^2.2.3 — local storage

## Internationalization

- intl ^0.20.2 — date formatting and locale support (default: fr_FR)

## Testing

- bdd_widget_test ^2.1.3 — Gherkin/BDD widget tests
- flutter_test (SDK) — widget testing framework
- http_mock_adapter ^0.6.1 — HTTP mocking

## Code Generation

- build_runner ^2.12.2
- injectable_generator, retrofit_generator, json_serializable, freezed

## Flavors

- flutter_flavorizr ^2.4.2 — 6 flavors: prod, preprod, recette, integration, dev, test
