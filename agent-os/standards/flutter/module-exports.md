# *_module.dart — Public API Rule

Every folder in `lib/` has a `*_module.dart` that is its only public interface.

- Import via `*_module.dart`, never individual files
- Every folder needs one, no exceptions
- When adding a new file, export it through the folder's `*_module.dart`

```dart
// ✓ Correct
import 'package:app/domain/domain_module.dart';

// ✗ Wrong
import 'package:app/domain/entities/user.dart';
```

Reasons: encapsulates internals (rename/move files without breaking other layers) and makes the public surface explicit.
