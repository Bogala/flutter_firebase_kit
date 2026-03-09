# Testing (BDD / Gherkin)

## Gherkin Step Naming

Step file names and function names are derived mechanically from the Gherkin step text (French, snake_cased). Names must match verbatim.

```
Step text: "L'application démarre depuis la route {'/'}"
File:      lapplication_demarre_depuis_la_route.dart
Function:  lapplicationDemarreDepuisLaRoute(tester, route)
```

- One async function per file
- Include a `/// Usage: <original step text>` comment at the top
- Parameters correspond to step arguments (e.g. `{'/'}` → `String route`)

## Test Bootstrap Sequence

All steps that boot the app must follow this order:

```dart
MockInterceptor.clearHistory();       // 1. Reset mocks
Intl.defaultLocale = 'fr_FR';        // 2. Set locale (if needed)
F.appFlavor = Flavor.test;           // 3. Set flavor
getIt.allowReassignment = true;       // 4. Allow DI re-registration
configureDependencies();             // 5. Boot DI
TestWidgetsFlutterBinding.ensureInitialized(); // 6. Flutter binding
tester.view.physicalSize = Size(w, h); // 7. Set viewport
tester.view.devicePixelRatio = 1;    // 8. Pixel ratio
tester.view.platformDispatcher.textScaleFactorTestValue = 0.5; // 9.
await tester.pumpWidget(App(...));   // 10. Render
await tester.pumpAndSettle();        // 11. Settle
```

## Test View Settings

All tests run with:
- `devicePixelRatio = 1` — consistent pixel mapping
- `textScaleFactorTestValue = 0.5` — prevents text overflow in fixed-size viewports

Never use the system default for these in tests.
