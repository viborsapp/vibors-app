# Vibors

Social loyalty platform for KSA & UAE.
Built with Flutter, Supabase, and Mapbox.

---

## Quick start

### Prerequisites

- Flutter 3.41+ (Dart 3.11+)
- Xcode 15+ (for iOS)
- Android Studio + SDK 34+ (for Android)
- CocoaPods (`brew install cocoapods`)

### Setup

```bash
# 1. Install dependencies
flutter pub get

# 2. Copy env template and fill in secrets
cp .env.example .env
# Open .env and fill in SUPABASE_URL, SUPABASE_ANON_KEY, MAPBOX_ACCESS_TOKEN

# 3. Run on Chrome (fastest iteration during dev)
flutter run -d chrome

# 4. Or run on a connected iOS device / simulator
flutter run -d iphone

# 5. Or run on Android device / emulator
flutter run -d android
```

---

## Project structure

```
lib/
├── main.dart                 # App entry point
├── core/                     # Cross-cutting infrastructure
│   ├── config/               # Env vars, Supabase client
│   ├── theme/                # Design tokens (colors, type, spacing)
│   ├── router/               # GoRouter route table
│   └── widgets/              # Shared atoms used app-wide
├── features/                 # One folder per feature
│   ├── splash/
│   ├── auth/
│   ├── home/
│   ├── reels/
│   ├── map/
│   ├── profile/
│   └── messages/
└── shared/                   # Cross-feature utilities, extensions

assets/
├── images/
├── icons/
└── animations/
```

Each feature follows the pattern:

```
features/<feature>/
├── data/             # Repositories, data sources, models
├── domain/           # Entities, use cases (if non-trivial)
└── presentation/     # Screens + widgets + state notifiers
```

---

## Design system

All UI must consume tokens from `lib/core/theme/`:

- `AppColors` — brand palette (no ad-hoc colors)
- `AppTypography` — type scale + weights
- `AppSpacing` — 8pt grid (no arbitrary margins)
- `AppRadii` — corner radius scale

Vibors is **dark-first**; light mode is not in scope for MVP.

---

## Architecture notes

- **State**: Riverpod 2 (`flutter_riverpod`)
- **Routing**: GoRouter (declarative)
- **Backend**: Supabase (auth, DB, storage, realtime)
- **Maps**: Mapbox
- **i18n**: Arabic (SA, AE) + English (US); RTL-ready

---

## Secrets

`.env` is **gitignored**. Never commit secrets. Use `.env.example` as the
template — update it whenever you add a new required env var.

---

## License

Proprietary — Vibors © 2026
