# Accessibility

## Rules
- Every interactive element must have a semantic label — no exceptions
- Use `Semantics` widget to provide labels, hints, and roles for non-text content
- Use DS* components (`DSButton`, `DSTextField`) which include built-in semantic labels — add extra `Semantics` only when the default label is insufficient
- Minimum touch target: 48x48 logical pixels (Material default); DS components already enforce this
- WCAG AA contrast (4.5:1 normal text) — the Design System tokens handle this; do not override colors manually
- Never convey information by color alone — combine with icons or text

## Semantic Markup
```dart
// Images and avatars — always label
Semantics(
  label: 'Photo de profil de ${user.displayName}',
  child: DSAvatar(imageUrl: user.avatarUrl),
)

// Custom interactive widgets — declare role + state
Semantics(
  button: true,
  enabled: isEnabled,
  label: 'Sauvegarder le document',
  child: DSButton(
    onPressed: isEnabled ? _save : null,
    child: const Text('Sauvegarder'),
  ),
)
```

## Keyboard Navigation
- All interactive elements must be reachable via Tab/Shift+Tab
- Provide visible focus indicators (DS theme includes them by default)
- Use `FocusTraversalOrder` for logical tab order when needed
- Restore focus after dialogs: `FocusScope.of(context).requestFocus(previousFocus)`

```dart
// Custom focus order within a form
FocusTraversalGroup(
  policy: OrderedTraversalPolicy(),
  child: Column(
    children: [
      FocusTraversalOrder(
        order: const NumericFocusOrder(1),
        child: DSTextField(label: 'Email'),
      ),
      FocusTraversalOrder(
        order: const NumericFocusOrder(2),
        child: DSTextField(label: 'Mot de passe', obscureText: true),
      ),
    ],
  ),
)
```

## Accessible Forms
- Associate labels via `DSTextField(label:)` — never rely on placeholder alone
- Announce validation errors to screen readers via `Semantics(liveRegion: true)`
- Group related fields with `MergeSemantics` or `Semantics(container: true)`

```dart
Semantics(
  liveRegion: true,
  child: DSTextField(
    label: 'Email',
    errorText: emailError, // Announced automatically when non-null
  ),
)
```

## Dynamic Text Sizing
- Use `MediaQuery.textScalerOf(context)` (not deprecated `textScaleFactorOf`)
- Test layouts at 1.0x, 1.5x, and 2.0x text scale
- Avoid hardcoded heights on text containers — use flexible constraints

## BDD Testing
```dart
testWidgets('Save button has proper semantics', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: DocumentPage()));

  final semantics = tester.getSemantics(find.byType(DSButton));
  expect(semantics.label, contains('Sauvegarder'));
  expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
});

testWidgets('Tab order follows logical flow', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: LoginPage()));

  await tester.sendKeyEvent(LogicalKeyboardKey.tab);
  expect(find.byKey(const Key('email_field')), findsOneWidget);

  await tester.sendKeyEvent(LogicalKeyboardKey.tab);
  expect(find.byKey(const Key('password_field')), findsOneWidget);
});
```

## Exceptions
- Decorative images (`Semantics(excludeSemantics: true)`) when the image adds no information
- Web-only: screen reader testing uses NVDA/JAWS; TalkBack/VoiceOver apply to mobile builds only
