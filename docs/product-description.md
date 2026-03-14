# Product Description

## 2 Minute Calm — iOS App

> **Template Version:** 1.0  
> **Last Updated:** March 2026  
> **Document Owner:** Balaji Sivarajan

-----

## 1. Product Summary

**2 Minute Calm** is a free, offline iOS mindfulness app that gives users a fast, frictionless mental reset in exactly 2 minutes. Users choose from 3 guided modes — breathing, meditation, or movement — and are guided through a calming session with animated cues and gentle prompts.

The app is designed to become a daily ritual: one notification, one tap, two minutes, done.

-----

## 2. The Problem

|Pain Point                               |Detail                                                                        |
|-----------------------------------------|------------------------------------------------------------------------------|
|Existing mindfulness apps are too heavy  |Calm, Headspace, etc. require subscription, onboarding, and 10–20 min sessions|
|Users feel overwhelmed but won’t “commit”|A 2-minute reset is psychologically achievable for anyone                     |
|No dead-simple reset tool exists         |Most apps add complexity instead of removing it                               |

-----

## 3. The Solution

A single-purpose app with one promise: **2 minutes to feel calmer.**

- No account required
- No subscription
- No onboarding
- Opens instantly to a mode selector
- Guides you through exactly 2 minutes
- Shows your streak and lets you share your moment

-----

## 4. Target Users

|Persona                         |Description                                                                 |
|--------------------------------|----------------------------------------------------------------------------|
|**The Overwhelmed Professional**|Back-to-back meetings, needs a micro-reset between calls                    |
|**The Anxious Commuter**        |On transit, phone in hand, wants calm without headphones                    |
|**The Habit Builder**           |Wants to start a mindfulness practice but 10-min apps feel like too much    |
|**The Wellness Curious**        |Has heard about breathwork or meditation, wants to try it with no commitment|

-----

## 5. Core Features

### 5.1 Mode Selector (Home Screen)

Three clearly defined reset modes presented as tappable cards:

|Mode          |Icon                |Description                                            |
|--------------|--------------------|-------------------------------------------------------|
|🌬️ **Breathe** |wind                |Animated breathing circle — inhale, hold, exhale cycles|
|🧘 **Meditate**|figure.mind.and.body|Gentle focus prompt with soft countdown                |
|🧍 **Stand Up**|figure.stand        |Guided micro-movement prompts — stretch, roll, reset   |

### 5.2 Guided Session Screen

- Full-screen, distraction-free experience
- Soft animated visual matched to the selected mode
- Cycling cue text guides the user through the 2 minutes
- Countdown timer visible but non-intrusive

### 5.3 Completion Screen

- Warm completion message: *“You did it. Two minutes, all yours.”*
- Streak counter — consecutive daily completions
- Share button — generates a simple shareable card

### 5.4 Daily Reminder

- One daily local notification at a chosen time
- Notification copy: *“Your 2 minutes are waiting 🌿”*
- No spamming — one nudge per day, easily disabled

-----

## 6. User Journey

```
Daily notification arrives
        │
        ▼
User opens app → Home screen loads instantly
        │
        ▼
User taps a mode card (Breathe / Meditate / Stand Up)
        │
        ▼
2-minute guided session begins
        │
        ▼
Session completes → Completion screen
        │
        ▼
Streak updates → Optional share → Done
```

-----

## 7. Design Principles

|Principle                      |Implementation                                  |
|-------------------------------|------------------------------------------------|
|**Zero friction**              |No login, no onboarding, opens to action        |
|**Calm aesthetic**             |Soft whites and greens, minimal typography      |
|**One clear action per screen**|No competing CTAs                               |
|**Respect the user’s time**    |Exactly 2 minutes — no padding, no upsell       |
|**Ritual-worthy**              |Streak + completion card make it feel meaningful|

-----

## 8. Visual Design Direction

|Element        |Spec                                      |
|---------------|------------------------------------------|
|Primary color  |Soft green `#A8D5B5`                      |
|Background     |Off-white `#F8F9F5`                       |
|Text           |Dark charcoal `#2C2C2C`                   |
|Accent         |Warm sage `#7FB08A`                       |
|Typography     |SF Pro Rounded (system font)              |
|Animation style|Gentle ease-in-out, no jarring transitions|

-----

## 9. Success Criteria

|Metric                |Definition of Success                            |
|----------------------|-------------------------------------------------|
|Core loop functional  |All 3 modes complete a 2-min session end-to-end  |
|Streak works correctly|Increments once per day, resets if day is skipped|
|Notification delivered|Fires daily without manual trigger               |
|App is crash-free     |No crashes during normal session flow            |
|Portfolio ready       |Repo is public, README is clear, code is clean   |

-----

## 10. Out of Scope (v1)

- Audio / ambient soundscapes
- Haptic feedback
- iCloud sync or multi-device support
- Apple Watch companion app
- HealthKit integration
- App Store submission
- Analytics or usage tracking

-----

## 11. Roadmap (Future Phases)

|Phase|Feature                            |
|-----|-----------------------------------|
|v1.1 |Haptic feedback on breathing pulses|
|v1.2 |Ambient audio per mode             |
|v2.0 |HealthKit — log mindfulness minutes|
|v2.0 |Apple Watch companion app          |
|v3.0 |App Store submission               |

-----

*This document describes the intended product. Update as features are built and decisions are finalized.*
