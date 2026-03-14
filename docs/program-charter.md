# Program Charter

## 2 Minute Calm — iOS App

> **Template Version:** 1.0  
> **Last Updated:** March 2026  
> **Status:** `Draft` | `In Review` | `Approved`

-----

## 1. Program Overview

|Field            |Details         |
|-----------------|----------------|
|**Program Name** |2 Minute Calm   |
|**Platform**     |iOS (SwiftUI)   |
|**Program Owner**|Balaji Sivarajan|
|**Start Date**   |*[Insert Date]* |
|**Target Launch**|*[Insert Date]* |
|**Current Phase**|Planning        |

-----

## 2. Problem Statement

> What problem does this app solve? Why does it matter?

Users often feel overwhelmed during the day but lack a quick, frictionless way to reset. Existing mindfulness apps are feature-heavy and require too much commitment. There is no dead-simple, sub-2-minute reset tool that fits into any gap in the day.

-----

## 3. Vision & Goals

### Vision

A calm, focused 2-minute reset that becomes a daily ritual users look forward to.

### Goals

- Deliver a working SwiftUI app with 3 mindfulness modes (Breathe, Meditate, Stand Up)
- Build a streak-based daily ritual loop to drive retention
- Keep the experience under 3 screens with zero onboarding friction
- Learn core iOS development concepts through hands-on building

-----

## 4. Scope

### In Scope

- Home screen with 3 mode selector cards
- 2-minute guided session screen per mode
- Completion screen with streak counter
- Daily local push notification
- Streak persistence via UserDefaults

### Out of Scope

- Backend / cloud sync
- User accounts or authentication
- Audio / haptic feedback (Phase 2)
- App Store submission (Phase 2)

-----

## 5. Success Metrics

|Metric                       |Target           |
|-----------------------------|-----------------|
|App launches without crash   |100%             |
|All 3 modes functional       |✅                |
|Streak tracking accurate     |✅                |
|Notification delivered daily |✅                |
|Code committed per build step|1 commit per step|

-----

## 6. Stakeholders

|Role           |Name            |Responsibility             |
|---------------|----------------|---------------------------|
|Developer / TPM|Balaji Sivarajan|Design, build, ship        |
|Advisor (AI)   |Claude          |Step-by-step build guidance|

-----

## 7. Key Milestones

|Milestone                  |Target Date|Status|
|---------------------------|-----------|------|
|Repo created & README live |*[Date]*   |⬜     |
|ModeModel.swift complete   |*[Date]*   |⬜     |
|ContentView (Home) complete|*[Date]*   |⬜     |
|SessionViewModel + Timer   |*[Date]*   |⬜     |
|SessionView with animation |*[Date]*   |⬜     |
|CompletionView + streak    |*[Date]*   |⬜     |
|NotificationManager live   |*[Date]*   |⬜     |
|Full app working end-to-end|*[Date]*   |⬜     |

-----

## 8. Risks & Mitigations

|Risk                         |Likelihood|Impact|Mitigation                                |
|-----------------------------|----------|------|------------------------------------------|
|SwiftUI animation complexity |Medium    |Medium|Start with simple scale animation, iterate|
|iPhone-only build constraints|Low       |Low   |Swift Playgrounds 4 supports full SwiftUI |
|Scope creep (adding features)|High      |Medium|Strict adherence to In Scope definition   |

-----

## 9. Dependencies

|Dependency              |Type     |Notes                              |
|------------------------|---------|-----------------------------------|
|Swift Playgrounds 4     |Tool     |Free, iPhone-compatible IDE        |
|GitHub (iPhone app)     |Tool     |Version control & portfolio hosting|
|UserDefaults            |Framework|Native iOS — no external dependency|
|UNUserNotificationCenter|Framework|Native iOS — no external dependency|

-----

## 10. TPM Notes & Decisions

> Use this section to log key decisions, pivots, and rationale as the program progresses.

|Date    |Decision                |Rationale                                   |
|--------|------------------------|--------------------------------------------|
|*[Date]*|Chose SwiftUI over UIKit|Modern, declarative, better for learning    |
|*[Date]*|3 modes vs 1            |Increases reuse value and viral surface area|

-----

*This charter is a living document. Update as decisions are made and milestones are completed.*
