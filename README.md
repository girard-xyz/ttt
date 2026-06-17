# Tic-Tac-Toe (Flutter)

[![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.8.1+-0175C2.svg)](https://dart.dev)
[![iOS](https://img.shields.io/badge/iOS-12.0+-000.svg?logo=apple)](https://www.apple.com/ios/)
[![Android](https://img.shields.io/badge/Android-5.0+-3DDC84.svg?logo=android)](https://www.android.com)
[![Web](https://img.shields.io/badge/Web-Chrome%2FFirefox-FFA500.svg?logo=googlechrome)](https://web.dev)

A cross-platform Tic-Tac-Toe game built with **Flutter** using **Clean Architecture**. Play locally or against an AI opponent powered by the minimax algorithm.

## Features

- 🎮 **Local & AI Modes** — Play against another player or challenge the AI
- 🤖 **Intelligent Opponent** — Minimax algorithm with strategic play
- 💾 **Auto-Save** — Game sessions persist automatically via bitpacked encoding
- 🎨 **Smooth Animations** — Modern UI with fade/scale transitions and win-line drawing
- 🌍 **Internationalization** — Multi-language support (l10n)
- 📱 **Multi-Platform** — iOS, Android, and Web in one codebase

## Quick Start

### Prerequisites

- **FVM** (Flutter Version Manager): [Install FVM](https://fvm.app)
- **Dart SDK**: 3.8.1+

### Setup

```bash
# Install dependencies
fvm flutter pub get

# Generate code (Freezed, l10n, JSON serialization)
fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm flutter gen-l10n
```

### Run

```bash
# iOS
fvm flutter run -d ios

# Android
fvm flutter run -d android

# Web
fvm flutter run -d web
```

## Development

### Code Generation

After modifying **Freezed classes** or **ARB files**:

```bash
# Freezed, JSON serializable
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Localization strings
fvm flutter gen-l10n
```

### Testing

```bash
# Run all tests
fvm flutter test

# Run specific test file
fvm flutter test test/domain/use_cases/game_logic_test.dart

# Code analysis
fvm flutter analyze

# Format code
fvm flutter format .
```

### Project Structure

```
lib/
  core/         # Shared constants, l10n, extensions, error handling
  domain/       # Entities, repositories, use cases, AI logic
  data/         # Repository implementations, DTOs (Freezed), data sources
  presentation/ # Screens, widgets, BLoC/Cubit state management
```

**See [AGENTS.md](./AGENTS.md)** for detailed architecture, conventions, and bitpacking details.

## Architecture

Built on **Clean Architecture** with BLoC state management:

- **Domain Layer** — Pure Dart, no UI dependencies
- **Data Layer** — Repositories, local persistence, DTOs
- **Presentation Layer** — BLoC/Cubit, screens, widgets

**Game Serialization:** Board state + turn encoded as a single `int` (2 bits per cell, status bits) for efficient persistence.

For deep dives, see:
- [AGENTS.md — Architecture](./AGENTS.md#architecture)
- [AGENTS.md — Bitpacking](./AGENTS.md#bitpacking)
- [AGENTS.md — Conventions](./AGENTS.md#conventions)

## Learn More

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Pattern](https://bloclibrary.dev)
- [Freezed Code Generation](https://pub.dev/packages/freezed)
- [Clean Architecture in Flutter](https://medium.com/flutter-community/clean-architecture-in-flutter)
