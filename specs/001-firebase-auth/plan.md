# Implementation Plan: Authentication System with Firebase Auth

**Branch**: `001-firebase-auth` | **Date**: 2026-04-05 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/001-firebase-auth/spec.md`

## Summary

Add email/password authentication using Firebase Auth, following the
existing Clean Architecture pattern. The feature includes sign-up,
sign-in, sign-out, password reset, session persistence, and
go_router-based route protection. All Firebase SDK interactions are
isolated in the `data/` layer behind an abstract repository.

## Technical Context

**Language/Version**: Dart 3.10+ / Flutter >=3.10.2
**Primary Dependencies**: `firebase_core`, `firebase_auth`,
`flutter_bloc`, `go_router`, `get_it` + `injectable`, `freezed`
**Storage**: Firebase Auth (remote) — no local storage needed
(Firebase SDK handles token persistence)
**Testing**: `bdd_widget_test` (Gherkin), `firebase_auth_mocks`
**Target Platform**: Android, iOS, Web, macOS
**Project Type**: Mobile app (Flutter starter kit)
**Performance Goals**: Sign-in/sign-up complete in <2s (network dependent)
**Constraints**: Online required for auth operations, token refresh
handled by Firebase SDK (~1h tokens)
**Scale/Scope**: 5 screens (login, sign-up tab, sign-in tab,
forgot password, home redirect)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Layer Isolation via Module Exports | PASS | All new files exported via `*_module.dart`. No cross-layer imports. |
| II. Anti-Corruption Layer | PASS | `AuthUserDto` in `data/`, `AuthUser.fromDto()` in `domain/`. BLoC uses `AuthUser` entity only. Async flow uses `Stream`. |
| III. BLoC Screen Architecture | PASS | Auth feature follows `feature_name/{view/, bloc, event, state, interactor, module}` pattern. Routes registered via `UIModule.configure()`. |
| IV. Code Generation Discipline | PASS | `AuthUser` and `AuthState` use Freezed. `build_runner` required after changes. DI annotations follow convention. |
| V. Testing Discipline | PASS | `firebase_auth_mocks` for test environment. BDD features planned. Coverage targets apply. |

**Gate result**: PASS — proceed to implementation.

## Project Structure

### Documentation (this feature)

```text
specs/001-firebase-auth/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/
│   ├── auth-repository.md
│   └── auth-routes.md
├── checklists/
│   └── requirements.md
└── tasks.md             # Phase 2 output (/speckit.tasks)
```

### Source Code (repository root)

```text
lib/
├── core/
│   ├── di/
│   │   ├── auth/
│   │   │   ├── auth_module.dart          # Abstract auth service interface
│   │   │   ├── auth_module_impl.dart     # FirebaseAuth registration (non-test)
│   │   │   ├── auth_module_stub.dart     # MockFirebaseAuth registration (test)
│   │   │   └── auth_core_module.dart     # Barrel export
│   │   └── di_module.dart                # Updated: export auth_core_module
│   └── core_module.dart
├── data/
│   ├── dto/
│   │   ├── auth_user_dto.dart            # DTO wrapping Firebase User
│   │   └── dto_module.dart               # Updated: export auth_user_dto
│   ├── repositories/
│   │   ├── auth_repository_impl.dart     # AuthRepository implementation
│   │   └── repositories_module.dart      # Updated: export auth_repository_impl
│   └── data_module.dart
├── domain/
│   ├── entities/
│   │   ├── auth_user.dart                # Freezed entity + fromDto
│   │   ├── auth_error_type.dart          # Error enum
│   │   ├── auth_exception.dart           # Typed exception
│   │   └── entities_module.dart          # Updated: export auth entities
│   ├── usecases/
│   │   ├── auth/
│   │   │   ├── sign_in_use_case.dart     # @singleton
│   │   │   ├── sign_up_use_case.dart     # @singleton
│   │   │   ├── sign_out_use_case.dart    # @singleton
│   │   │   ├── reset_password_use_case.dart  # @singleton
│   │   │   ├── watch_auth_state_use_case.dart  # @singleton
│   │   │   └── auth_usecases_module.dart # Barrel export
│   │   └── usecases_module.dart          # Updated: export auth_usecases_module
│   └── domain_module.dart
├── ui/
│   ├── auth/
│   │   ├── view/
│   │   │   ├── components/
│   │   │   │   ├── auth_email_field.dart
│   │   │   │   ├── auth_password_field.dart
│   │   │   │   └── auth_submit_button.dart
│   │   │   ├── login_page.dart           # BlocProvider init
│   │   │   ├── login_view.dart           # Sign-in/sign-up tabs
│   │   │   └── forgot_password_view.dart
│   │   ├── auth_bloc.dart
│   │   ├── auth_event.dart
│   │   ├── auth_state.dart               # Freezed union
│   │   ├── auth_interactor.dart          # @singleton ACL
│   │   └── auth_module.dart              # UIModule, route registration
│   ├── router.dart                       # Updated: add redirect + refreshListenable
│   └── ui_module.dart
├── main.dart                             # Updated: add Firebase.initializeApp()
└── injection.dart
```

**Structure Decision**: Flutter mobile app — all code under `lib/`
following the existing 4-layer Clean Architecture. Auth feature adds
files in each layer, following existing naming and barrel export
conventions.

### Test Structure

```text
test/
├── gherkin/
│   ├── features/
│   │   ├── auth_sign_up.feature
│   │   ├── auth_sign_in.feature
│   │   └── auth_sign_out.feature
│   └── steps/
│       ├── (existing steps...)
│       └── (new auth-specific steps)
└── mocks/
    └── api/
        └── (existing mocks)
```

## Complexity Tracking

> No Constitution Check violations — table not needed.
