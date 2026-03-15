# 2 Minute Calm

> A minimal SwiftUI mindfulness app. Pick a reset mode, breathe for 2 minutes, build a daily streak.

![Status](https://img.shields.io/badge/status-in%20development-green)
![Platform](https://img.shields.io/badge/platform-iOS-lightgrey)
![Language](https://img.shields.io/badge/language-Swift-orange)
![Framework](https://img.shields.io/badge/framework-SwiftUI-blue)
![License](https://img.shields.io/badge/license-MIT-green)

-----

## The Idea

Most mindfulness apps are too heavy. Too many features, too much commitment, too long.

**2 Minute Calm** has one promise — a 2-minute reset that fits into any gap in your day. No account. No subscription. No onboarding. Open the app, pick a mode, and go.

-----

## The App

### 3 Reset Modes

|Mode          |Experience                                            |
|--------------|------------------------------------------------------|
|🌬️ **Breathe** |Animated breathing orb — inhale, hold, exhale cycles  |
|🧘 **Meditate**|Spaced focus prompts — read once, then close your eyes|
|🧍 **Stand Up**|Guided micro-movement — stretch, roll, reset          |

### 6 Screens

```
Home → Pre-Session → Countdown → Session → Completion → (Notification)
```

|Screen          |Purpose                                         |
|----------------|------------------------------------------------|
|**Home**        |Mode selector with streak badge                 |
|**Pre-Session** |Read all cues before starting — eyes-closed safe|
|**Countdown**   |3-second buffer before session begins           |
|**Session**     |Live timer + breathing orb + cycling cue text   |
|**Completion**  |Streak update + share moment                    |
|**Notification**|Daily nudge at 4 key moments                    |

### Daily Ritual Loop

```
Morning notification (8:00 AM)
        ↓
Open app → pick mode
        ↓
2-minute guided session
        ↓
Completion → streak increments
        ↓
Share or return home
```

-----

## Design

### Color Palette — Forest Stillness

|Token     |Hex      |Usage              |
|----------|---------|-------------------|
|Background|`#F2F5F0`|App background     |
|Surface   |`#FFFFFF`|Cards              |
|Primary   |`#3D6B4F`|Buttons, tags      |
|Accent    |`#7FB08A`|Orb, progress bar  |
|Soft      |`#C8DDD0`|Borders, icon fills|
|Text      |`#1E2E23`|Primary text       |
|Muted     |`#7A8F80`|Secondary text     |

### Typography

|Role   |Font             |Usage                       |
|-------|-----------------|----------------------------|
|Display|SF Serif (system)|App name, timer, titles     |
|Body   |SF Pro (system)  |Cards, descriptions, buttons|

### Icons

Custom SF Symbol selection — no emoji used anywhere in the app.

|Mode    |SF Symbol      |
|--------|---------------|
|Breathe |`wind`         |
|Meditate|`circle.circle`|
|Stand Up|`figure.stand` |

-----

## Tech Stack

|Layer        |Technology                                 |
|-------------|-------------------------------------------|
|Language     |Swift 5.9                                  |
|UI Framework |SwiftUI                                    |
|State        |`@Published`, `@StateObject`, `@AppStorage`|
|Timer        |`Combine` — `Timer.publish`                |
|Persistence  |`UserDefaults` via `@AppStorage`           |
|Notifications|`UNUserNotificationCenter`                 |
|IDE          |Built entirely on iPhone via GitHub        |

-----

## File Structure

```
TwoMinuteCalm/
├── TwoMinuteCalmApp.swift          # App entry point
├── ContentView.swift               # Home screen
├── Models/
│   └── ModeModel.swift             # CalmMode enum + Color(hex:) extension
├── ViewModels/
│   └── SessionViewModel.swift      # Timer, state machine, cue cycling
├── Views/
│   ├── PreSessionView.swift        # Cue preview + countdown
│   ├── SessionView.swift           # Breathing orb + live session
│   └── CompletionView.swift        # Streak + share
└── Helpers/
    └── NotificationManager.swift   # 4 daily local notifications
```

-----

## Architecture

The app follows **MVVM** — the standard pattern for SwiftUI.

```
ModeModel (data)
      ↓
SessionViewModel (logic + state)
      ↓
Views (UI reacts to published state)
```

### Session State Machine

```
idle → countdown → running → complete
         ↑                      ↓
         └──── endSession() ────┘
```

### Streak Logic

```
On completion:
  if lastDate == today    → no change (already done today)
  if lastDate == yesterday → streak + 1
  else                    → reset to 1
```

-----

## Notifications

4 daily local notifications — no server, no push certificates needed.

|Time    |Title            |Body                                      |
|--------|-----------------|------------------------------------------|
|8:00 AM |Good morning.    |Start your day with 2 minutes of calm.    |
|12:30 PM|Midday reset.    |Step away for 2 minutes. You’ve earned it.|
|5:00 PM |Wind down time.  |Take 2 minutes before the evening rush.   |
|9:00 PM |Before you sleep.|End your day with 2 minutes of stillness. |

-----

## Prototype

The UI was designed and frozen before any Swift code was written.

|Artifact                                |Location                             |
|----------------------------------------|-------------------------------------|
|Interactive HTML prototype (v3 frozen)  |`prototype/v3-frozen.html`           |
|UI changelog — defects, fixes, decisions|`prototype/ui-prototype-changelog.md`|

**Design decisions frozen:**

- Forest Stillness color palette
- SF system serif + SF Pro fonts
- Custom SF Symbol icon set
- Pre-session screen to solve eyes-closed UX problem
- Meditate cue interval: 15 seconds (vs 4 for other modes)

-----

## Project Docs

|Document             |Location                       |
|---------------------|-------------------------------|
|Program Charter      |`docs/program-charter.md`      |
|Program Plan         |`docs/program-plan.md`         |
|Architecture Overview|`docs/architecture-overview.md`|
|Product Description  |`docs/product-description.md`  |

-----

## Status & Roadmap

### Current — v1.0

- [x] All 8 Swift files written
- [x] UI prototype designed and frozen
- [x] MVVM architecture implemented
- [x] Streak persistence
- [x] 4 daily notifications
- [ ] Device testing (requires iPad or Mac)
- [ ] App Store submission

### v1.1 — Next

- [ ] Haptic feedback on breathing orb pulse
- [ ] Ambient audio per mode
- [ ] Home screen widget

### v2.0 — Future

- [ ] HealthKit — log mindfulness minutes
- [ ] Apple Watch companion
- [ ] App Store submission

-----

## About This Project

This app was built entirely from an iPhone — no Mac, no desktop, no paid tools.

Every file was written in GitHub’s mobile editor, version controlled with branches and pull requests, and designed using a hand-coded HTML prototype.

Built as part of a personal iOS learning journey alongside my TPM portfolio at [ibalajisivarajan](https://github.com/ibalajisivarajan).

-----

## Related Repos

- [technical-program-manager-toolkit](https://github.com/ibalajisivarajan/technical-program-manager-toolkit) — TPM templates and frameworks
- [tpm-decision-log](https://github.com/ibalajisivarajan/tpm-decision-log) — Architecture Decision Records explorer

-----

*Built with focus. Two minutes at a time.*
