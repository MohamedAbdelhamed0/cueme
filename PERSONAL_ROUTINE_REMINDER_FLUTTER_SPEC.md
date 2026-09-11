# Personal Routine Reminder — Flutter Product & Technical Specification

> **Status:** Implementation-ready specification  
> **Target:** Flutter mobile app for Android + iOS  
> **Primary use case:** Offline reminders for pills/medicines, vitamins, creams/skincare, supplements, and other personal routines  
> **Architecture:** Riverpod + layered architecture + local SQLite/Drift database  
> **Backend:** None. No Firebase, Supabase, login, or internet required for V1.

---

## 1. Product Summary

Build a small, polished, modern Flutter app that reminds the user to take or apply personal items such as:

- Pills / medicine
- Vitamins
- Supplements
- Creams
- Skincare products
- Eye drops
- Other custom routines

The user creates an item, chooses how many times per day it is needed, chooses the exact time for each reminder, and optionally records a short custom voice clip for that item.

Example:

- **Vitamin D**
  - 1 time/day
  - 09:00
  - Recorded voice: “Take your Vitamin D.”

- **Face cream**
  - 2 times/day
  - 08:00 and 22:30
  - Recorded voice: “Time for your face cream.”

Everything must work locally on the device.

The app should feel premium, clean, modern, friendly, and fast rather than looking like a medical enterprise application.

---

# 2. Core Product Principles

1. **Offline-first**
   - All data is local.
   - No account is needed.
   - No network is needed for normal operation.

2. **Fast entry**
   - Adding a reminder should take less than a minute.
   - Adding multiple daily times should be extremely easy.

3. **Reliable reminders**
   - Reminder scheduling is a core feature, not an afterthought.
   - Permission problems must be visible to the user.
   - Scheduling must be rebuilt when an item changes.

4. **Voice-first personalization**
   - Each routine can use a unique recorded voice clip.
   - The user can preview, replace, or remove the recording.

5. **Simple architecture**
   - Use strong separation of concerns.
   - Do not introduce Firebase, Supabase, GetX, BLoC, or `get_it`.
   - Riverpod is both state management and dependency injection.

6. **Modern UI/UX**
   - Material 3.
   - Large rounded cards.
   - Soft surfaces and subtle gradients.
   - Excellent light and dark modes.
   - Good typography and spacing.
   - Small, purposeful animations.
   - No clutter.

---

# 3. V1 Scope

## Required Features

### 3.1 Routine Items

The user can:

- Create an item.
- Edit an item.
- Archive an item.
- Delete an item.
- Enable or disable an item.
- Choose a category.
- Give it a name.
- Add optional instructions.
- Add optional dosage/application text.
- Pick an icon.
- Pick an accent color.
- Pick a start date.
- Optionally pick an end date.
- Choose days of the week.
- Add one or more reminder times per day.
- Record a custom reminder voice.
- Use the default/system sound instead of a voice recording.

### 3.2 Categories

Initial categories:

```text
pill
medicine
vitamin
supplement
cream
skincare
drops
custom
```

Each category should have:

- Icon
- Default action verb
- Suggested visual style

Examples:

```text
pill       -> Take
vitamin    -> Take
cream      -> Apply
skincare   -> Apply
drops      -> Use
custom     -> Do
```

Do not hardcode UI copy deeply into business logic.

---

# 4. Main Navigation

Use a bottom navigation bar with four destinations:

1. **Today**
2. **Routines**
3. **History**
4. **Settings**

Use an obvious add button/FAB from Today and Routines.

Recommended shell:

```text
Scaffold
 ├─ Body
 ├─ FloatingActionButton / centered add action
 └─ NavigationBar
     ├─ Today
     ├─ Routines
     ├─ History
     └─ Settings
```

Use `go_router` for navigation.

---

# 5. User Experience

## 5.1 Onboarding

Keep onboarding short.

### Screen 1 — Welcome

Message:

> Your routines, on time.

Explain:

- reminders stay on the device
- custom voice reminders are supported
- no account is required

CTA:

```text
Get Started
```

### Screen 2 — Notification Permission

Do not request permission immediately when the app launches.

Explain why notifications are needed first.

CTA:

```text
Enable Notifications
```

Show a secondary:

```text
Not Now
```

If denied, the app must still open and work, but Today should show a permission warning card.

### Screen 3 — Optional Microphone Permission

Do not request microphone permission until the user taps **Record voice** for the first time.

Therefore this onboarding screen can simply explain the feature; requesting the actual permission later is preferred.

---

# 6. Today Screen

The Today screen is the main home screen.

Recommended layout:

```text
SafeArea
  Header
    greeting / date
    settings/avatar-style icon optional

  Next Reminder Card
    icon
    item name
    instruction
    countdown
    scheduled time
    primary action if currently due

  Today's Progress
    completed / total

  Timeline
    08:00 Vitamin D
    10:30 Eye Drops
    14:00 Supplement
    22:30 Face Cream

  FAB: Add Routine
```

### States

Each occurrence can display:

```text
upcoming
due
done
snoozed
skipped
missed
```

Visual state must be immediately understandable.

Do not make the app visually alarming when something is missed. Use calm language.

---

# 7. Routines Screen

Display active routines as premium cards.

Each card:

- category icon
- title
- instruction/dosage
- number of times per day
- next time
- active toggle
- small voice indicator if custom recording exists
- overflow menu

Filters:

```text
All
Active
Archived
```

Optional category filter can be added later.

---

# 8. Add / Edit Routine Flow

Use one polished editor screen or a lightweight 3-step flow.

Recommended single-screen structure:

## Section A — What

Fields:

```text
Name*
Category*
Instructions
Dosage / amount
Icon
Color
```

Examples:

```text
Name: Vitamin C
Dosage: 1 tablet
Instructions: After breakfast
```

## Section B — When

Controls:

```text
Start date
End date (optional)
Days of week
Reminder times
```

Default selected days:

```text
Mon Tue Wed Thu Fri Sat Sun
```

### Adding Daily Times

The user should never have to type “times per day” as a separate value.

Instead:

- one selected time = once/day
- two selected times = twice/day
- three selected times = three times/day

The UI may show:

```text
2 times per day
```

derived from the number of enabled schedule rows.

Example:

```text
08:00   [remove]
22:30   [remove]

+ Add another time
```

This prevents contradictory data such as “3 times/day” with only two times selected.

## Section C — Reminder Sound

Sound options:

```text
Recorded voice
System/default sound
Silent + vibration
```

If **Recorded voice**:

```text
[ Hold/Tap to Record ]

Recording 00:08
waveform / animated level

[ Stop ]

Preview:
[ Play ] 00:08    [ Re-record ] [ Delete ]
```

Recommended maximum recording length:

```text
20 seconds
```

Hard maximum:

```text
29 seconds
```

This stays below Apple's 30-second custom notification sound limit.

Preferred recording format:

```text
Linear PCM WAV
```

This is simple to preview and compatible with Apple's supported custom notification sound formats.

## Section D — Reminder Behavior

Options:

```text
Vibration: on/off
Snooze: on/off
Snooze duration: 5 / 10 / 15 / 30 min
```

The default should be:

```text
Vibration: ON
Snooze: ON
Snooze duration: 10 minutes
```

## Save

On Save:

1. Validate.
2. Save DB changes in a transaction.
3. Save/move audio to its permanent location if needed.
4. Cancel stale scheduled notifications for this routine.
5. Generate/synchronize current schedules.
6. Show success UI.
7. Return to previous screen.

If scheduling fails, retain the routine data and show a clear warning rather than deleting user input.

---

# 9. Reminder / Alarm Behavior

This app has two concepts.

## 9.1 V1 — Reminder Mode

This is the required default.

A system local notification is scheduled at each configured time.

The notification includes:

```text
Title: Vitamin D
Body: 1 tablet • After breakfast
```

Possible actions:

```text
Done
Snooze
```

If action handling becomes unreliable on a specific platform/version, tapping the notification must open the reminder detail/ring screen where these actions are available.

### Recorded Voice

A short custom recording is used as the notification sound where the OS supports it reliably.

Fallback order:

```text
Recorded voice
    ↓ if unavailable
Selected built-in/system alarm sound
    ↓ if unavailable
Default notification sound + vibration
```

Never silently fail.

---

# 10. Platform-Specific Sound Strategy

This area must be abstracted behind a service.

Create:

```dart
abstract interface class ReminderScheduler {
  Future<void> initialize();
  Future<void> scheduleOccurrence(...);
  Future<void> scheduleRoutine(...);
  Future<void> cancelOccurrence(...);
  Future<void> cancelRoutine(...);
  Future<void> rescheduleAll();
  Future<ReminderPermissionState> getPermissionState();
}
```

The UI and repository layers must never contain Android/iOS scheduling code.

---

## 10.1 iOS Recorded Sound

Use `flutter_local_notifications`.

Apple local notification custom sounds:

- must already be on the device
- can be loaded from the app's `Library/Sounds` directory
- should use an Apple-supported format
- must be shorter than 30 seconds

Implementation approach:

1. Record to a temporary WAV file.
2. Validate duration.
3. Copy the final voice file to:

```text
<app Library directory>/Sounds/
```

4. Give it a stable unique filename such as:

```text
routine_<routineId>_<audioRevision>.wav
```

5. Schedule the local notification with that sound filename.

If the voice is replaced:

- create a new filename/revision
- reschedule the routine
- clean the old sound after no scheduled notification references it

Do not overwrite an active sound file in-place.

### iOS Limitation

Do not promise an Android-style endlessly looping full-screen alarm.

V1 should use a short custom local notification sound.

This is the correct cross-platform UX for a simple personal reminder app.

---

## 10.2 Android Recorded Sound

Primary V1 approach:

- use `flutter_local_notifications`
- use a unique Android notification channel when a different sound is needed
- Android 8+ locks sound/vibration settings to a notification channel after the channel is created

Therefore channel IDs must be versioned.

Example:

```text
routine_<routineId>_sound_<audioRevision>
```

If sound changes:

```text
routine_10_sound_1
```

becomes:

```text
routine_10_sound_2
```

Never reuse an existing channel ID with a different sound and expect Android to update it.

### Android URI Sound

Current `flutter_local_notifications` supports `UriAndroidNotificationSound`.

If using the user's recorded file as a channel sound:

- implement a small Android platform bridge only if required
- expose/provide a valid sound URI
- test it on real Samsung, Pixel, and Xiaomi devices
- do not request broad storage access just for app-owned audio
- keep a fallback to the system/default sound

If OEM behavior makes dynamic notification sound unreliable, keep notifications reliable and fall back to a default sound rather than failing the reminder.

---

# 11. Optional V1.1 — True Alarm Mode

Do **not** block V1 on this.

Add an optional stronger Android-only mode:

```text
Alarm mode
- ring/loop until stopped
- full-screen alarm UI where permitted
- recorded local file as ringtone
- snooze
- stop
```

The `alarm` Flutter package is a good candidate for Android because it provides native alarm scheduling, local audio playback, vibration, foreground-service behavior, full-screen intent support, volume handling, and snooze.

However:

- full-screen-intent permissions/policies need care
- device vendors may apply battery restrictions
- iOS cannot offer the exact same killed-app behavior
- therefore do not advertise identical “Clock app” behavior across both platforms

Keep the abstraction so this mode can be added without changing repositories or presentation logic.

---

# 12. Notification Scheduling Rules

## 12.1 Store Wall-Clock Time, Not Only DateTime

For recurring routines store:

```text
hour
minute
weekday set
startDate
endDate
```

Do not store only the next absolute timestamp as the source of truth.

Reason:

The user means:

> remind me at 8:00 AM

not:

> remind me every 86,400 seconds.

This also makes DST/timezone behavior easier to reason about.

## 12.2 Timezone

Use the `timezone` package for scheduled notification calculations.

Default behavior:

```text
Follow device local timezone.
```

If the user travels, an 08:00 routine should remain at 08:00 local time.

Whenever the app resumes:

- check whether timezone changed
- if changed, reschedule active routines

## 12.3 Start / End Date

A notification must not be scheduled:

- before `startDate`
- after `endDate`
- on an unselected weekday
- for an inactive/archived routine

## 12.4 Editing

Whenever any of these change:

```text
time
weekday
active state
start date
end date
sound
vibration
snooze config
routine deleted
```

run:

```text
cancelRoutine(routineId)
scheduleRoutine(routineId)
```

inside the application/controller flow.

## 12.5 Reconciliation

At startup and app resume:

```text
NotificationSyncService.reconcile()
```

It should verify that:

- active DB schedules have pending OS schedules
- deleted/inactive routines have no stale OS reminders
- timezone changes are applied
- permission state is refreshed

This function must be idempotent.

---

# 13. Android Permissions and Reliability

The app must handle the current Android permission model.

Potential permissions/features:

```text
POST_NOTIFICATIONS
SCHEDULE_EXACT_ALARM where applicable
VIBRATE
RECEIVE_BOOT_COMPLETED if required by scheduling implementation
USE_FULL_SCREEN_INTENT only if true alarm mode is enabled and policy allows it
RECORD_AUDIO
```

Important:

- Android 13+ requires notification permission.
- Exact alarms have additional restrictions on recent Android versions.
- Do not crash when exact-alarm permission is unavailable.
- Detect capability first.
- Show a Settings health row:

```text
Notifications       Allowed
Exact reminders     Allowed / Attention needed
Microphone          Allowed / Not requested
Battery restrictions Normal / May delay alarms
```

If exact scheduling is unavailable:

- keep the routine
- fall back to the best supported schedule
- show a non-blocking warning

Do not repeatedly nag the user.

---

# 14. iOS Notification Limits

Do not schedule an unlimited number of one-off future notifications.

iOS has a limit on pending local notification requests.

Prefer recurring calendar/time-based schedules for repeating daily/weekly reminders.

Create a scheduler implementation that can later introduce a rolling scheduling horizon if needed.

The database remains the source of truth.

---

# 15. Voice Recording

Use the `record` package.

Create a dedicated service:

```dart
abstract interface class VoiceRecorderService {
  Future<bool> hasPermission();
  Future<bool> requestPermission();

  Future<RecordingSession> start();
  Future<RecordedAudio?> stop();
  Future<void> cancel();

  Stream<RecordingAmplitude> get amplitude;
}
```

Responsibilities:

- microphone permission
- temp recording path
- duration tracking
- max-duration enforcement
- encoding
- cleanup

Do not put recorder plugin calls directly inside widgets.

---

# 16. Audio File Storage

Store recordings in application-owned storage.

Suggested structure:

```text
app_support/
  audio/
    recordings/
      <audioId>.wav
```

For iOS scheduled notification sound copies:

```text
Library/
  Sounds/
    routine_<routineId>_<revision>.wav
```

Database stores only metadata/path, never audio blobs.

When a routine is deleted:

1. cancel reminders
2. delete DB records
3. delete unused audio
4. delete iOS sound copy if no longer used

Implement orphan-file cleanup during maintenance.

---

# 17. Local Database

Use **Drift + SQLite**.

Why Drift:

- SQLite underneath
- type-safe queries
- migrations
- transactions
- reactive streams
- good testing story
- appropriate for relational schedules and history

Do not use SharedPreferences as the main database.

SharedPreferences is acceptable only for a tiny pre-database bootstrap value if needed.

---

# 18. Database Schema

Use UUID text IDs for domain records where useful, and separate stable integer IDs for OS notification/alarm identifiers.

## 18.1 `routines`

```text
id                  TEXT PRIMARY KEY
name                TEXT NOT NULL
category            TEXT NOT NULL
actionVerb          TEXT NULL
dosageText          TEXT NULL
instructions        TEXT NULL

iconKey             TEXT NOT NULL
colorKey            TEXT NOT NULL

isActive            BOOLEAN NOT NULL DEFAULT true
isArchived          BOOLEAN NOT NULL DEFAULT false

startDate           DATE NOT NULL
endDate             DATE NULL

weekdaysMask        INTEGER NOT NULL

soundMode           TEXT NOT NULL
audioId             TEXT NULL

vibrationEnabled    BOOLEAN NOT NULL DEFAULT true
snoozeEnabled       BOOLEAN NOT NULL DEFAULT true
snoozeMinutes       INTEGER NOT NULL DEFAULT 10

createdAt           DATETIME NOT NULL
updatedAt           DATETIME NOT NULL
```

### `soundMode`

```text
recorded
system
silent
```

### `weekdaysMask`

Use a bitmask or another deterministic representation.

Example:

```text
Monday    1 << 0
Tuesday   1 << 1
...
Sunday    1 << 6
```

Expose readable domain helpers.

---

## 18.2 `reminder_times`

```text
id                  TEXT PRIMARY KEY
routineId           TEXT NOT NULL FK routines(id) ON DELETE CASCADE

hour                INTEGER NOT NULL
minute              INTEGER NOT NULL
sortOrder           INTEGER NOT NULL
isEnabled           BOOLEAN NOT NULL DEFAULT true

notificationId      INTEGER NOT NULL UNIQUE

createdAt           DATETIME NOT NULL
updatedAt           DATETIME NOT NULL
```

Constraints:

```text
0 <= hour <= 23
0 <= minute <= 59
```

`notificationId` must be generated once and persisted.

Do not depend on `hashCode` for stable OS notification IDs.

---

## 18.3 `audio_recordings`

```text
id                  TEXT PRIMARY KEY
localPath           TEXT NOT NULL
iosSoundFilename    TEXT NULL

codec               TEXT NOT NULL
durationMs          INTEGER NOT NULL
fileSizeBytes       INTEGER NULL

revision            INTEGER NOT NULL DEFAULT 1

createdAt           DATETIME NOT NULL
updatedAt           DATETIME NOT NULL
```

---

## 18.4 `reminder_history`

```text
id                  TEXT PRIMARY KEY
routineId           TEXT NOT NULL
reminderTimeId      TEXT NULL

scheduledFor        DATETIME NOT NULL
action              TEXT NOT NULL
actionAt            DATETIME NULL

snoozedUntil        DATETIME NULL
note                TEXT NULL

createdAt           DATETIME NOT NULL
```

### `action`

```text
done
skipped
snoozed
missed
```

Do not claim medically that a dose was actually taken; it only means the user marked the reminder as done.

---

## 18.5 `app_settings`

Single-row table.

```text
id                          INTEGER PRIMARY KEY = 1

themeMode                   TEXT NOT NULL
accentStyle                 TEXT NOT NULL
useDynamicColor             BOOLEAN NOT NULL

timeFormat                  TEXT NOT NULL
defaultSnoozeMinutes        INTEGER NOT NULL
defaultVibration            BOOLEAN NOT NULL

onboardingCompleted         BOOLEAN NOT NULL
notificationEducationSeen   BOOLEAN NOT NULL

createdAt                   DATETIME NOT NULL
updatedAt                   DATETIME NOT NULL
```

Potential future fields can be added through Drift migrations.

---

# 19. Domain Models

Do not pass raw Drift row objects through the entire app.

Create domain models such as:

```dart
class Routine
class ReminderTime
class AudioRecording
class ReminderHistoryEntry
class AppSettings
```

Suggested enums:

```dart
enum RoutineCategory
enum ReminderSoundMode
enum ReminderAction
enum ThemePreference
enum TimeFormatPreference
```

Use extension methods/mappers for:

```text
Drift row -> Domain entity
Domain entity -> Drift companion
Enum <-> database string
```

---

# 20. Layered Architecture

Use feature-first clean layering without overengineering.

Recommended:

```text
lib/
├── app/
│   ├── app.dart
│   ├── bootstrap.dart
│   ├── router/
│   └── providers/
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── theme/
│   ├── utils/
│   └── widgets/
│
├── data/
│   ├── database/
│   │   ├── app_database.dart
│   │   ├── tables/
│   │   ├── daos/
│   │   └── migrations/
│   ├── local/
│   └── mappers/
│
├── domain/
│   ├── entities/
│   ├── enums/
│   ├── repositories/
│   └── services/
│
├── repositories/
│   ├── routine_repository_impl.dart
│   ├── history_repository_impl.dart
│   └── settings_repository_impl.dart
│
├── services/
│   ├── notifications/
│   │   ├── reminder_scheduler.dart
│   │   ├── flutter_local_notification_scheduler.dart
│   │   ├── notification_sync_service.dart
│   │   └── notification_id_service.dart
│   ├── audio/
│   │   ├── voice_recorder_service.dart
│   │   ├── voice_recorder_service_impl.dart
│   │   ├── audio_storage_service.dart
│   │   └── audio_preview_service.dart
│   ├── permissions/
│   └── platform/
│
└── presentation/
    ├── controllers/
    │   ├── today_controller.dart
    │   ├── routines_controller.dart
    │   ├── routine_editor_controller.dart
    │   ├── recording_controller.dart
    │   ├── history_controller.dart
    │   └── settings_controller.dart
    │
    ├── pages/
    │   ├── today/
    │   ├── routines/
    │   ├── routine_editor/
    │   ├── history/
    │   ├── settings/
    │   └── onboarding/
    │
    └── widgets/
```

---

# 21. Layer Responsibilities

## Data Layer

Owns:

- Drift database
- tables
- DAOs
- migrations
- data mapping
- file metadata access

Must not own:

- Material widgets
- navigation
- Riverpod UI state
- notification permission dialogs

## Domain Layer

Owns:

- pure entities
- enums
- repository contracts
- service contracts
- domain rules

Domain layer should not import Flutter UI libraries.

## Repository Layer

Repository interfaces live in `domain/repositories`.

Implementations live in `/repositories`.

Example:

```dart
abstract interface class RoutineRepository {
  Stream<List<Routine>> watchActive();
  Future<Routine?> getById(String id);
  Future<void> save(Routine routine);
  Future<void> delete(String id);
  Future<void> setActive(String id, bool active);
}
```

Repository implementation may combine:

- DAO
- mapper
- transaction

But notification scheduling should normally be orchestrated by the controller/application service rather than hidden as an unexpected repository side effect.

## Services Layer

Owns platform capabilities:

- notification scheduling
- audio recording
- audio storage
- audio preview
- permissions
- timezone
- system settings navigation

## Presentation Layer

Owns:

- pages
- widgets
- controllers
- validation presentation
- loading/error/success UI
- user-triggered orchestration

Widgets should remain thin.

---

# 22. Riverpod

Use:

```text
flutter_riverpod
riverpod_annotation
riverpod_generator
build_runner
```

Prefer generator-based Riverpod providers.

Do not manually build a service locator.

`ProviderScope` is the DI container.

Example dependency chain:

```text
AppDatabase
    ↓
RoutineDao
    ↓
RoutineRepositoryImpl
    ↓
RoutineRepository
    ↓
TodayController / RoutineEditorController
    ↓
Widget
```

Provider examples:

```dart
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) { ... }

@Riverpod(keepAlive: true)
RoutineRepository routineRepository(Ref ref) { ... }

@Riverpod(keepAlive: true)
ReminderScheduler reminderScheduler(Ref ref) { ... }

@riverpod
Stream<List<Routine>> activeRoutines(Ref ref) { ... }

@riverpod
class RoutineEditorController extends _$RoutineEditorController { ... }

@riverpod
class SettingsController extends _$SettingsController { ... }
```

---

# 23. Controller Pattern

Controllers are responsible for user use cases.

Example:

```dart
Future<void> saveRoutine(RoutineDraft draft) async {
  state = const AsyncLoading();

  state = await AsyncValue.guard(() async {
    final saved = await repository.saveDraft(draft);

    await scheduler.cancelRoutine(saved.id);
    await scheduler.scheduleRoutine(saved);

    return saved;
  });
}
```

Improve this with explicit failure reporting so a saved routine is not mistaken for a failed save just because OS scheduling failed.

Recommended final behavior:

```text
DB save success + scheduler success
    -> success

DB save success + scheduler failure
    -> partial success
    -> routine remains saved
    -> UI warning + retry scheduling

DB save failure
    -> failure
```

Use a small typed result where helpful.

---

# 24. Dependency Container

Do not use:

```text
get_it
injectable
service locator singleton globals
```

Use Riverpod as the dependency container.

App root:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bootstrap = await bootstrapApp();

  runApp(
    ProviderScope(
      overrides: bootstrap.overrides,
      child: const ReminderApp(),
    ),
  );
}
```

`bootstrapApp()` can initialize:

- database
- timezone data
- notifications plugin
- alarm/permission platform state
- file directories

Keep bootstrap deterministic and testable.

---

# 25. Error Handling

Create app-level failures, for example:

```dart
sealed class AppFailure {}

class DatabaseFailure extends AppFailure {}
class NotificationPermissionFailure extends AppFailure {}
class ExactAlarmPermissionFailure extends AppFailure {}
class SchedulingFailure extends AppFailure {}
class MicrophonePermissionFailure extends AppFailure {}
class RecordingFailure extends AppFailure {}
class AudioFileFailure extends AppFailure {}
```

User-facing messages must be friendly.

Bad:

```text
PlatformException(exact_alarms_not_permitted...)
```

Good:

```text
This reminder was saved, but Android is not currently allowing exact alarms.
Open Settings to enable precise reminders.
```

Log technical details only in debug/dev logging.

---

# 26. Theme System

Use Material 3.

Support:

```text
System
Light
Dark
```

Optional:

```text
Use device dynamic colors
```

The app must still have a designed fallback theme.

## Design Direction

Keywords:

```text
modern
premium
soft
calm
personal
clean
rounded
high-contrast when needed
```

Avoid looking like:

```text
hospital software
corporate admin dashboard
generic todo app
```

---

# 27. Design Tokens

Create reusable theme tokens.

## Radius

```dart
radiusSm = 12
radiusMd = 16
radiusLg = 24
radiusXl = 32
```

## Spacing

Base 4/8 scale:

```text
4
8
12
16
20
24
32
40
48
```

## Cards

Primary cards:

```text
border radius: 24
subtle border
very soft shadow/elevation
large internal padding
```

Do not use heavy shadows everywhere.

## Typography

Use Material 3 type scale with a clean font.

Recommended:

```text
Inter
Manrope
or system typography
```

Do not add a custom font unless licensing/assets are intentionally included.

## Motion

Use subtle animations:

```text
180–280 ms
```

Examples:

- card state changes
- progress ring
- recorder pulse
- schedule row insertion/removal
- page transition
- switch/toggle transitions

Respect reduced-motion accessibility settings where possible.

---

# 28. Color Semantics

Do not hard-code colors directly into pages.

Create semantic color roles:

```text
routineVitamin
routineMedicine
routineCream
routineSkincare
success
warning
error
surfaceSoft
surfaceElevated
```

All must have light + dark equivalents.

User-selected routine colors should use a curated palette, not an unrestricted RGB picker.

Example choices:

```text
Lavender
Mint
Blue
Rose
Amber
Teal
Indigo
Peach
```

---

# 29. Settings

Create a polished grouped settings screen.

## Appearance

```text
Theme
  System / Light / Dark

Dynamic color
  On / Off

Accent style
```

## Reminders

```text
Default snooze duration
Default vibration
Notification permission status
Exact alarm status (Android)
Open notification settings
Test reminder
```

`Test reminder` should schedule or display a short test safely and explain what is being tested.

## Voice

```text
Default reminder sound
Preview system sound
Microphone permission status
```

## Time

```text
12-hour / 24-hour
```

Default to the device locale preference.

## Data

```text
Export backup
Import backup
Delete all history
Delete all app data
```

### V1 Backup Format

Export local data to JSON.

Do not embed audio as base64 inside a huge JSON file.

Preferred future backup format:

```text
.zip
  backup.json
  audio/
```

For V1, backup/export can be deferred if schedule is tight.

## About

```text
App version
Privacy
Open-source licenses
```

Privacy copy:

```text
Your routine and voice data stay on this device unless you explicitly export them.
```

---

# 30. History Screen

History should answer:

> What did I mark as done recently?

Sections:

```text
Today
Yesterday
This Week
Earlier
```

Each row:

```text
icon
routine name
scheduled time
status
actual action time
```

Filters:

```text
All
Done
Skipped
Missed
```

History is not required to be a medical adherence report.

---

# 31. Reminder Detail / Ring Screen

When the user opens a due notification, show a focused screen.

Example:

```text
          [large category icon]

          Vitamin D

          1 tablet
          After breakfast

          Scheduled for 09:00

      [ Mark as Done ]

      [ Snooze 10 min ]

      Skip
```

If recorded audio is playing in a future true-alarm mode:

```text
[ Stop sound ]
```

The screen must work in dark mode and on a locked-screen/full-screen Android path if that feature is later enabled.

---

# 32. Notification Payload

Use a compact versioned payload.

Example:

```json
{
  "v": 1,
  "type": "routineReminder",
  "routineId": "uuid",
  "reminderTimeId": "uuid",
  "scheduledFor": "2026-09-12T09:00:00+03:00"
}
```

Do not serialize full routine objects into notification payloads.

Treat DB as the source of truth.

---

# 33. IDs

Need multiple ID types:

## Domain IDs

UUID string:

```text
routine.id
audio.id
history.id
reminderTime.id
```

## OS Notification IDs

Persist a positive 32-bit-safe integer.

Create:

```dart
class NotificationIdService
```

Requirements:

- deterministic persistence
- no collision with existing rows
- never use transient `hashCode`
- deleted IDs can remain unused; reuse is unnecessary

---

# 34. Permission UX

Never spam permission dialogs.

Flow:

```text
User chooses feature
     ↓
App explains benefit
     ↓
System permission dialog
     ↓
Granted -> continue
Denied -> show alternative
Permanently denied -> offer Open Settings
```

Microphone:

Only request after user taps Record.

Notifications:

Request after notification education screen or first reminder creation.

Exact alarms:

Only request if the chosen Android scheduling mode actually requires them.

---

# 35. Recommended Packages

Versions below were checked around **2026-09-11**. The implementation agent should still resolve the latest compatible stable versions before locking dependencies.

## Core

```yaml
dependencies:
  flutter:
    sdk: flutter

  flutter_riverpod: ^3.4.3
  riverpod_annotation: ^4.0.7

  drift: ^2.35.0
  drift_flutter: ^0.3.1

  flutter_local_notifications: ^22.3.0
  timezone: ^0.11.1

  record: ^7.1.1
  permission_handler: ^13.0.2

  path_provider: latest-compatible
  path: latest-compatible
  uuid: latest-compatible
  intl: latest-compatible
  go_router: latest-compatible

dev_dependencies:
  flutter_test:
    sdk: flutter

  riverpod_generator: ^4.0.9
  build_runner: latest-compatible
  drift_dev: latest-compatible
  flutter_lints: latest-compatible
```

Optional:

```yaml
dependencies:
  dynamic_color: latest-compatible
  package_info_plus: latest-compatible
  share_plus: latest-compatible
```

For a future true Android alarm mode:

```yaml
dependencies:
  alarm: ^5.13.0
```

Do not add packages just because they exist.

Every package should solve a real requirement.

---

# 36. Do Not Use

For V1, do not use:

```text
Firebase
Supabase
SQLite through raw SQL everywhere
Hive as the main relational database
GetX
BLoC
MobX
get_it
injectable
cloud push notifications
user accounts
analytics SDKs
ad SDKs
```

Unless a later requirement specifically needs them.

---

# 37. Database Migration Policy

Start with:

```dart
schemaVersion = 1
```

Never use destructive migration in production.

Every schema update must have:

- version increment
- explicit migration
- migration test

Do not delete user routines because a migration is difficult.

---

# 38. App Lifecycle

On cold start:

```text
initialize binding
initialize database
initialize timezone
initialize notification scheduler
load settings
run permission health check
reconcile schedules
render app
```

Do not delay first paint unnecessarily.

Noncritical reconciliation can happen after the shell becomes visible.

On resume:

```text
refresh permission state
check timezone change
reconcile schedules if needed
refresh Today
```

---

# 39. Rescheduling After Reboot

Android scheduling must be tested after reboot.

If the selected notification plugin requires manifest receivers/boot handling, configure them exactly according to the package documentation.

Acceptance test:

```text
1. Create reminder 5+ minutes in future.
2. Reboot Android phone.
3. Do not open app.
4. Reminder should still be delivered if the selected scheduling API promises reboot persistence.
```

If the platform/plugin cannot guarantee it:

- document it
- reschedule at next launch
- show reliability health information if useful

Do not hide the limitation.

---

# 40. Exact Alarm Behavior

For reminder times the ideal scheduling behavior is exact.

But Android may deny exact alarm capability.

The scheduler should expose:

```dart
enum ExactAlarmCapability {
  available,
  needsPermission,
  unavailable,
}
```

The app should never crash because exact alarms are denied.

Fallback gracefully.

---

# 41. Form Validation

Routine editor rules:

```text
name
  required
  1–60 chars

times
  at least one enabled reminder time

weekdays
  at least one selected weekday

endDate
  null or >= startDate

recording
  <= configured max duration
  file exists before save

snoozeMinutes
  positive
```

Prevent duplicate times for the same routine.

Example:

```text
08:00
08:00
```

should not be allowed twice.

---

# 42. Accessibility

Required:

- proper semantic labels
- minimum touch targets
- readable contrast
- support font scaling
- do not rely on color alone for state
- icons paired with labels where ambiguity exists
- recorder has nonvisual state text
- vibration is never the only feedback mechanism

---

# 43. Localization Readiness

V1 may ship English-only, but do not hardcode every string directly across widgets.

Use Flutter localization structure from the beginning.

Future languages may include Arabic.

Important:

- layout must support RTL
- time display must respect locale
- avoid fixed widths that break Arabic text

---

# 44. Privacy & Security

Because voice recordings can be personal:

- save them only in app-owned local storage
- do not upload them
- do not log file contents
- do not expose them publicly
- do not request broad media/storage access without a concrete need

If the app supports export later, the user must explicitly trigger it.

---

# 45. Performance

The app is small.

Targets:

```text
Cold start: fast
Scrolling: 60/120fps appropriate to device
No DB query inside item-build loops
No rebuilding the entire app for a single timer tick
```

Use Drift streams for lists.

For countdown UI:

- update only the relevant countdown widget
- do not write countdown ticks to DB

---

# 46. Testing Strategy

## Unit Tests

Test:

- weekday calculations
- next occurrence calculation
- start/end date rules
- duplicate time validation
- notification ID allocation
- repository mapping
- scheduler request generation
- timezone conversion
- settings defaults

## Database Tests

Test:

- insert routine
- update routine
- cascade delete
- archive
- stream updates
- transaction rollback
- migrations

## Controller Tests

Use Riverpod `ProviderContainer`.

Test:

- create routine success
- DB succeeds / scheduling fails
- edit routine causes reschedule
- delete cancels reminder
- microphone denial
- recording stop/save
- settings updates

## Widget Tests

Test:

- empty Today
- populated Today
- editor validation
- recorder states
- permission warning
- light/dark themes

## Integration / Real Device Tests

Must test notifications on real devices.

Suggested matrix:

```text
Pixel / recent Android
Samsung / recent Android
one aggressive-OEM Android if available
recent iPhone
older supported iPhone/iOS if available
```

---

# 47. Important Manual Test Cases

### Test A — Daily Reminder

```text
Create Vitamin D
Every day
Time = 2 minutes from now
System sound
Lock phone
Expect reminder
```

### Test B — Voice Reminder

```text
Create Face Cream
Record 5 sec voice
Preview succeeds
Schedule 2 minutes from now
Lock phone
Expect notification with custom voice where platform supports it
```

### Test C — Edit Voice

```text
Replace recorded voice
Save
Old schedule cancelled
New schedule uses new sound/channel revision
```

### Test D — Multiple Times

```text
08:00
14:00
22:00
```

All three should exist and display in Today.

### Test E — Disabled Routine

Disable routine.

No future reminders should remain scheduled for it.

### Test F — Permission Denied

Deny notifications.

App remains usable.

A visible status explains that reminders cannot be delivered.

### Test G — Timezone Change

Create reminder 08:00.

Change device timezone.

Open app.

Reminder remains 08:00 local time after reconciliation.

### Test H — Dark Mode

Check all screens in:

```text
light
dark
large text
```

---

# 48. UI Components to Build

Reusable components:

```text
AppScaffold
AppNavigationBar
RoutineCard
RoutineIcon
RoutineColorDot
NextReminderHeroCard
TodayTimeline
TimelineReminderRow
ProgressSummary
WeekdaySelector
ReminderTimeTile
TimePickerBottomSheet
RecordingCard
RecordingWaveform
PermissionStatusCard
SettingsGroup
SettingsTile
EmptyState
AppErrorState
AppLoadingState
PrimaryButton
SecondaryButton
DestructiveButton
StatusChip
```

Do not create giant 1,000-line screens.

Break UI into meaningful components.

---

# 49. Recommended Editor State

Use a draft object separate from persisted entities.

Example:

```dart
class RoutineDraft {
  final String? existingId;
  final String name;
  final RoutineCategory category;
  final String? dosageText;
  final String? instructions;
  final DateTime startDate;
  final DateTime? endDate;
  final Set<int> weekdays;
  final List<ReminderTimeDraft> times;
  final ReminderSoundDraft sound;
  final bool vibrationEnabled;
  final bool snoozeEnabled;
  final int snoozeMinutes;
}
```

The editor controller owns the draft.

Do not write to DB on every keystroke.

Write once when Save is tapped.

---

# 50. Save Transaction

Suggested application use case:

```text
validate draft
    ↓
persist/move audio
    ↓
DB transaction
    create/update routine
    create/update/delete reminder times
    attach audio record
    ↓
commit
    ↓
cancel stale OS schedules
    ↓
schedule new OS reminders
    ↓
return SaveRoutineResult
```

If OS scheduling fails after DB commit:

- DB data stays
- return warning
- offer Retry
- startup reconciliation tries again

---

# 51. Delete Routine Flow

Confirmation sheet:

```text
Delete “Vitamin D”?

This removes the routine, future reminders, and its local recording.
History can either be kept or deleted depending on V1 product choice.

Cancel
Delete
```

Recommended behavior:

- delete future schedule
- delete routine
- keep history with a snapshot of the routine display name/category if historical visibility matters

Simpler V1 option:

- cascade-delete history too

Pick one behavior and test it consistently.

Recommended long-term design is to preserve history using snapshot fields.

---

# 52. Archive vs Delete

Archive:

- preserves routine
- preserves history
- disables reminders
- hides from active list

Delete:

- permanent
- cancels schedules
- removes routine
- removes unused voice file

Use Archive as the safer common action.

---

# 53. Missed Reminder Logic

A system notification being delivered does **not** automatically prove the user saw it.

Therefore do not mark every delivered reminder as `missed`.

Recommended:

- `done`, `skipped`, and `snoozed` are explicit user actions
- `missed` can be derived later when a scheduled occurrence passes a configurable grace period without action

For simple V1, it is acceptable to leave it as `unresolved` internally and show only explicit history actions.

Do not overbuild adherence analytics.

---

# 54. Empty States

## Today Empty

```text
Nothing scheduled yet

Add your first routine and choose when you want to be reminded.

[ Add Routine ]
```

## Routines Empty

```text
Build your routine

Vitamins, creams, pills, skincare — keep everything in one calm place.

[ Create Routine ]
```

## History Empty

```text
No activity yet

Completed and skipped reminders will appear here.
```

---

# 55. Notification Copy Examples

Vitamin:

```text
Vitamin D
1 tablet • After breakfast
```

Cream:

```text
Night cream
Apply a thin layer
```

Custom:

```text
Eye drops
Time for your evening reminder
```

Keep notification text short.

Never expose sensitive instructions on the lock screen if a future privacy mode is enabled.

---

# 56. Settings Health Card

At the top of Settings > Reminders:

```text
Reminder Health

Notifications          ✓ On
Precise scheduling     ✓ Ready
Voice recording        ✓ Ready
Battery restrictions   — Normal
```

If action needed:

```text
Precise scheduling     ! Action needed

[ Fix ]
```

This is better UX than discovering a reminder failure later.

---

# 57. Optional Privacy Mode

Nice V1.1 feature:

```text
Hide details on lock screen
```

When enabled:

Instead of:

```text
Vitamin D — 1 tablet after breakfast
```

show:

```text
Routine reminder
Open the app to view details
```

---

# 58. Export / Import Design

If implemented:

Backup metadata:

```json
{
  "schemaVersion": 1,
  "exportedAt": "...",
  "routines": [],
  "reminderTimes": [],
  "audio": [],
  "settings": {}
}
```

Do not trust imported paths.

On import:

- allocate new local file locations
- validate schema
- validate IDs
- validate enums
- validate time ranges
- reschedule after successful import

---

# 59. Logging

Use structured debug logging.

Examples:

```text
[NotificationScheduler] scheduled notificationId=1042
[NotificationScheduler] cancelled routineId=...
[AudioRecorder] recording started
[AudioStorage] copied iOS notification sound
[NotificationSync] reconciliation complete
```

Never log:

- full sensitive notes unless debug-only and necessary
- raw audio
- personally sensitive content

Disable verbose logs in release.

---

# 60. Code Quality

Requirements:

```text
dart format
flutter analyze
no analyzer errors
no ignored lint pile
clear names
small methods
const widgets where useful
final by default
document platform-specific workarounds
```

Avoid abstraction for abstraction's sake.

Good architecture should make this app easier to change, not harder to understand.

---

# 61. Suggested Implementation Phases

## Phase 1 — Project Foundation

- Flutter project
- linting
- Riverpod
- routing
- Material 3 theme
- light/dark mode
- app shell / navigation

## Phase 2 — Database

- Drift setup
- tables
- DAOs
- repositories
- migrations
- tests

## Phase 3 — Routine CRUD

- routines list
- add/edit
- weekday selector
- multiple times
- archive/delete

## Phase 4 — Today

- compute today occurrences
- timeline
- next reminder
- completion state

## Phase 5 — Notifications

- permission UX
- timezone init
- scheduler abstraction
- daily/weekly scheduling
- cancel/reschedule
- reconciliation
- real-device tests

## Phase 6 — Voice

- microphone permission
- record
- preview
- save
- attach to routine
- iOS sound copying
- Android custom-sound strategy
- fallback behavior

## Phase 7 — History

- done
- skip
- snooze
- history screen

## Phase 8 — Settings

- appearance
- reminder health
- default snooze
- 12/24h
- permission shortcuts
- data controls

## Phase 9 — Polish

- animations
- empty states
- accessibility
- RTL readiness
- error states
- device testing
- release hardening

---

# 62. Definition of Done — V1

The app is V1-ready when:

- [ ] User can create a routine.
- [ ] User can choose category.
- [ ] User can enter dosage/instructions.
- [ ] User can choose selected weekdays.
- [ ] User can add multiple times/day.
- [ ] User can edit and delete times.
- [ ] User can record a short voice clip.
- [ ] User can preview the recording.
- [ ] User can replace/remove the recording.
- [ ] Routine is stored locally.
- [ ] Notification schedules survive normal app restarts.
- [ ] Notifications are delivered while app is closed according to OS capabilities.
- [ ] Editing a routine reschedules it.
- [ ] Disabling/archive cancels future reminders.
- [ ] Deleting cancels future reminders.
- [ ] Permission denial does not crash the app.
- [ ] Today screen shows today's timeline.
- [ ] User can mark reminder done.
- [ ] User can snooze.
- [ ] History is visible.
- [ ] Settings work.
- [ ] Light/dark/system theme works.
- [ ] App is usable offline.
- [ ] No backend/account is required.
- [ ] Android notification behavior tested on real hardware.
- [ ] iOS notification behavior tested on real hardware.
- [ ] Voice fallback behavior is tested.
- [ ] `flutter analyze` passes.
- [ ] unit/widget tests cover core logic.

---

# 63. Agent Instructions

The implementation agent should follow these rules:

1. Read this entire specification before coding.
2. Do not add a backend.
3. Do not simplify the architecture into widgets calling Drift/plugins directly.
4. Use Riverpod for state management and dependency injection.
5. Keep platform APIs behind services.
6. Keep database access behind DAOs/repositories.
7. Persist stable notification IDs.
8. Treat the database as source of truth.
9. Cancel and rebuild schedules when relevant data changes.
10. Never assume Android notification-channel sound can be changed after channel creation.
11. Do not promise identical full alarm behavior between Android and iOS.
12. Never lose routine data just because notification scheduling failed.
13. Build and test the basic system-sound reminder before custom voice.
14. Then add recorded audio.
15. Test permissions on real devices.
16. Keep V1 intentionally small.
17. Prefer reliable behavior over flashy behavior.
18. Preserve clean modern UI throughout.
19. Add comments around platform-specific notification/audio workarounds.
20. Before declaring V1 complete, execute every manual reminder test in this document.

---

# 64. Recommended Initial App Name Ideas

Working names only:

```text
Routine
Nudge
Cue
DailyCue
Remindly
MyRoutine
DoseCue
Ritual
```

Do not block development on final branding.

Use a neutral internal bundle/project name until branding is decided.

---

# 65. Technical References

Implementation agent should consult current official/plugin documentation before final platform configuration.

- Flutter Riverpod: https://pub.dev/packages/flutter_riverpod
- Riverpod Generator: https://pub.dev/packages/riverpod_generator
- Drift: https://pub.dev/packages/drift
- Flutter Local Notifications: https://pub.dev/packages/flutter_local_notifications
- Record: https://pub.dev/packages/record
- Permission Handler: https://pub.dev/packages/permission_handler
- Timezone: https://pub.dev/packages/timezone
- Alarm package (optional advanced Android alarm): https://pub.dev/packages/alarm
- Android exact alarms: https://developer.android.com/develop/background-work/services/alarms
- Apple notification custom sounds: https://developer.apple.com/documentation/usernotifications/unnotificationsound

---

# 66. Final Architecture Summary

```text
                ┌─────────────────────────┐
                │      Presentation       │
                │ Pages / Widgets         │
                │ Riverpod Controllers    │
                └────────────┬────────────┘
                             │
                             ▼
                ┌─────────────────────────┐
                │         Domain          │
                │ Entities / Contracts    │
                │ Business Rules          │
                └───────┬────────┬────────┘
                        │        │
               ┌────────▼──┐  ┌──▼──────────────┐
               │Repository │  │ Platform Services│
               │   Layer   │  │ Notification     │
               └────┬──────┘  │ Recording        │
                    │         │ Permissions      │
                    ▼         └──────────────────┘
                ┌─────────────────────────┐
                │       Data Layer        │
                │ Drift / DAOs / SQLite   │
                │ Local Files / Mappers   │
                └─────────────────────────┘
```

Riverpod wires the graph together.

No cloud is required.

The result should feel like a small premium personal routine app with strong local reminder reliability, not an oversized health platform.
