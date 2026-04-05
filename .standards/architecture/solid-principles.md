# SOLID Principles — Applied to CityScope

## Single Responsibility (SRP)

Each module/class has ONE reason to change.

**Go**: One service per bounded context. Repositories handle persistence only. gRPC handlers handle transport only. Domain entities handle business rules only.

**Flutter**: One Bloc per feature concern. Use cases encapsulate a single business operation. Widgets render UI only (no business logic).

**Anti-patterns to catch:**
- A repository that also validates business rules
- A Bloc that calls HTTP directly instead of going through a use case
- A gRPC handler that contains business logic instead of delegating to a service

## Open/Closed (OCP)

Open for extension, closed for modification.

**Go**: Use interfaces (ports) so new adapters can be added without modifying domain or application layers. New repository implementations don't require changes to services.

**Flutter**: Use abstract repository interfaces so implementations can be swapped. Use Bloc events/states pattern — new behaviors = new events, not modified handlers.

**Anti-patterns to catch:**
- Switch statements on type in domain layer (use polymorphism)
- Modifying existing service code to handle a new adapter

## Liskov Substitution (LSP)

Subtypes must be substitutable for their base types.

**Go**: All repository implementations must satisfy the port interface contract fully. Mock implementations in tests must behave consistently with real ones for the contract surface.

**Flutter**: DTO.toDomain() and Entity.toDto() must be lossless round-trips for shared fields. All Design System components must respect the same interaction contract as their base type.

## Interface Segregation (ISP)

Clients should not depend on interfaces they don't use.

**Go**: Split large port interfaces into focused ones. A service that only reads should depend on a `Reader` port, not a full `Repository` port.

**Flutter**: Repository interfaces per feature, not a single mega-repository. Use cases depend only on the repository methods they need.

**Anti-patterns to catch:**
- A port interface with 10+ methods where most adapters implement only 3
- A use case constructor that takes 5 repository dependencies but uses only 2

## Dependency Inversion (DIP)

High-level modules don't depend on low-level modules. Both depend on abstractions.

**Go (Hexagonal)**: Domain depends on NOTHING. Application depends on port interfaces. Adapters implement port interfaces. Wiring happens in `cmd/main.go`.

**Flutter (Clean Arch)**: Domain layer defines repository interfaces. Data layer implements them. Presentation layer depends on use cases, never on data layer directly. DI wiring via `@injectable`.

**This is the CORE principle behind both hexagonal and clean architecture.**

## Verification

When reviewing code, check:
- [ ] Each class/struct has a single, clear responsibility
- [ ] New features extend via new implementations, not by modifying existing code
- [ ] Interfaces are small and focused (≤5 methods)
- [ ] Domain/application layers have zero imports from adapter/infrastructure packages
- [ ] All dependencies point inward (adapters → ports → domain)
