<!--
Sync Impact Report
===================
Version change: 0.0.0 → 1.0.0 (MAJOR — initial ratification)

Modified principles: N/A (all new)

Added sections:
  - Core Principles (5 principles)
  - Code Conventions and Commit Standards
  - Dependency Injection and API Architecture
  - Governance

Removed sections: None (template placeholders replaced)

Templates checked:
  - .specify/templates/plan-template.md ✅ no update needed
    (Constitution Check gate at line 32 already present)
  - .specify/templates/spec-template.md ✅ no update needed
    (Gherkin acceptance scenarios align with Principle V)
  - .specify/templates/tasks-template.md ✅ no update needed
    (Phase structure compatible with principles)
  - .specify/templates/checklist-template.md ✅ no update needed
  - .specify/templates/agent-file-template.md ✅ no update needed

Follow-up TODOs: None
-->

# Flutter Firebase Kit Constitution

## Core Principles

### I. Layer Isolation via Module Exports

The project uses four layers: `core/`, `data/`, `domain/`, `ui/`.
Each layer MUST expose its public API exclusively through
`*_module.dart` barrel files.

- `ui/` MUST import only `domain_module.dart`.
- `domain/` MUST import only `data_module.dart`.
- `data/` MUST import only `core_module.dart`.
- Importing individual files from another layer is FORBIDDEN.
  All cross-layer access MUST go through the corresponding
  `*_module.dart`.
- When adding a new file, the developer MUST export it through
  the appropriate module file in the same layer.
- Every subfolder MUST have its own `*_module.dart` that the
  parent module re-exports.

### II. Anti-Corruption Layer

DTOs and domain Entities are strictly separated. Conversion
happens at the boundary between `data/` and `domain/`.

- DTOs MUST reside exclusively in `data/`. They MUST NOT leak
  into `domain/` or `ui/` layers.
- Every domain Entity MUST provide a
  `factory Entity.fromDto(Dto dto)` constructor.
- BLoC states MUST use domain Entities, NEVER DTOs.
- Asynchronous data flow from `domain/` to `ui/` MUST use
  `Stream`, NEVER `Future`. Use Cases that serve reactive data
  MUST expose a `Stream` return type consumed by Interactors.

### III. BLoC Screen Architecture

Each feature MUST follow this directory structure:

```
feature_name/
├── view/
│   ├── components/          # Stateless reusable widgets
│   ├── feature_page.dart    # Initializes the BLoC
│   └── feature_view.dart    # Displays the screen, manages state
├── feature_bloc.dart
├── feature_event.dart
├── feature_state.dart
├── feature_interactor.dart  # Anti-Corruption Layer (UI ↔ Domain)
└── feature_module.dart      # Injects routes into the router
```

- `feature_page.dart` MUST initialize the BLoC via
  `BlocProvider.create`, receiving an Interactor from `getIt`.
- `feature_view.dart` MUST manage state via
  `BlocBuilder`/`BlocConsumer`, NEVER direct service calls.
- The Interactor MUST be annotated `@singleton` and MUST be
  the only injected dependency of the BLoC.
- Components in `view/components/` MUST be stateless widgets.
  They MUST NOT contain business logic.
- Each feature MUST register its routes via a
  `feature_module.dart` that implements `UIModule` and calls
  `_appRouter.addRoute(...)` in its `configure()` method.

### IV. Code Generation Discipline

Generated files MUST NEVER be edited manually:
`*.g.dart`, `*.freezed.dart`, `injection.config.dart`.

- After any modification to DTOs, Entities with Freezed, or
  DI-annotated classes, the developer MUST run
  `dart run build_runner build --delete-conflicting-outputs`
  before committing.
- Use Cases MUST use `@singleton` annotation.
- Repositories MUST use `@injectable` with `@factoryMethod`.
- The `prod`, `dev`, and `test` flavors MUST NEVER be deleted.
- Running `flutter_flavorizr` overwrites `main.dart` and
  `app.dart` — these files MUST be saved before regeneration.

### V. Testing Discipline

Test coverage targets are NON-NEGOTIABLE:

- Use Cases: 100%
- BLoCs: 90%
- Repositories: 80%

Additional rules:

- BDD tests MUST use Gherkin syntax: `.feature` files in
  `test/gherkin/features/`, step implementations (`.dart`) in
  `test/gherkin/steps/`.
- API mock files MUST reside in `/mocks/api/` using the format
  `{ "VERB": { "statusCode": NNN, "data": ... } }`.
- `flutter analyze` MUST pass with zero warnings before any
  commit.
- `flutter test` MUST pass before any merge.
- The three pre-installed BDD steps (app launch, route start,
  screen resize) MUST NOT be removed.

## Code Conventions and Commit Standards

**Commit message format:**

```
<JIRA-ticket> - <type>(<scope>) : <short summary>
```

- **Types**: `build`, `ci`, `docs`, `feat`, `fix`, `perf`,
  `refactor`, `test`
- **Scopes**: `core`, `data`, `domain`, `ui`, `design`
- Summary MUST use present-tense imperative, no capitalization,
  no trailing period.
- Body MUST be present for all types except `docs` and MUST be
  at least 20 characters.
- Revert commits MUST begin with `revert: ` followed by the
  header of the reverted commit.

**Flavor management:**

Six flavors are maintained: `prod`, `preprod`, `recette`,
`integration`, `dev`, `test`. Each has its own `main_*.dart`
entry point. The `prod`, `dev`, and `test` flavors MUST NOT
be deleted under any circumstance.

**Common widgets:**

Reusable widgets in `ui/` MUST be stateless, free of business
logic, and project-specific only. Widgets intended for reuse
across projects MUST be moved to the design system.

## Dependency Injection and API Architecture

**Dependency injection:**

- DI is managed by `get_it` + `injectable`. The entry point
  is `lib/injection.dart` / `lib/injection.config.dart`.
- Use Cases MUST be annotated `@singleton`.
- Repositories MUST be annotated `@injectable` with
  `@factoryMethod`.

**API access:**

- Only Repositories MUST use the Retrofit API client. Use
  Cases MUST call Repositories, NEVER the API client directly.
- `ApiModule` is abstract; concrete implementations are
  environment-scoped via Injectable annotations (`@dev`,
  `@test`, `@prod`, etc.).
- The `@test` environment MUST use `MockInterceptor` from
  `dio_mocked_responses`, not real HTTP.

**Routing:**

- Routes MUST be self-registered by features via their
  module's `configure()` method using `AppRouter.addRoute()`.
- There MUST NOT be a central route file.
- `AppRouter` is a `@singleton` and MUST be the only mechanism
  for navigation registration.

## Governance

1. This constitution supersedes all ad-hoc practices.
   Violations MUST be flagged during code review.
2. Amendments require: (a) documented rationale, (b) version
   bump per SemVer (MAJOR for principle removal/redefinition,
   MINOR for new principles/sections, PATCH for
   clarifications), (c) update to `LAST_AMENDED_DATE`.
3. All PRs MUST include a Constitution Check verifying
   compliance with the five core principles. Reviewers MUST
   reject PRs that violate any principle without an approved
   waiver.
4. `CLAUDE.md` MUST remain consistent with this constitution.
   Any constitutional amendment MUST be reflected in
   `CLAUDE.md` within the same commit.
5. Waivers for exceptional circumstances MUST be documented
   inline (in the PR description) with justification and a
   remediation timeline.
6. `flutter analyze` (zero warnings) and `flutter test`
   (all passing) are mandatory CI gates. No merge MUST
   proceed if either fails.

**Version**: 1.0.0 | **Ratified**: 2026-04-05 | **Last Amended**: 2026-04-05
