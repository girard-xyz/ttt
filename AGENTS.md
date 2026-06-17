# AGENTS.md — Tic-Tac-Toe (Flutter)

## Setup & Commands

- **Flutter** managed via FVM: `fvm flutter pub get`, `fvm flutter test`, `fvm flutter analyze`, `fvm flutter format .`, `fvm flutter run`
- **App package**: `xyz.girard.ttt`
- **Platforms**: iOS, Android, Web
- **Code generation** after modifying Freezed classes: `fvm flutter pub run build_runner build --delete-conflicting-outputs`
- **l10n generation** after modifying ARB files: `fvm flutter gen-l10n` (config in `l10n.yaml`)
- **Single test**: `fvm flutter test test/path/to/file_test.dart`

## Architecture

Clean Architecture with 3 layers:

```
lib/
  core/         # shared constants, l10n, extensions, error/failure wrappers
  domain/       # entities, repository interfaces, use cases, AI logic
  data/         # repository impls, DTOs (Freezed), data sources
  presentation/ # screens, widgets, BLoC/Cubit (Freezed states/events)
test/
  domain/
  data/
  presentation/
```

- **Domain layer** has zero Flutter/Dart-UI imports — pure Dart
- **AI opponent** (minimax) lives in `domain/` as a use case or service
- **BLoC** in presentation; states and events generated via Freezed
- **Data classes** (DTOs, states, events) use `freezed` + `equatable`
- **Repository pattern**: domain defines interfaces, data implements them
- **Game session persisted** as a single encoded `int` via bit-shift (2 bits per cell + status);
  auto-resumed on app launch without prompting. Encoding lives in `LocalGameRepository`.

## Bitpacking (critical)
Board + turn serialized into a single `int`:
- Bit  0: gameMode (`0` local, `1` vsComputer)
- Bit  1: currentPlayer (`0` X, `1` O)
- Bit  2: humanPlayer (`0` X, `1` O) — meaningful in vsComputer mode
- Bits 3–20: cells 0–8, 2 bits each (`00` empty, `01` X, `10` O) = 18 bits

## UI / UX

- **Colors**: bg `#FC5151`, grid `#B03939`, X `#191919`, O `#FFFFFF`
- **Grid** centered via `AspectRatio(1)` constrained by available width/height
- **Modern animations**: cells fade/scale on placement, win line drawn through symbols, then sheet slides up
- **Win flow**: animate bar across winning 3 cells → brief pause → clear board → show bottom sheet (same config sheet as initial, but with "Play again" action)

## Codegen

- `build_runner` output is **committed** — keep `.g.dart` files in version control
- Run codegen whenever Freezed-annotated classes change

## Testing

- **Unit tests** for domain use cases and AI minimax logic (test all board scenarios: blocking, winning, center/corner/edge priority, draw)
- **Widget tests** for screen-level behavior
- No golden/screenshot tests
- BLoCs tested by pumping events and asserting emitted states
- Assertions use `package:checks`

## SCM

- **Atomic commits**: one logical change per commit (feature, fix, refactor, etc.)
- **Conventional Commits** (<https://www.conventionalcommits.org>):
  - `feat:` — new user-facing feature
  - `fix:` — bug fix
  - `refactor:` — code restructuring without behaviour change
  - `chore:` — tooling, deps, CI, config
  - `test:` — adding or updating tests
  - `docs:` — documentation only
- **Branch no** convention — commits go straight to `main` (single-dev project)
- **No force-push**, never amend pushed commits

## Conventions

- `part 'filename.freezed.dart';` and `part 'filename.g.dart';` for generated code
- Use `@freezed` for immutable data classes and sealed unions (states/events)
- Use `@immutable` with equatable for lightweight value objects if Freezed is overkill
- Prefer `Result<T>` or `Either<Failure, T>` over exceptions for domain-layer error handling
- **SOLID** strictly enforced
- **Null safety**: no `!` operator — use `?` and flow analysis (`if (x != null)`)
- **Logging**: `dart:developer` `log()` — never `print`
- **Function length**: less than 20 lines; extract aggressively
- **Immutability**: `const` constructors everywhere; prefer `StatelessWidget`
- **Composition**: extract complex sub-trees into private `class MyWidget extends StatelessWidget`
