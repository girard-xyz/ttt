# Tic-Tac-Toe (Flutter)

[![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.8.1+-0175C2.svg)](https://dart.dev)
[![iOS](https://img.shields.io/badge/iOS-12.0+-000.svg?logo=apple)](https://www.apple.com/ios/)
[![Android](https://img.shields.io/badge/Android-5.0+-3DDC84.svg?logo=android)](https://www.android.com)
[![Web](https://img.shields.io/badge/Web-Chrome%2FFirefox-FFA500.svg?logo=googlechrome)](https://web.dev)

A cross-platform Tic-Tac-Toe game built with **Flutter** using **Clean Architecture**. Play locally or against an AI opponent powered by the minimax algorithm.

[**Play Online**](https://girard-xyz.github.io/ttt/) — live web version deployed via GitHub Pages.

## Features

- **Local & AI Modes** — Play against another player or challenge the AI
- **Intelligent Opponent** — Minimax algorithm with strategic play
- **Auto-Save** — Game sessions persist automatically via bitpacked encoding
- **Smooth Animations** — Modern UI with fade/scale transitions and win-line drawing
- **Internationalization** — Multi-language support (l10n)
- **Multi-Platform** — iOS, Android, and Web in one codebase

## Quick Start

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

