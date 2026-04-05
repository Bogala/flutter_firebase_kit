# Widget Extraction Rule

Extract sub-widgets to separate `StatelessWidget` (or `StatefulWidget`) classes. Never use `_buildSomething()` private methods that construct UI.

## Wrong
```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildHeader(),      // ❌ private method
      _buildContent(),     // ❌ private method
    ]);
  }

  Widget _buildHeader() => Text('Hello');
}
```

## Correct
```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const MyHeader(),    // ✅ separate class — const possible
      const MyContent(),   // ✅ separate class — const possible
    ]);
  }
}

class MyHeader extends StatelessWidget {
  const MyHeader({super.key});
  @override
  Widget build(BuildContext context) => Text('Hello');
}
```

## Exception
Private methods that **route** between widget instances (switch/case logic) are OK — but each returned value must be a separate class:

```dart
Widget _buildStep() {
  return switch (currentStep) {
    0 => const PersonalInfoSection(),   // ✅ separate class
    1 => const PaymentSection(),         // ✅ separate class
    _ => const PersonalInfoSection(),
  };
}
```

**Why:** Separate classes enable `const` constructors, which allow Flutter to skip rebuilds. Private methods always rebuild with their parent.
