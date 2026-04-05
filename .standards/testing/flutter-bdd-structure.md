# Flutter BDD Test Structure

## Directory Layout
```
test/gherkin/
├── features/
│   ├── login.feature          # Gherkin scenarios
│   └── login_test.dart        # Auto-generated — NEVER edit
└── steps/
    ├── my_app_is_running.dart  # Step definitions
    ├── i_am.dart
    └── i_should_see_widget.dart
```

## Feature File
```gherkin
Feature: Login
  Scenario: Login page by default
    Given My app is running
    Then I should see a {ElevatedButton} with text {"Login or register"}

  Scenario: Logged with admin role
    Given My app is running
    And I am {"admin"}
    When I click on {ElevatedButton} with text {"Login or register"}
    Then I should see widget {DashboardScreen}
```

## Step Definition
```dart
/// Usage: I am {"admin"}
Future<void> iAm(WidgetTester tester, String persona) async {
  MockConfiguration.setPersona(persona);
}

/// Usage: I should see widget {DashboardScreen}
Future<void> iShouldSeeWidget(WidgetTester tester, Type widget) async {
  expect(find.byType(widget), findsOneWidget);
}
```

## App Setup Step
The `My app is running` step must:
- Set `F.appFlavor = Flavor.test`
- Call `configureDependencies(environment: Environment.test)`
- Set a fixed viewport size for deterministic layout tests
- Call `pumpWidget(UiModule())` + `pumpAndSettle()`

## Rules
- Never edit `*_test.dart` generated files — they are overwritten on regeneration
- Step definition files are named after the step: `i_should_see_widget.dart`
- Personas are set via `MockConfiguration.setPersona()`, not by mocking individual services
- Minimum 80% code coverage across all Flutter packages
