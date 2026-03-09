# Code Generation

## Generated Files — Never Edit Manually

| File pattern | Generator | Trigger |
|---|---|---|
| `*.g.dart` | retrofit_generator, json_serializable | Modify `@RestApi` clients or `@JsonSerializable` DTOs |
| `*.freezed.dart` | freezed | Modify `@freezed` value objects or states |
| `lib/injection.config.dart` | injectable_generator | Add/modify/remove `@injectable`/`@singleton` annotations |

Never hand-edit these files. Always regenerate via build_runner.

## build_runner Commands

```bash
# One-shot regeneration (after modifying DTOs, Entities, or DI annotations)
dart run build_runner build --delete-conflicting-outputs

# Watch mode (during active development)
dart run build_runner watch --delete-conflicting-outputs
```

- Always pass `--delete-conflicting-outputs` — never run without it
- After regenerating, run `flutter analyze` to verify zero warnings

## Flavorizr (Flavor Generation)

Flavorizr is separate from build_runner:

```bash
# Save lib/main.dart and lib/ui/app.dart BEFORE running
dart run flutter_flavorizr
```

WARNING: flutter_flavorizr overwrites `main.dart` and `app.dart`. Save them first, then restore after running.
