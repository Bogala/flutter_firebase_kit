# Layer Import Direction

Imports flow strictly downward. Never skip or reverse.

```
ui/     → domain_module.dart only
domain/ → data_module.dart only
data/   → core_module.dart only
core/   → no internal imports
```

- `ui/` must never import from `data/` or `core/` directly
- Most common mistake: using a DTO in a BLoC state — use domain Entities instead
- Always import via `*_module.dart`, not individual files (see module-exports.md)
