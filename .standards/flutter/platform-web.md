# Platform: Web

Web is the primary target for SaaSter Kit.

## Rules
- Use `PathUrlStrategy` — hash URLs (`/#/`) are forbidden in production
- Build with `flutter build web --wasm` for production (Flutter 3.22+ WasmReady)
- Use deferred loading (`deferred as`) for heavy feature modules
- Handle CORS via Kong API Gateway configuration — never add CORS headers in Flutter
- All routes must be deep-linkable and bookmarkable via go_router

## URL Strategy
Configured once in `main.dart`:
```dart
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const App());
}
```
go_router handles all route definitions — URLs must be clean and SEO-friendly:
```
/app/dashboard
/app/users/:userId
/app/settings/billing
```

## Renderers
- **Skwasm** (default with `--wasm`): best performance, requires COOP/COEP headers
- **CanvasKit**: fallback when WASM not supported, good for complex graphics
- Configure Kong to add `Cross-Origin-Embedder-Policy: require-corp` and `Cross-Origin-Opener-Policy: same-origin` headers for Skwasm

## Deferred Loading
Split heavy features to reduce initial bundle size:
```dart
import 'package:features_ai/ai_dialog.dart' deferred as ai;

Future<void> openAiDialog(BuildContext context) async {
  await ai.loadLibrary();
  if (context.mounted) {
    showDialog(context: context, builder: (_) => ai.AiDialog());
  }
}
```

## Tree Shaking
- Avoid barrel files that re-export everything — import specific files
- Use `--split-debug-info` and `--obfuscate` in production builds
- Monitor bundle size with `--dump-info`

## Web-Specific Storage
```dart
// Use SharedPreferences (backed by localStorage on web)
final prefs = getIt<SharedPreferences>();
await prefs.setString('theme', 'dark');

// For larger data, use Hive or Isar (IndexedDB backend on web)
```

## CORS and API Calls
- All API calls go through Kong (`/api/*`) — same-origin, no CORS issues
- Keycloak auth calls go through Kong (`/auth/*`) — same-origin
- Never call external APIs directly from the browser — proxy through Kong

## PWA Considerations
- Configure `manifest.json` for installable web app
- Service worker handles offline caching of static assets
- App shell loads instantly; data loads asynchronously via Bloc states

## Web Images
- Prefer WebP/AVIF formats for smaller payloads
- Use `Image.network` with `cacheWidth`/`cacheHeight` for responsive sizing
- Lazy-load images below the fold with `ListView.builder`

## BDD Testing
```dart
testWidgets('Deep link navigates to user page', (tester) async {
  final router = GoRouter(
    initialLocation: '/app/users/123',
    routes: appRoutes,
  );

  await tester.pumpWidget(MaterialApp.router(routerConfig: router));
  await tester.pumpAndSettle();

  expect(find.byType(UserDetailPage), findsOneWidget);
});
```

## Exceptions
- Hash URLs acceptable only for embedded widgets or iframe contexts
- Direct external API calls allowed for public CDN assets (images, fonts)
