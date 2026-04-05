# Performance

## Rules
- Target 16ms frame time (60fps): ~8ms build + ~8ms render
- Use `const` constructors everywhere possible — they skip rebuilds entirely
- Never do expensive work inside `build()` — cache computations in state or fields
- Localize `setState()` to the smallest subtree that needs to change
- Use `RepaintBoundary` to isolate frequently-repainting widgets

## const Constructors
```dart
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _DashboardHeader(),   // const — never rebuilds
        _DashboardContent(),  // const — never rebuilds from parent
      ],
    );
  }
}
```
Split large widgets into smaller ones. Each `const` sub-widget is skipped on parent rebuild.

## Lazy Lists
Always use builder constructors for lists with more than ~20 items:
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => DSListTile(
    title: items[index].name,
    subtitle: items[index].description,
  ),
)
```
Never use `ListView(children: [...])` for dynamic or large lists.

## Avoid Opacity and saveLayer
```dart
// Avoid — triggers saveLayer (offscreen buffer)
Opacity(opacity: 0.5, child: DSCard(...))

// Prefer — apply opacity directly to the color
DSCard(color: theme.cardColor.withOpacity(0.5))
```

## Avoid Clipping When Possible
```dart
// Avoid — expensive clip operation
ClipRRect(borderRadius: BorderRadius.circular(8), child: child)

// Prefer — decoration handles border radius without clipping
DecoratedBox(
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
  child: child,
)
```

## StringBuffer in Loops
```dart
final buffer = StringBuffer();
for (final item in items) {
  buffer.write(item.label);
}
final result = buffer.toString();
```
Never use `+` operator in a loop for string concatenation.

## RepaintBoundary
Isolate animations and frequently-updating widgets:
```dart
RepaintBoundary(
  child: AnimatedChart(data: chartData),
)
```

## Image Caching
- Use `CachedNetworkImage` for network images (auto-caches to disk)
- Set `cacheWidth` / `cacheHeight` on `Image` to avoid decoding at full resolution
- Prefer WebP format (smaller payload)

## Profiling
- Always profile in **release mode** (`flutter run --release`)
- Use DevTools Performance view for frame analysis
- Enable `debugProfileBuildsEnabled` to spot expensive builds
- Check `checkerboardOffscreenLayers` to find hidden saveLayer calls

## Exceptions
- `Opacity` widget is acceptable for fade animations with `AnimatedOpacity`
- Full `ListView(children:)` is fine for short, static lists (< 20 items)
