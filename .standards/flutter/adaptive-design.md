# Adaptive Design

## Rules
- Use `MediaQuery.sizeOf(context)` — never `MediaQuery.of(context).size` (causes unnecessary rebuilds)
- Use `DSBreakpoints` for responsive thresholds — never hardcode pixel values
- Never check `Platform.isAndroid` / `Platform.isIOS` for layout decisions — use available space
- Never lock screen orientation
- Content must have a max width on large screens — never stretch full width

## Breakpoints
Use the Design System breakpoints for all layout decisions:
```dart
final width = MediaQuery.sizeOf(context).width;

if (width < DSBreakpoints.compact) {
  // Mobile: single column, bottom nav
} else if (width < DSBreakpoints.medium) {
  // Tablet: two columns, navigation rail
} else {
  // Desktop: multi-column, side navigation
}
```

## LayoutBuilder for Widget-Level Adaptation
Use `LayoutBuilder` when adapting to the widget's own constraints, not the full screen:
```dart
class AdaptivePanel extends StatelessWidget {
  const AdaptivePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 400) return const _CompactPanel();
        return const _ExpandedPanel();
      },
    );
  }
}
```

## Adaptive Navigation
```dart
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < DSBreakpoints.compact) {
      return Scaffold(body: child, bottomNavigationBar: const DSBottomNavBar());
    }
    return Scaffold(
      body: Row(children: [const DSNavigationRail(), Expanded(child: child)]),
    );
  }
}
```

## Content Width Constraint
On wide screens, constrain content to readable width:
```dart
Center(
  child: ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 960),
    child: content,
  ),
)
```

## Scroll State Preservation
```dart
ListView.builder(
  key: const PageStorageKey<String>('user-list'),
  itemCount: users.length,
  itemBuilder: (context, index) => DSListTile(title: users[index].name),
)
```

## Input Adaptation
- Touch: minimum 48x48 targets, swipe gestures
- Mouse: hover states, right-click context menus, precise click areas
- Keyboard: full Tab navigation, shortcuts (see accessibility standard)

## BDD Testing
```dart
testWidgets('Shows bottom nav on mobile', (tester) async {
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);

  await tester.pumpWidget(const MaterialApp(home: AppShell(child: HomePage())));
  expect(find.byType(DSBottomNavBar), findsOneWidget);
  expect(find.byType(DSNavigationRail), findsNothing);
});
```

## Exceptions
- Platform-specific features (camera, biometrics) may check `Platform` — but layout must not
- Fixed dashboard widgets may use absolute sizing when the design explicitly requires it
