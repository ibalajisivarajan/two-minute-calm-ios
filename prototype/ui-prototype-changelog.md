# UI Prototype Change Log
## 2 Minute Calm — Defects, Fixes & Design Decisions

> **Document Owner:** Balaji Sivarajan
> **Last Updated:** March 2026
> **Prototype Status:** Frozen at v3

---

## Version Overview

| Version | Format | Screens | Status |
|---------|--------|---------|--------|
| v1 | HTML | Home, Session, Completion, Notification | Superseded |
| v2 | HTML | Home, Session, Completion, Notification | Superseded |
| v3 | HTML | Home, Pre-Session, Countdown, Session, Completion, Notification | **Frozen ✅** |

---

## Design Decisions

### DD-001 — Color Palette: Forest Stillness
| Field | Detail |
|-------|--------|
| **Decision** | Forest Stillness selected as the app palette |
| **Version applied** | v2 onwards |

| Token | Hex | Usage |
|-------|-----|-------|
| `--bg` | `#F2F5F0` | App background |
| `--surface` | `#FFFFFF` | Cards and surfaces |
| `--primary` | `#3D6B4F` | Buttons, tags, active states |
| `--accent` | `#7FB08A` | Orb gradient, progress bar |
| `--soft` | `#C8DDD0` | Borders, icon backgrounds |
| `--text` | `#1E2E23` | Primary text |
| `--muted` | `#7A8F80` | Secondary text, labels |

**Rationale:** Grounded, natural, breathable feel. Matches the mindfulness positioning of the app. Avoided blues and purples which feel clinical or generic.

---

### DD-002 — Font Pairing: Fraunces + DM Sans
| Field | Detail |
|-------|--------|
| **Decision** | Fraunces (display) + DM Sans (body) selected |
| **Version applied** | v2 onwards |

| Role | Font | Weight | Usage |
|------|------|--------|-------|
| Display | Fraunces | 300, 400 | App name, timer, completion title, lock screen time |
| Body | DM Sans | 300, 400, 500, 600 | Mode titles, descriptions, buttons, labels |

**Rationale:** Fraunces brings warmth and character to the display moments without feeling precious. DM Sans keeps body text clean and readable at small sizes. Together they feel premium but approachable.

---

### DD-003 — Icons: Custom SVG (no emojis)
| Field | Detail |
|-------|--------|
| **Decision** | All emojis replaced with custom hand-drawn SVG icons |
| **Version applied** | v3 |

| Icon | SVG Design | Used in |
|------|-----------|---------|
| App logo | Leaf outline with stem vein | Home hero, notification |
| Breathe | Three flowing wind lines | Mode card, session orb |
| Meditate | Solid dot + two concentric rings (dashed outer) | Mode card, session orb |
| Stand Up | Circle head + torso + arms + legs | Mode card, session orb |
| Streak | Teardrop flame outline | Streak pill |
| Notification | Bell with arc and clapper | Notification link |
| Share | Arrow pointing up from box | Completion screen |
| Chevron | Single right-pointing angle | Mode card right edge |

**Rationale:** Emojis rendered inconsistently across devices and felt visually immature for a calm, minimal app. Custom SVGs match the palette color system and scale cleanly at all sizes.

---

### DD-004 — Mode-specific icon accent colors
| Field | Detail |
|-------|--------|
| **Decision** | Each mode card uses a distinct icon background and stroke color |
| **Version applied** | v3 |

| Mode | Icon background | Icon color |
|------|----------------|-----------|
| Breathe | `#E4F0E8` (light green) | `#3D6B4F` (primary green) |
| Meditate | `#E3EDF5` (light blue) | `#4A7FA5` (calm blue) |
| Stand Up | `#F5EDE3` (light peach) | `#B07D62` (warm terracotta) |

**Rationale:** Gives each mode a distinct identity within the same calm visual system. Helps users quickly associate a color with their preferred mode over time.

---

## UI Defect Log

### UI-DEF-001 — Meditation eyes-closed UX failure
| Field | Detail |
|-------|--------|
| **ID** | UI-DEF-001 |
| **Found in** | v1 |
| **Fixed in** | v3 |
| **Screen** | Session — Meditate mode |
| **Severity** | High |

**Problem:**
Session started immediately on mode tap. First cue text read "Close your eyes." — subsequent cues were unreachable without reopening eyes.

**Fix:**
- Added a **Pre-Session screen** between mode selection and session start
- Pre-Session screen lists all cues so users can read them before beginning
- Meditate mode cue interval changed from 4 seconds to 15 seconds — spaced far enough apart that users do not need to watch the screen
- A 3-second **countdown screen** added between Pre-Session and Session to give users a moment to close their eyes and settle

**Screens added:** Pre-Session, Countdown

---

### UI-DEF-002 — Emoji icons inconsistent and visually immature
| Field | Detail |
|-------|--------|
| **ID** | UI-DEF-002 |
| **Found in** | v1, v2 |
| **Fixed in** | v3 |
| **Screen** | All screens |
| **Severity** | Medium |

**Problem:**
All icons were rendered using emoji characters (🌬️ 🧘 🧍 🔔 🔥). Emojis render differently across devices and OS versions, felt visually mismatched with the refined Forest Stillness palette, and appeared childish relative to the calm, minimal app positioning.

**Fix:**
All emoji replaced with custom SVG icons drawn to match the app's visual system. Icons use `currentColor` for stroke so they adapt to the palette color tokens.

---

## Screen Inventory — v3 (Frozen)

| # | Screen | Purpose | Key UI Elements |
|---|--------|---------|----------------|
| 1 | **Home** | Entry point — mode selection | App logo, streak pill, 3 mode cards, notification link |
| 2 | **Pre-Session** | Mode preview before starting | Mode tag, cue list, Begin + Back buttons |
| 3 | **Countdown** | 3-second transition buffer | Large animated number, "Get ready" label |
| 4 | **Session** | Active 2-minute guided experience | Timer, breathing orb animation, cue text, progress bar |
| 5 | **Completion** | End state — streak and share | Check icon, streak card, Back to Home + Share buttons |
| 6 | **Notification** | Lock screen notification preview | Lock time, notification banner, back link |

---

## What is Frozen

The following are locked for SwiftUI implementation:

- ✅ Color palette — Forest Stillness (6 tokens)
- ✅ Typography — Fraunces (display) + DM Sans (body)
- ✅ Icons — Custom SVG set (8 icons)
- ✅ Screen count and flow — 6 screens
- ✅ Mode cue intervals — Breathe/Stand Up: 4s · Meditate: 15s
- ✅ Countdown duration — 3 seconds
- ✅ Streak display — numeric with "days in a row" label
- ✅ Progress bar — linear fill, left to right, 3px height

---

*This document records all UI decisions and defects across prototype versions. No further changes will be made to the prototype. SwiftUI implementation begins from v3.*
