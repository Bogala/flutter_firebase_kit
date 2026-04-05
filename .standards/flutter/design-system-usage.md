# Design System Usage

All UI components must use `package:design_system`. Never use raw Material widgets for interactive or styled components.

```dart
import 'package:design_system/design_system.dart';
```

## Use DS components
| Instead of... | Use... |
|---|---|
| `ElevatedButton` | `DSButtons.primaryAppButton()` |
| `OutlinedButton` | `DSButtons.secondaryAppButton()` |
| `TextField` | `DSTextFields.appTextField()` |
| `Card` | `DSCards.*` |
| `Colors.blue` | `DSColors.primaryApp` |
| `TextStyle(...)` | `DSTypography.appTextTheme.bodyMedium` |
| `const SizedBox(width: 8)` | `DSSpacing.horizontalSpacerSM` |
| `EdgeInsets.all(16)` | `EdgeInsets.all(DSSpacing.md)` |

## Layout primitives are OK from Flutter
`Row`, `Column`, `Padding`, `SizedBox`, `Expanded`, `Flexible` — use these directly. But use DS constants for sizes:

```dart
SizedBox(width: DSSpacing.sm)     // ✅
SizedBox(width: 8)                 // ❌ hardcoded
```

## Responsive breakpoints
Use `DSBreakpoints` for responsive logic:
```dart
final isDesktop = MediaQuery.sizeOf(context).width >= DSBreakpoints.lg;
```

**Why:** DS components enforce brand consistency. Raw Material widgets use defaults that don't match the visual design.
