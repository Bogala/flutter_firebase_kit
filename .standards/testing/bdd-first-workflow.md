# BDD-First Workflow

Write the Gherkin scenario before any implementation code. No exceptions.

## Order
1. Write `.feature` file (describe behavior in plain English)
2. Write step definitions (connect Gherkin to code)
3. Run tests — they should **fail** (Red)
4. Write implementation until tests pass (Green)
5. Refactor

## Feature File Template
```gherkin
Feature: <Feature Name>
  As a <role>
  I want <goal>
  So that <benefit>

  Scenario: <happy path>
    Given <precondition>
    When <action>
    Then <expected outcome>

  Scenario: <edge case or error>
    Given <precondition>
    When <action>
    Then <expected error>
```

## Rules
- Scenarios use business language — no implementation details in Gherkin
- One scenario = one observable behavior
- Test must fail before writing implementation (Red → Green → Refactor)
- Never delete a failing scenario — fix the implementation instead

## Applies To
- **Flutter**: `bdd_widget_test`, feature files in `test/gherkin/features/`
- **Go**: `Godog`, feature files in `tests/features/`
