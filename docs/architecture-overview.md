# Architecture Overview

## 2 Minute Calm — iOS App

> **Template Version:** 1.0  
> **Last Updated:** March 2026  
> **Document Owner:** Balaji Sivarajan

-----

## 1. Summary

2 Minute Calm is a lightweight, fully offline SwiftUI iOS app. It uses no backend, no external APIs, and no third-party dependencies. All state is managed on-device using native iOS frameworks.

-----

## 2. Architecture Pattern

The app follows **MVVM (Model-View-ViewModel)** — the standard pattern for SwiftUI apps.

```
┌─────────────────────────────────────────────┐
│                   USER                       │
└────────────────────┬────────────────────────┘
                     │ taps / interacts
┌────────────────────▼────────────────────────┐
│               VIEW LAYER                     │
│  ContentView → SessionView → CompletionView  │
└────────────────────┬────────────────────────┘
                     │ observes / binds
┌────────────────────▼────────────────────────┐
│            VIEWMODEL LAYER                   │
│          SessionViewModel                    │
│   (Timer logic, phase state, completion)     │
└────────────────────┬────────────────────────┘
                     │ reads
┌────────────────────▼────────────────────────┐
│              MODEL LAYER                     │
│   ModeModel (enum: Breathe, Meditate,        │
│   Stand Up — with cues, colors, icons)       │
└─────────────────────────────────────────────┘
```

-----

## 3. Component Breakdown

### Views

|View            |Responsibility                                                               |
|----------------|-----------------------------------------------------------------------------|
|`ContentView`   |Home screen — displays app title, streak badge, 3 mode selector cards        |
|`SessionView`   |Active session — animated breathing circle, countdown timer, cycling cue text|
|`CompletionView`|End state — completion message, streak update, share button                  |

### ViewModel

|ViewModel         |Responsibility                                                                 |
|------------------|-------------------------------------------------------------------------------|
|`SessionViewModel`|Owns `Timer`, manages countdown, cycles cue text phases, publishes `isComplete`|

### Model

|Model      |Responsibility                                                                                 |
|-----------|-----------------------------------------------------------------------------------------------|
|`ModeModel`|Swift enum defining 3 modes — each with title, SF Symbol icon, accent color, and cue text array|

### Helpers

|Helper               |Responsibility                                                         |
|---------------------|-----------------------------------------------------------------------|
|`NotificationManager`|Requests permission, schedules daily `UNUserNotificationCenter` trigger|

-----

## 4. Data Flow

```
User selects mode (ContentView)
        │
        ▼
SessionView initializes SessionViewModel with selected ModeModel
        │
        ▼
SessionViewModel starts Timer (120 sec countdown)
        │
        ├── Every tick → updates remainingTime (published)
        ├── Every 4 sec → cycles cueText (published)
        └── At 0 → sets isComplete = true (published)
                        │
                        ▼
              SessionView navigates to CompletionView
                        │
                        ▼
              CompletionView reads/writes streak via @AppStorage
```

-----

## 5. State Management

|State                |Mechanism                                |Scope       |
|---------------------|-----------------------------------------|------------|
|Selected mode        |`NavigationStack` path / passed parameter|Session only|
|Timer countdown      |`@Published` in `SessionViewModel`       |Session only|
|Current cue text     |`@Published` in `SessionViewModel`       |Session only|
|Session complete flag|`@Published` in `SessionViewModel`       |Session only|
|Daily streak count   |`@AppStorage` (UserDefaults)             |Persistent  |
|Last completion date |`@AppStorage` (UserDefaults)             |Persistent  |

-----

## 6. Persistence

No database. All persistence is handled via **UserDefaults** through `@AppStorage`:

|Key                   |Type    |Purpose                                         |
|----------------------|--------|------------------------------------------------|
|`streak_count`        |`Int`   |Number of consecutive days completed            |
|`last_completion_date`|`String`|ISO date of last session — used for streak logic|

-----

## 7. Notifications

|Property  |Value                                  |
|----------|---------------------------------------|
|Type      |Local push notification                |
|Framework |`UNUserNotificationCenter`             |
|Trigger   |Daily calendar trigger (user-set time) |
|Permission|Requested on first app launch          |
|Content   |Title: *“Your 2 minutes are waiting 🌿”*|

-----

## 8. Tech Stack

|Layer          |Technology                             |Notes                            |
|---------------|---------------------------------------|---------------------------------|
|Language       |Swift 5.9+                             |Modern Swift, no Obj-C           |
|UI Framework   |SwiftUI                                |Declarative, animation-native    |
|State          |`@State`, `@StateObject`, `@AppStorage`|No external state library        |
|Persistence    |UserDefaults                           |Lightweight, on-device only      |
|Notifications  |UNUserNotificationCenter               |Native iOS, no push server needed|
|IDE            |Swift Playgrounds 4                    |Free, iPhone-compatible          |
|Version Control|GitHub                                 |Portfolio hosting                |

-----

## 9. Constraints & Decisions

|Constraint          |Decision                              |Rationale                                   |
|--------------------|--------------------------------------|--------------------------------------------|
|No Mac / desktop    |Swift Playgrounds 4 on iPhone         |Free, fully capable for SwiftUI             |
|No paid tools       |100% native iOS frameworks            |UserDefaults, UNUserNotification — zero cost|
|No backend          |Offline-only, UserDefaults persistence|Simplicity; no auth/API complexity          |
|No external packages|Pure SwiftUI + Foundation             |Keeps build reproducible and dependency-free|

-----

## 10. Future Architecture Considerations (Phase 2)

- **Haptic feedback** — `UIImpactFeedbackGenerator` for breathing pulse
- **Audio** — `AVFoundation` ambient sound per mode
- **HealthKit** — Log mindfulness minutes to Apple Health
- **iCloud sync** — `NSUbiquitousKeyValueStore` for cross-device streak

-----

*This document reflects the current planned architecture. Update as implementation decisions evolve.*
