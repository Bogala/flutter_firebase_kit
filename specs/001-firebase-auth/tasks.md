# Tasks: Authentication System with Firebase Auth

**Input**: Design documents from `/specs/001-firebase-auth/`
**Prerequisites**: plan.md (required), spec.md (required), research.md, data-model.md, contracts/

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup

**Purpose**: Add Firebase dependencies and initialize Firebase in the app

- [x] T001 Add `firebase_core` and `firebase_auth` to dependencies in `pubspec.yaml`
- [x] T002 Add `firebase_auth_mocks` to dev_dependencies in `pubspec.yaml`
- [x] T003 Add `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)` to `lib/main.dart` between `WidgetsFlutterBinding.ensureInitialized()` and `configureDependencies()`
- [x] T004 Run `flutter pub get` to install new dependencies

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core auth infrastructure that MUST be complete before ANY user story

**CRITICAL**: No user story work can begin until this phase is complete

- [x] T005 [P] Create `AuthErrorType` enum in `lib/domain/entities/auth_error_type.dart` with values: `invalidCredentials`, `emailAlreadyInUse`, `weakPassword`, `invalidEmail`, `networkError`, `tooManyRequests`, `unknown`
- [x] T006 [P] Create `AuthException` class in `lib/domain/entities/auth_exception.dart` with `AuthErrorType type` and `String message` fields
- [x] T007 [P] Create `AuthUser` Freezed entity in `lib/domain/entities/auth_user.dart` with fields: `uid` (String), `email` (String), `displayName` (String?), `isEmailVerified` (bool); include `factory AuthUser.fromDto(AuthUserDto dto)`
- [x] T008 [P] Create `AuthUserDto` class in `lib/data/dto/auth_user_dto.dart` wrapping Firebase `User` fields: `uid`, `email`, `displayName`, `isEmailVerified`
- [x] T009 Update `lib/domain/entities/entities_module.dart` to export `auth_user.dart`, `auth_error_type.dart`, `auth_exception.dart`
- [x] T010 Update `lib/data/dto/dto_module.dart` to export `auth_user_dto.dart`
- [x] T011 Create abstract `AuthRepository` interface in `lib/data/repositories/auth_repository.dart` with methods: `signUp(email, password) → Stream<AuthUser>`, `signIn(email, password) → Stream<AuthUser>`, `signOut() → Stream<void>`, `sendPasswordResetEmail(email) → Stream<void>`, `watchAuthState() → Stream<AuthUser?>`
- [x] T012 Create `AuthRepositoryImpl` in `lib/data/repositories/auth_repository_impl.dart` implementing `AuthRepository`, annotated `@injectable` with `@factoryMethod`, wrapping `FirebaseAuth` calls. Map `FirebaseAuthException.code` to `AuthErrorType`. Convert Firebase `User` to `AuthUserDto` then `AuthUser.fromDto()`
- [x] T013 Update `lib/data/repositories/repositories_module.dart` to export `auth_repository.dart` and `auth_repository_impl.dart`
- [x] T014 Create abstract `AuthModule` in `lib/core/di/auth/auth_module.dart` exposing `FirebaseAuth` instance access
- [x] T015 [P] Create `AuthModuleImpl` in `lib/core/di/auth/auth_module_impl.dart` registered as `@Singleton(as: AuthModule)` for `@dev`, `@integration`, `@recette`, `@preprod`, `@prod` environments, providing `FirebaseAuth.instance`
- [x] T016 [P] Create `AuthModuleStub` in `lib/core/di/auth/auth_module_stub.dart` registered as `@Singleton(as: AuthModule)` for `@test` environment, providing `MockFirebaseAuth`
- [x] T017 Create `lib/core/di/auth/auth_core_module.dart` barrel export for auth_module, auth_module_impl, auth_module_stub
- [x] T018 Update `lib/core/di/di_module.dart` to export `auth/auth_core_module.dart`
- [x] T019 Create `GoRouterRefreshStream` class in `lib/ui/router.dart` (or a new file `lib/ui/go_router_refresh_stream.dart`) — a `ChangeNotifier` that subscribes to a `Stream<dynamic>` and calls `notifyListeners()` on each event
- [x] T020 Run `dart run build_runner build --delete-conflicting-outputs` to generate Freezed and Injectable code
- [x] T021 Run `flutter analyze` and fix any warnings to zero

**Checkpoint**: Foundation ready — user story implementation can now begin

---

## Phase 3: User Story 1 — Email/Password Sign-Up (Priority: P1)

**Goal**: New users can create an account with email and password and land on the home screen

**Independent Test**: Launch app → navigate to sign-up → enter valid credentials → verify home screen reached

### Implementation for User Story 1

- [x] T022 [US1] Create `SignUpUseCase` in `lib/domain/usecases/auth/sign_up_use_case.dart` as `@singleton`, injecting `AuthRepository`, exposing `Stream<AuthUser> call(String email, String password)` with client-side password validation (8+ chars, mixed case, 1 digit)
- [x] T023 [US1] Create `lib/domain/usecases/auth/auth_usecases_module.dart` barrel export for all auth use cases
- [x] T024 [US1] Update `lib/domain/usecases/usecases_module.dart` to export `auth/auth_usecases_module.dart`
- [x] T025 [US1] Create `AuthEvent` Freezed events in `lib/ui/auth/auth_event.dart`: `SignUpRequested(email, password)`, `SignInRequested(email, password)`, `SignOutRequested`, `ResetPasswordRequested(email)`, `AuthStateChanged(AuthUser?)`
- [x] T026 [US1] Create `AuthState` Freezed union in `lib/ui/auth/auth_state.dart`: `AuthInitial`, `AuthLoading`, `AuthAuthenticated(AuthUser)`, `AuthUnauthenticated`, `AuthError(AuthErrorType, String)`
- [x] T027 [US1] Create `AuthInteractor` in `lib/ui/auth/auth_interactor.dart` as `@singleton`, injecting all auth use cases, exposing methods that delegate to use cases
- [x] T028 [US1] Create `AuthBloc` in `lib/ui/auth/auth_bloc.dart` taking `AuthInteractor`, handling `SignUpRequested` → `AuthLoading` → `AuthAuthenticated`/`AuthError`
- [x] T029 [P] [US1] Create `AuthEmailField` stateless widget in `lib/ui/auth/view/components/auth_email_field.dart` — email text field with format validation
- [x] T030 [P] [US1] Create `AuthPasswordField` stateless widget in `lib/ui/auth/view/components/auth_password_field.dart` — password field with visibility toggle and complexity hint
- [x] T031 [P] [US1] Create `AuthSubmitButton` stateless widget in `lib/ui/auth/view/components/auth_submit_button.dart` — submit button that disables during loading state
- [x] T032 [US1] Create `LoginPage` in `lib/ui/auth/view/login_page.dart` — initializes `AuthBloc` via `BlocProvider.create` with `AuthInteractor` from `getIt`
- [x] T033 [US1] Create `LoginView` in `lib/ui/auth/view/login_view.dart` — sign-in and sign-up tabs using `BlocBuilder<AuthBloc, AuthState>`, composing email field, password field, submit button. Show error messages from `AuthError` state
- [x] T034 [US1] Create `AuthModule` (UI) in `lib/ui/auth/auth_module.dart` implementing `UIModule`, registering `/login` route pointing to `LoginPage` via `_appRouter.addRoute(...)`
- [x] T035 [US1] Update `AppRouter` in `lib/ui/router.dart` to add `refreshListenable: GoRouterRefreshStream(authStateChanges)` and a global `redirect` callback: unauthenticated users → `/login`, authenticated users on `/login` → `/`
- [x] T036 [US1] Run `dart run build_runner build --delete-conflicting-outputs`
- [x] T037 [US1] Run `flutter analyze` and verify zero warnings
- [x] T038 [US1] Run `flutter test` and verify all existing tests still pass

**Checkpoint**: User Story 1 complete — sign-up works end-to-end, route protection active

---

## Phase 4: User Story 2 — Email/Password Sign-In (Priority: P1)

**Goal**: Returning users can sign in with existing credentials

**Independent Test**: Sign out → enter existing credentials on sign-in tab → verify home screen reached

### Implementation for User Story 2

- [x] T039 [US2] Create `SignInUseCase` in `lib/domain/usecases/auth/sign_in_use_case.dart` as `@singleton`, injecting `AuthRepository`, exposing `Stream<AuthUser> call(String email, String password)`
- [x] T040 [US2] Update `lib/domain/usecases/auth/auth_usecases_module.dart` to export `sign_in_use_case.dart`
- [x] T041 [US2] Update `AuthInteractor` in `lib/ui/auth/auth_interactor.dart` to add sign-in delegation method
- [x] T042 [US2] Add `SignInRequested` event handling in `AuthBloc` at `lib/ui/auth/auth_bloc.dart` → `AuthLoading` → `AuthAuthenticated`/`AuthError`
- [x] T043 [US2] Update `LoginView` in `lib/ui/auth/view/login_view.dart` to dispatch `SignInRequested` event from sign-in tab submit
- [x] T044 [US2] Run `dart run build_runner build --delete-conflicting-outputs`
- [x] T045 [US2] Run `flutter analyze` and `flutter test`

**Checkpoint**: User Stories 1 AND 2 complete — sign-up and sign-in both work independently

---

## Phase 5: User Story 3 — Password Reset (Priority: P2)

**Goal**: Users who forgot their password can request a reset email

**Independent Test**: On login screen → tap "Forgot password" → enter email → verify confirmation message

### Implementation for User Story 3

- [x] T046 [US3] Create `ResetPasswordUseCase` in `lib/domain/usecases/auth/reset_password_use_case.dart` as `@singleton`, injecting `AuthRepository`, exposing `Stream<void> call(String email)`
- [x] T047 [US3] Update `lib/domain/usecases/auth/auth_usecases_module.dart` to export `reset_password_use_case.dart`
- [x] T048 [US3] Update `AuthInteractor` in `lib/ui/auth/auth_interactor.dart` to add reset password delegation
- [x] T049 [US3] Create `ForgotPasswordView` in `lib/ui/auth/view/forgot_password_view.dart` — email field + submit, shows confirmation message on success, uses `BlocBuilder<AuthBloc, AuthState>`
- [x] T050 [US3] Add `ResetPasswordRequested` event handling in `AuthBloc` at `lib/ui/auth/auth_bloc.dart`
- [x] T051 [US3] Update `AuthModule` (UI) in `lib/ui/auth/auth_module.dart` to register `/login/forgot-password` route pointing to a page wrapping `ForgotPasswordView`
- [x] T052 [US3] Update `LoginView` in `lib/ui/auth/view/login_view.dart` to add "Forgot password" link navigating to `/login/forgot-password`
- [x] T053 [US3] Run `dart run build_runner build --delete-conflicting-outputs`
- [x] T054 [US3] Run `flutter analyze` and `flutter test`

**Checkpoint**: User Stories 1, 2, and 3 complete — sign-up, sign-in, and password reset all work

---

## Phase 6: User Story 4 — Sign-Out (Priority: P2)

**Goal**: Authenticated users can sign out and are redirected to login

**Independent Test**: Sign in → trigger sign-out → verify redirect to `/login` → verify back button does not return to home

### Implementation for User Story 4

- [x] T055 [US4] Create `SignOutUseCase` in `lib/domain/usecases/auth/sign_out_use_case.dart` as `@singleton`, injecting `AuthRepository`, exposing `Stream<void> call()`
- [x] T056 [US4] Update `lib/domain/usecases/auth/auth_usecases_module.dart` to export `sign_out_use_case.dart`
- [x] T057 [US4] Update `AuthInteractor` in `lib/ui/auth/auth_interactor.dart` to add sign-out delegation
- [x] T058 [US4] Add `SignOutRequested` event handling in `AuthBloc` at `lib/ui/auth/auth_bloc.dart`
- [x] T059 [US4] Add a sign-out trigger to the home screen or app shell (e.g., an action in `AppBar` or a settings menu). Location depends on existing UI — add to the `ShellRoute` builder in `lib/ui/router.dart` or to a dedicated settings feature
- [x] T060 [US4] Run `dart run build_runner build --delete-conflicting-outputs`
- [x] T061 [US4] Run `flutter analyze` and `flutter test`

**Checkpoint**: User Stories 1–4 complete — full auth lifecycle except session persistence

---

## Phase 7: User Story 5 — Persistent Session (Priority: P3)

**Goal**: Returning users are automatically signed in when reopening the app

**Independent Test**: Sign in → force-close app → reopen → verify landing on home screen without sign-in

### Implementation for User Story 5

- [x] T062 [US5] Create `WatchAuthStateUseCase` in `lib/domain/usecases/auth/watch_auth_state_use_case.dart` as `@singleton`, injecting `AuthRepository`, exposing `Stream<AuthUser?> call()`
- [x] T063 [US5] Update `lib/domain/usecases/auth/auth_usecases_module.dart` to export `watch_auth_state_use_case.dart`
- [x] T064 [US5] Update `AuthInteractor` in `lib/ui/auth/auth_interactor.dart` to expose `watchAuthState` stream
- [x] T065 [US5] Update `AuthBloc` in `lib/ui/auth/auth_bloc.dart` to subscribe to `watchAuthState` on initialization, emitting `AuthAuthenticated` or `AuthUnauthenticated` based on stream events. This handles both app-start session check and token expiry/revocation
- [x] T066 [US5] Verify that `GoRouterRefreshStream` in `lib/ui/router.dart` correctly triggers redirect re-evaluation on auth state changes (session restore and expiry)
- [x] T067 [US5] Run `dart run build_runner build --delete-conflicting-outputs`
- [x] T068 [US5] Run `flutter analyze` and `flutter test`

**Checkpoint**: All user stories complete — full authentication system functional

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Quality improvements that affect multiple user stories

- [x] T069 [P] Verify all `*_module.dart` barrel exports are complete and no cross-layer imports exist (Constitution Principle I)
- [x] T070 [P] Verify no DTOs leak into `domain/` or `ui/` layers (Constitution Principle II)
- [x] T071 [P] Verify all async flows use `Stream`, not `Future` (Constitution Principle II)
- [x] T072 Create BDD feature file `test/gherkin/features/auth_sign_up.feature` with Gherkin scenarios from spec.md US1
- [x] T073 Create BDD feature file `test/gherkin/features/auth_sign_in.feature` with Gherkin scenarios from spec.md US2
- [x] T074 Create BDD feature file `test/gherkin/features/auth_sign_out.feature` with Gherkin scenarios from spec.md US4
- [x] T075 Create step implementations for auth BDD tests in `test/gherkin/steps/`
- [x] T076 Run `flutter test` — all tests MUST pass
- [x] T077 Run `flutter analyze` — zero warnings
- [ ] T078 Run quickstart.md validation (manual walkthrough of all flows)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — start immediately
- **Foundational (Phase 2)**: Depends on Setup — BLOCKS all user stories
- **User Story 1 (Phase 3)**: Depends on Foundational
- **User Story 2 (Phase 4)**: Depends on Foundational. Shares BLoC/UI from US1, so execute after US1
- **User Story 3 (Phase 5)**: Depends on Foundational. Extends login UI from US1, so execute after US1
- **User Story 4 (Phase 6)**: Depends on Foundational. Extends BLoC from US1, so execute after US1
- **User Story 5 (Phase 7)**: Depends on Foundational. Extends BLoC and router from US1, so execute after US1
- **Polish (Phase 8)**: Depends on all user stories being complete

### User Story Dependencies

- **US1 (Sign-Up)**: Creates the auth BLoC, login UI, and route protection — serves as the foundation for all other stories
- **US2 (Sign-In)**: Extends US1's BLoC and login view. Can start after US1
- **US3 (Password Reset)**: Extends US1's login view and BLoC. Can start after US1. Independent of US2
- **US4 (Sign-Out)**: Extends US1's BLoC. Can start after US1. Independent of US2 and US3
- **US5 (Session Persistence)**: Extends US1's BLoC and router. Can start after US1. Independent of US2–US4

### Within Each User Story

- Use cases before BLoC event handlers
- BLoC before UI views
- Module exports updated after each new file
- `build_runner` after Freezed/Injectable changes
- `flutter analyze` and `flutter test` at end of each phase

### Parallel Opportunities

- T005, T006, T007, T008 (domain entities + DTO) — all different files
- T015, T016 (auth module impl + stub) — different files
- T029, T030, T031 (UI components) — all stateless widgets, different files
- T069, T070, T071 (verification tasks) — independent checks
- US2, US3, US4, US5 can all run in parallel AFTER US1 completes (if multiple developers available)

---

## Parallel Example: Foundational Phase

```bash
# Launch all entity/DTO tasks together:
Task: "Create AuthErrorType enum in lib/domain/entities/auth_error_type.dart"
Task: "Create AuthException class in lib/domain/entities/auth_exception.dart"
Task: "Create AuthUser Freezed entity in lib/domain/entities/auth_user.dart"
Task: "Create AuthUserDto in lib/data/dto/auth_user_dto.dart"

# Then launch auth module impl + stub together:
Task: "Create AuthModuleImpl in lib/core/di/auth/auth_module_impl.dart"
Task: "Create AuthModuleStub in lib/core/di/auth/auth_module_stub.dart"
```

## Parallel Example: User Story 1

```bash
# Launch all UI components together:
Task: "Create AuthEmailField in lib/ui/auth/view/components/auth_email_field.dart"
Task: "Create AuthPasswordField in lib/ui/auth/view/components/auth_password_field.dart"
Task: "Create AuthSubmitButton in lib/ui/auth/view/components/auth_submit_button.dart"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL — blocks all stories)
3. Complete Phase 3: User Story 1 (Sign-Up)
4. **STOP and VALIDATE**: Test sign-up end-to-end, verify route protection
5. Deploy/demo if ready — users can create accounts

### Incremental Delivery

1. Setup + Foundational → Foundation ready
2. Add US1 (Sign-Up) → Test → Deploy/Demo (MVP!)
3. Add US2 (Sign-In) → Test → Deploy/Demo (returning users)
4. Add US3 (Password Reset) + US4 (Sign-Out) → Test → Deploy/Demo (full lifecycle)
5. Add US5 (Session Persistence) → Test → Deploy/Demo (polish)
6. BDD tests + verification → Production ready

### Parallel Team Strategy

With multiple developers after Foundational phase:

1. Team completes Setup + Foundational together
2. Developer A: User Story 1 (required first — creates shared BLoC/UI)
3. Once US1 is done, in parallel:
   - Developer A: User Story 2
   - Developer B: User Story 3
   - Developer C: User Story 4
   - Developer D: User Story 5
4. Final: BDD tests and polish

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story is independently testable once US1 provides the base
- Verify tests pass after each phase before moving to next
- Commit after each task or logical group
- All async domain→UI flows MUST use `Stream` (Constitution Principle II)
- All new files MUST be exported via `*_module.dart` (Constitution Principle I)
