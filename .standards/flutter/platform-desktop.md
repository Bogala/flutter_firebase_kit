# Platform: Desktop

Desktop is not the primary target. Keep scope minimal.

## Rules
- Support keyboard shortcuts for all frequent actions
- Implement window size constraints (minimum 800x600)
- Add hover states to all interactive elements — DS components include these by default
- Support right-click context menus where applicable

## Window Management
```dart
import 'package:window_manager/window_manager.dart';

Future<void> configureWindow() async {
  await windowManager.ensureInitialized();
  await windowManager.waitUntilReadyToShow(
    const WindowOptions(
      size: Size(1200, 800),
      minimumSize: Size(800, 600),
      center: true,
      title: 'SaaSter',
    ),
  );
  await windowManager.show();
}
```

## Keyboard Shortcuts
Register global shortcuts via `Shortcuts` + `Actions`:
```dart
Shortcuts(
  shortcuts: {
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN):
        const CreateNewIntent(),
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS):
        const SaveIntent(),
  },
  child: Actions(
    actions: {
      CreateNewIntent: CallbackAction<CreateNewIntent>(
        onInvoke: (_) => _bloc.add(const CreateNew()),
      ),
    },
    child: child,
  ),
)
```

## Menu Bar
Use `PlatformMenuBar` for macOS native menus:
```dart
PlatformMenuBar(
  menus: [
    PlatformMenu(label: 'File', menus: [
      PlatformMenuItem(
        label: 'New',
        shortcut: const SingleActivator(LogicalKeyboardKey.keyN, control: true),
        onSelected: () => _bloc.add(const CreateNew()),
      ),
    ]),
  ],
  child: const App(),
)
```

## Exceptions
- Multi-window support is not required unless a specific feature demands it
- System tray integration is optional — implement only if background processing is needed
