# Program Plan

## 2 Minute Calm — iOS App

> **Template Version:** 2.0
> **Last Updated:** March 2026
> **Status:** `Active`

-----

## 1. Build Phases

The program is structured into 10 sequential build steps. Each step produces a committed file in the repo.

|Step|Deliverable                                 |File                       |Est. Time|Status|
|----|--------------------------------------------|---------------------------|---------|------|
|1   |Data model — 3 mindfulness modes            |`ModeModel.swift`          |30 min   |✅ Done|
|2   |Home screen — mode selector UI              |`ContentView.swift`        |1 hr     |✅ Done|
|3   |Timer logic — session state machine         |`SessionViewModel.swift`   |1 hr     |✅ Done|
|4   |Pre-session screen — cue preview + countdown|`PreSessionView.swift`     |20 min   |⏳ Next|
|5   |Session screen — breathing orb + cues       |`SessionView.swift`        |30 min   |⬜     |
|6   |Completion screen — streak counter          |`CompletionView.swift`     |20 min   |⬜     |
|7   |Daily notification — mindful nudge          |`NotificationManager.swift`|15 min   |⬜     |
|8   |App entry point — wires everything          |`TwoMinuteCalmApp.swift`   |10 min   |⬜     |
|9   |End-to-end wiring + navigation test         |All files                  |20 min   |⬜     |
|10  |README update + repo cleanup                |`README.md`                |15 min   |⬜     |

**Total remaining: ~130 minutes**

-----

## 2. File Structure

```
TwoMinuteCalm/
├── TwoMinuteCalmApp.swift              # App entry point
├── ContentView.swift                   # Home screen (mode selector)
├── Models/
│   └── ModeModel.swift                 # Enum — 3 mindfulness modes
├── ViewModels/
│   └── SessionViewModel.swift          # Timer + session state logic
├── Views/
│   ├── PreSessionView.swift            # Cue preview + begin button
│   ├── SessionView.swift               # 2-min guided session screen
│   └── CompletionView.swift            # End screen + streak display
└── Helpers/
    └── NotificationManager.swift       # Daily local push notification
```

-----

## 3. Step-by-Step Build Plan

### Step 1 — ModeModel.swift ✅

**Goal:** Define the 3 app modes as a Swift enum with associated metadata.

**Concepts covered:**

- Swift enums with raw values
- Computed properties per case
- `Color(hex:)` extension
- `cueInterval` per mode (Breathe/StandUp: 4s · Meditate: 15s)

**Acceptance criteria:**

- [x] Enum `CalmMode` with 3 cases: `.breathe`, `.meditate`, `.standUp`
- [x] Each case has: `title`, `icon`, `color`, `iconBackground`, `cues`, `cueInterval`, `preSessionDescription`
- [x] Forest Stillness hex colors applied
- [x] `Color(hex:)` extension included

-----

### Step 2 — ContentView.swift ✅

**Goal:** Home screen showing app name, streak badge, and 3 mode cards.

**Concepts covered:**

- VStack / HStack / ZStack layouts
- NavigationStack and NavigationLink
- ForEach with custom card views
- `@AppStorage` for streak display
- Extracted subviews: `HeroSection`, `StreakPill`, `ModeCard`, `NotificationLink`

**Acceptance criteria:**

- [x] 3 mode cards render with correct icon, title, and color
- [x] Tapping a card navigates to `PreSessionView`
- [x] Streak count visible on home screen
- [x] Forest Stillness palette applied
- [x] Fraunces + DM Sans fonts applied

-----

### Step 3 — SessionViewModel.swift ✅

**Goal:** Timer logic that counts down 2 minutes and cycles through cue text phases.

**Concepts covered:**

- `ObservableObject` and `@Published`
- `Timer.publish` with Combine
- `AnyCancellable` for timer management
- State machine: `idle → countdown → running → complete`
- `weak self` to prevent memory leaks

**Acceptance criteria:**

- [x] 3-second countdown before session starts
- [x] Timer counts down from 120 seconds
- [x] Cue text cycles based on `mode.cueInterval`
- [x] `sessionState` publishes `.complete` at 0
- [x] `endSession()` cancels timer cleanly

-----

### Step 4 — PreSessionView.swift ⏳ Next

**Goal:** Mode preview screen shown before session starts. Lets users read all cues before closing their eyes.

**Concepts covered:**

- `@StateObject` initialization with mode parameter
- List rendering with `ForEach`
- Navigation to `SessionView` via button action
- Passing `SessionViewModel` as `@StateObject` down to `SessionView`

**Acceptance criteria:**

- [ ] Mode tag, icon and title displayed correctly
- [ ] `preSessionDescription` text shown
- [ ] All cues listed with dot indicators
- [ ] “Begin Session” triggers `viewModel.startCountdown()`
- [ ] Countdown (3, 2, 1) displayed as overlay before session
- [ ] “Go Back” navigates back to home

-----

### Step 5 — SessionView.swift

**Goal:** Full-screen animated session with breathing orb, countdown timer and cycling cue text.

**Concepts covered:**

- `withAnimation` and `.animation(.easeInOut)`
- `scaleEffect` for breathing orb pulse
- `@ObservedObject` to watch `SessionViewModel`
- `onChange` to detect session completion
- Navigation to `CompletionView` on complete

**Acceptance criteria:**

- [ ] Orb animates expand/contract continuously
- [ ] Timer display counts down in `M:SS` format
- [ ] Cue text fades and updates per `cueInterval`
- [ ] Progress bar fills left to right over 2 minutes
- [ ] Navigates to `CompletionView` when `sessionState == .complete`
- [ ] “End” button triggers `endSession()` and returns home

-----

### Step 6 — CompletionView.swift

**Goal:** End screen showing completion message, updated streak and share button.

**Concepts covered:**

- `@AppStorage` for persistent streak
- Date comparison logic for daily streak increment
- `ShareLink` for native iOS share sheet
- Entry animation with `.popIn` effect

**Acceptance criteria:**

- [ ] Check icon animates in on appear
- [ ] Streak increments once per calendar day
- [ ] Streak resets if a day is missed
- [ ] “Back to Home” navigates to root
- [ ] Share button opens native iOS share sheet

-----

### Step 7 — NotificationManager.swift

**Goal:** Schedule a daily local notification at 9:00 AM.

**Concepts covered:**

- `UNUserNotificationCenter`
- Requesting notification permissions on first launch
- Scheduling a repeating daily calendar trigger

**Acceptance criteria:**

- [ ] Permission request shown on first launch
- [ ] Notification fires daily at 9:00 AM
- [ ] Notification title: “Your 2 minutes are waiting”
- [ ] Notification body: “Take your daily reset. You’ve got this.”

-----

### Step 8 — TwoMinuteCalmApp.swift

**Goal:** App entry point — initializes the app and triggers notification setup.

**Concepts covered:**

- `@main` App protocol
- `WindowGroup` scene
- Calling `NotificationManager` on launch

**Acceptance criteria:**

- [ ] App launches to `ContentView`
- [ ] `NotificationManager.requestPermission()` called on first launch

-----

### Step 9 — End-to-End Wiring + Test

**Goal:** Verify the full user flow works without errors in Swift Playgrounds.

**Flow to test:**

```
Home → tap mode → PreSessionView → Begin
→ Countdown (3,2,1) → SessionView (2 min)
→ CompletionView → streak increments
→ Back to Home
```

**Acceptance criteria:**

- [ ] Full flow completes without crash
- [ ] Streak increments correctly
- [ ] All 3 modes work end to end
- [ ] Notification permission prompt appears on first launch

-----

### Step 10 — README + Repo Cleanup

**Goal:** Update README to reflect completed app and clean up file structure.

**Acceptance criteria:**

- [ ] README updated with app description, screenshots, and build steps
- [ ] File structure matches actual repo
- [ ] All prototype files moved to `prototype/` folder

-----

## 4. Commit Convention

```
feat: add ModeModel with 3 mindfulness modes
feat: add ContentView home screen with mode cards
feat: add SessionViewModel timer and state logic
feat: add PreSessionView cue preview and countdown
feat: add SessionView with breathing orb animation
feat: add CompletionView with streak tracking
feat: add NotificationManager daily reminder
feat: add TwoMinuteCalmApp entry point
fix: wire end-to-end navigation and test full flow
docs: update README and clean up repo structure
```

-----

## 5. Progress Tracker

|Step      |Focus                      |Status       |
|----------|---------------------------|-------------|
|Steps 1–3 |Model + Home + Timer       |✅ Complete   |
|Step 4    |Pre-Session screen         |⏳ In Progress|
|Steps 5–6 |Session + Completion       |⬜ Pending    |
|Steps 7–8 |Notifications + Entry point|⬜ Pending    |
|Steps 9–10|Wiring, test, README       |⬜ Pending    |

-----

## 6. Design Decisions (Frozen)

|Decision          |Detail                                              |
|------------------|----------------------------------------------------|
|Color palette     |Forest Stillness — see `ui-prototype-changelog.md`  |
|Fonts             |Fraunces (display) + DM Sans (body)                 |
|Icons             |SF Symbols — `wind`, `circle.circle`, `figure.stand`|
|Cue intervals     |Breathe: 4s · Meditate: 15s · Stand Up: 4s          |
|Session duration  |120 seconds (2 minutes)                             |
|Countdown duration|3 seconds                                           |
|Streak persistence|`@AppStorage` via `UserDefaults`                    |
|Notification time |9:00 AM daily                                       |

-----

## 7. Open Items

|#|Item                                                 |Owner |Status|
|-|-----------------------------------------------------|------|------|
|1|Confirm Swift Playgrounds setup on iPhone            |Balaji|⬜     |
|2|Decide if Fraunces needs to be bundled as custom font|Balaji|⬜     |
|3|Confirm notification default time (currently 9:00 AM)|Balaji|⬜     |

-----

*Update this plan after each completed step.*
