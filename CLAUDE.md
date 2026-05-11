# Vibors — Claude Code project context

**Always read this file at the start of every session.** It captures the
non-obvious project context that is not derivable from the code alone.

---

## What is Vibors

Vibors is a **social loyalty platform** launching in KSA & UAE (Q1–Q2 2026).
It combines a social feed (think TikTok/Instagram), a venue check-in loyalty
system (think Foursquare + Starbucks Rewards), and a creator economy
(brand–creator paid partnerships).

The product spans:

- **User app** (this codebase, mobile) — consumers
- **Merchant app** (planned) — venues that issue rewards
- **Cashier portal** (planned, web) — staff that scan QRs
- **Brand Dashboard** (planned, web) — paid premium analytics + UGC for brands
- **Super Admin** (planned, web) — back office, T&S, moderation

**The full BRD lives in ClickUp** (Master Doc `2kzmg4ge-678`, ~498 pages
across 17 modules). When you need product spec, ask the user — don't guess.

### Three-metric system (memorise this)

1. **Influence Score** (0–10,000) — social authority. Resets/decays.
2. **Vibe Points** — lifetime cumulative. Drives the tier system.
3. **Vibe Meter** (0–100) — daily/weekly engagement, decays if inactive.

### Loyalty tiers (Vibe Points thresholds)

Bronze (0) → Silver (5k) → Gold (20k) → Platinum (75k).

### Two-QR check-in strategy

- **Method A (Enterprise)**: merchant-issued rotating QR (anti-fraud)
- **Method B (SMB)**: user-shown QR scanned at till

---

## The team

- **Mohammad Abahre** (`moeabahre@gmail.com`, GitHub `moeabahre`) —
  Creative Director, sole code stakeholder. Collaborates in **Arabic**.
  Not a developer by background but very design-literate. Mohammad's quality
  bar is **pixel-perfect, professional, creative, zero-error rate**. When he
  gives a clear directive ("اعمل افضل شي ممكن"), execute — don't ask
  clarifying questions back. Confirm by showing the result.

- **Claude** (you) — pair-programming partner.

GitHub repo: **`viborsapp/vibors-app`** (the org is `viborsapp`, Mohammad is
Owner via his personal account).

---

## Tech stack & key decisions

| Layer | Choice | Why |
|---|---|---|
| Mobile framework | **Flutter** (3.41+) | One codebase, iOS + Android, good pixel fidelity for Vibors' glass/gradient aesthetic |
| State | **Riverpod 2** (`flutter_riverpod`) | Compile-time safety, codegen optional |
| Routing | **GoRouter** (`go_router`) | Declarative, deep-link ready |
| Backend | **Supabase** | Postgres + Auth + Realtime + Storage in one |
| Maps | **Mapbox** (token in `.env`) | Better customisation than Google Maps for the brand look |
| Localisation | `flutter_localizations` + `intl` | Arabic (SA, AE) + English (US); RTL-ready from day 1 |
| Typography | **Inter** via `google_fonts` | Until Vibors ships a custom font |
| Env | **`flutter_dotenv`** | `.env` is gitignored, `.env.example` is the template |

### Architectural pattern

Feature-first folders:

```
lib/
  core/         # cross-cutting (theme, router, config, shared widgets)
  features/     # one folder per product feature
    splash/
    auth/       (placeholder)
    home/       (placeholder)
    reels/
    map/
    profile/
    messages/
  shared/       # extensions, constants
```

Inside each feature, expected structure (as the feature grows):

```
features/<name>/
  data/         # repositories, data sources, models
  domain/       # entities, use cases (only if non-trivial)
  presentation/ # screens + widgets + state notifiers
```

---

## Design system (mandatory tokens)

All UI MUST consume tokens from `lib/core/theme/`:

- `AppColors` — brand palette. Primary `#4E00FF`, accent `#9465FF`, deep
  `#08001F`, raised deep `#11052D`, glass surfaces (low-opacity white).
- `AppTypography` — type scale (12 / 14 / 16 / 18 / 22 / 28 / 36 / 56 / 120),
  built on Inter via `google_fonts`.
- `AppSpacing` — **8pt grid** (4 / 8 / 12 / 16 / 24 / 32 / 48 / 64). No
  arbitrary spacing values inline.
- `AppRadii` — corner radius scale (0 / 4 / 8 / 12 / 16 / 24 / 32 / pill).

**Vibors is dark-first.** No light theme in MVP scope.

**No ad-hoc colors, no inline magic numbers for spacing.** Extend the tokens
instead.

---

## What is built so far

- ✅ Flutter scaffold (82 files from `flutter create` + 16 custom)
- ✅ Design tokens (colors, typography, spacing, theme)
- ✅ `.env` config + Supabase client init (lazy, allows boot without keys)
- ✅ GoRouter with `/`, `/auth`, `/home` placeholder routes
- ✅ **Splash Screen** with 1.6s animation (matches Figma "Logo View" frame
  — V architecture across bottom 55%, "v vibors™" lockup centred, white
  wordmark on violet → deep radial bg)
- ✅ `assets/images/vibors_logo.png` — the dark variant of the lockup
  (recolour via `ColorFiltered` if you need it on light bg)
- ✅ Smoke test in `test/widget_test.dart`
- ✅ Pushed to GitHub `viborsapp/vibors-app`

## What's planned next

1. **User Authentication** flow (`features/auth/`) — Sign-Up, Sign-In, OTP
   (60s timer, 6 boxes), Password (8+/Aa1), Forgot Password, country picker
   (KSA/UAE), indefinite deactivation. 60+ screens designed in Figma.
2. **Onboarding** — Influence Score intro, FTUE prompts.
3. **Home Feed** — Stories carousel + Reels-style feed + Bottom Nav (v5.0:
   Home / Reels / Msgs / Search / Profile — locked).

---

## Important Figma context

File: **Vibors APP** (`Rp0iQ8KwvJ36ggjt96Za1r`). Mohammad is the sole
designer. The "Splash Screen" page contains 5 frames (Start → Loding → Logo
View → Logo Hide → Ready? Let's go) — but only the **Logo View** frame is
the actual app splash. "Ready? Let's go" is the first onboarding screen.

The Figma renders use **3D ray-traced V architecture** that can't be 1:1
reproduced in CustomPainter. Our `SplashVArchitecture` widget is an
approximation; if Mohammad pushes for exact parity, export the bg as a
high-res image and use it as a `DecorationImage`.

---

## Conventions

- **Arabic-first comments OK** when explaining brand/product context, but
  code identifiers stay in English.
- **No emojis in code or commit messages** unless Mohammad asks.
- **Lint clean** — `flutter analyze` should return 0 issues before commit.
- **Commit messages**: conventional commits (`feat:`, `fix:`, `chore:`,
  `refactor:`, `docs:`, `test:`).
- **Branching**: `main` only for now (solo project, no PR review yet).
- **`.env` is sacred** — never commit. `.gitignore` covers it.

---

## Useful commands

```bash
# Run on web (fastest dev loop)
flutter run -d chrome

# Run on iOS simulator (need Xcode + simulator runtime installed)
open -a Simulator && flutter run -d iphone

# Run on Android emulator (start emulator from Android Studio first)
flutter run -d android

# Hot reload (when running)  → press 'r' in the terminal
# Hot restart (when running) → press 'R'

# Static analysis (must be clean)
flutter analyze

# Tests
flutter test

# Format
dart format lib test

# Update dependencies
flutter pub upgrade --major-versions
```

---

## Environment

Mohammad's `.env` has real Supabase + Mapbox credentials. The app boots
without them (Supabase init catches the StateError) so you can develop UI
without backend access — but auth flows need them populated.

If `Env.supabaseUrl` or `Env.mapboxAccessToken` throws, the user forgot to
copy `.env.example` → `.env`, or didn't fill values.

---

## Deferred (do NOT spend time on these yet)

- Apple Developer account ($99/y) — only when we ship TestFlight (month 2–3)
- Google Play Console ($25 once) — only when we ship Internal Testing
- Firebase / FCM push notifications — only when we wire push (month 2–3)
- Mapbox iOS/Android native config — only when we build the Map feature
- Creator Wallet / Influence Agreement cash features — **LEGAL BLOCKER**:
  SAMA payment institution licence (KSA) / UAE Central Bank e-money licence
  required before development. Confirm with legal counsel first.

---

## When in doubt

1. Check `lib/core/theme/` for tokens before introducing new colours/spacing.
2. Check `pubspec.yaml` before adding a new dependency — we deliberately
   kept it lean.
3. Ask Mohammad about product behaviour — don't invent BRD spec.
4. Read the existing Splash screen for the established animation/composition
   pattern before building new screens.
