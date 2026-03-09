# Flavors

## Flavor Table

| Flavor | Entry point | Purpose |
|---|---|---|
| `prod` | `lib/main_prod.dart` | Production |
| `preprod` | `lib/main_preprod.dart` | Pre-production |
| `recette` | `lib/main_recette.dart` | UAT / Recette |
| `integration` | `lib/main_integration.dart` | Integration tests |
| `dev` | `lib/main_dev.dart` | Local development |
| `test` | `lib/main_test.dart` | Automated tests |

**Never delete `prod`, `dev`, or `test` flavors.**

To add a new flavor: edit `pubspec.yaml` flavorizr config and run `dart run flutter_flavorizr` (see code-generation.md for caveats).

## Entry Point Pattern

Each `main_*.dart` only sets `F.appFlavor`, then delegates to `main.dart`:

```dart
// main_dev.dart
Future<void> main() async {
  F.appFlavor = Flavor.dev;
  await runner.main();
}
```

- Never add app logic to entry point files
- App-wide initialization (Firebase, analytics, i18n) belongs in `main.dart`
- `F.appFlavor` must be set before `main.dart` runs

## F.name Drives DI Environment

`F.name` returns the active flavor name and is passed to `configureDependencies()` to select flavor-scoped singletons. Reading `F.name` before `F.appFlavor` is set returns an empty string.
