# BLoC Feature Structure

## Directory Layout

```
lib/ui/feature_name/
├── view/
│   ├── components/        # Stateless reusable widgets (create only when needed)
│   ├── feature_page.dart  # Provides the BLoC via BlocProvider
│   └── feature_view.dart  # Consumes BLoC state, renders UI
├── feature_bloc.dart
├── feature_event.dart
├── feature_state.dart
├── feature_interactor.dart
└── feature_module.dart
```

## Page vs View Responsibility Split

- **`feature_page.dart`** — creates and provides the BLoC via `BlocProvider`. No UI logic.
- **`feature_view.dart`** — consumes BLoC state with `BlocBuilder`/`BlocListener`. No BLoC creation.
- Most common mistake: merging both into one file.

```dart
// feature_page.dart — only provides the BLoC
class FeaturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    BlocProvider(create: (_) => getIt<FeatureBloc>(), child: FeatureView());
}

// feature_view.dart — only displays state
class FeatureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    BlocBuilder<FeatureBloc, FeatureState>(builder: (ctx, state) { ... });
}
```

## Interactor — ACL Between UI and Domain

`feature_interactor.dart` is the Anti-Corruption Layer between UI and Domain.

- Annotated `@singleton`, injected into the BLoC
- Calls domain Use Cases; returns domain Entities (never DTOs)
- Translates domain concepts into UI-friendly types when needed
- `feature_module.dart` handles both route registration and DI wiring

## Stream Over Future for Async Data Flow

Async domain-to-UI data flows must use `Stream`, not `Future`.

```dart
// ✓ Correct
Stream<List<Item>> watchItems();

// ✗ Wrong
Future<List<Item>> getItems();
```
