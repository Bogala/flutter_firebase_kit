# Test Isolation

Each test scenario must be completely independent. Never rely on state from a previous scenario.

## Go: Cleanup in ctx.After()
Every Go BDD scenario registers an `After` hook that deletes its data:

```go
ctx.After(func(ctx context.Context, sc *godog.Scenario, err error) (context.Context, error) {
    if testCtx.db != nil {
        testCtx.db.Exec("DELETE FROM customers")
        testCtx.db.Close()
    }
    return ctx, nil
})
```

- Delete all rows created by the scenario
- Close the DB connection
- Use `DELETE FROM table` not `TRUNCATE` (safer with FK constraints)

## Fixed UUIDs in Tests
Test scenarios may use well-known fixed UUIDs for readability:

```go
customerUUID = "550e8400-e29b-41d4-a716-446655440000"
```

This is safe because `ctx.After()` cleans up between scenarios.

## Flutter: Isolated by Design
Flutter widget tests are isolated by `WidgetTester` — each `testWidgets` block gets a fresh widget tree. No manual cleanup needed.

Reset mocks between tests:
```dart
MockInterceptor.clearHistory();
MockConfiguration.setPersona("anonymous");  // reset to default
```

## Rules
- No `beforeAll` / `afterAll` data setup that leaks between scenarios
- Test state lives in the context struct — not in package-level globals
- If a test fails, cleanup still runs (hooks always execute)
- Scenarios must pass in any order and in isolation
