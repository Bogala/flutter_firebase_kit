# flutter_firebase_kit

Flutter/Firebase application using Clean Architecture, flutter_bloc, freezed,
injectable/get_it, go_router, and Firebase (Auth, Firestore, Functions, Vertex AI).

## Spec-Driven Development
This project uses GitHub Spec Kit. ALL feature work follows the SDD workflow.
- Constitution: @.specify/memory/constitution.md — READ BEFORE ANY WORK
- Active specs: @specs/ — check numbered directories for current features
- Before implementing: read spec.md → plan.md → tasks.md in order
- Each task in tasks.md = one atomic commit with task ID reference

## Architecture (Feature-First Clean Architecture)
```
lib/
├── app/                          # MaterialApp, bootstrap, DI init
├── core/                         # Shared: errors, usecases base, utils, config
├── features/
│   └── {feature}/
│       ├── domain/               # Entities, repository interfaces, use cases
│       │   ├── entities/         # @freezed pure Dart objects
│       │   ├── repositories/     # Abstract interfaces only
│       │   └── usecases/         # One class per business operation
│       ├── data/                 # Implementations, DTOs, datasources
│       │   ├── models/           # @freezed DTOs with fromJson/toJson
│       │   ├── repositories/     # Concrete repository implementations
│       │   └── datasources/      # Firebase/API data source classes
│       └── presentation/         # Bloc, pages, widgets
│           ├── bloc/             # Sealed events + sealed states + Bloc
│           ├── pages/            # Full screen widgets
│           └── widgets/          # Feature-scoped extracted widgets
├── routing/                      # go_router config, route constants
└── shared_ui/                    # Design system, theme, global cubits
```

## Commands
- Build: `flutter pub run build_runner build --delete-conflicting-outputs`
- Watch: `flutter pub run build_runner watch --delete-conflicting-outputs`
- Test: `flutter test`
- Lint: `flutter analyze && dart format --set-exit-if-changed .`
- Firebase emulators: `firebase emulators:start`
- Run profile: `flutter run --profile`

## Code Rules
- ALWAYS use sealed classes for Bloc events and states (Dart 3 exhaustiveness)
- ALWAYS check isClosed after async gaps in Bloc handlers
- ALWAYS emit new state instances via copyWith(), never mutate
- ALWAYS use @freezed for entities and DTOs
- ALWAYS use native Dart 3 switch expressions, NEVER freezed when/map
- ALWAYS wrap Firebase calls behind repository interfaces
- NEVER import from another feature's data/ or presentation/ layer
- NEVER use Provider for Blocs — use BlocProvider exclusively
- Use const constructors wherever possible
- Domain layer must have ZERO Flutter imports

## BDD-First Workflow
1. Write Gherkin scenarios in specs/{feature}/spec.md acceptance criteria
2. Create test file with Given-When-Then structure BEFORE implementation
3. Implement minimum code to pass tests (Red-Green-Refactor)
4. Domain tests mock repositories, Bloc tests mock use cases

## Standards References
Detailed rules load automatically via .claude/rules/ when working in relevant paths.
For full standards: @.specify/memory/constitution.md
Coding standards index: @.standards/index.yml — consult before implementing in any covered area
Constitution amendments require SemVer bump and sync with this file (see Governance in constitution)
