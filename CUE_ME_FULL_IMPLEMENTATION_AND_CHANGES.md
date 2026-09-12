# CueMe - Comprehensive Implementation & Troubleshooting Report

This document details **everything that was built, modified, and resolved** to deliver the 100% offline-first **CueMe** personal routine reminder Flutter application and launch it on your physical Android device (**DNP NX9**, Android 16 API 36).

---

## 📑 Table of Contents
1. [Executive Summary](#1-executive-summary)
2. [Architecture & Technology Stack](#2-architecture--technology-stack)
3. [All Files Created & Structure](#3-all-files-created--structure)
4. [Files Modified](#4-files-modified)
5. [Critical Build Issues & Exact Solutions](#5-critical-build-issues--exact-solutions)
6. [Verification, Tests & On-Device Launch](#6-verification-tests--on-device-launch)

---

## 1. Executive Summary

CueMe was developed from scratch following the comprehensive `PERSONAL_ROUTINE_REMINDER_FLUTTER_SPEC.md` specification:
- **Zero Cloud / 100% Offline-First**: No Firebase, Supabase, cloud auth, or remote telemetry.
- **Relational Local Database**: SQLite powered by [Drift](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/data/database/app_database.dart) with DAOs, foreign keys, cascade deletes, and migrations.
- **State Management & DI**: Flutter Riverpod 3 (`Notifier`, `NotifierProvider`, `StreamProvider`).
- **Reliable Local Notifications**: Exact alarms (`SCHEDULE_EXACT_ALARM`, `USE_EXACT_ALARM`), deterministic 32-bit integer IDs, Android notification channel versioning (`routine_<id>_sound_<revision>`), and iOS `Library/Sounds/` copy.
- **Voice Cues**: Linear PCM WAV audio recording (16kHz / 44.1kHz mono), live amplitude waveform visualizer, and local preview player.
- **Material 3 Design**: Radius 24 elevated cards, Lavender/Mint/Rose palette, full light and dark themes.

---

## 2. Architecture & Technology Stack

| Layer | Technologies / Packages | Purpose |
|---|---|---|
| **Core** | `dynamic_color`, `intl`, `uuid`, `path_provider`, `path` | Theme tokens, internationalization, unique identifiers, disk paths |
| **Domain** | Pure Dart entities, enums, `OccurrenceCalculator` | Business rules, bitmask weekday calculations, occurrence ordering |
| **Data / Storage** | `drift`, `drift_flutter`, `sqlite3` | Local SQLite database, DAOs, migrations, type-safe mappers |
| **Services** | `flutter_local_notifications`, `timezone`, `record`, `audioplayers`, `permission_handler` | Notification alarms, sound channels, audio recording, audio playback, OS permissions |
| **Presentation** | `flutter_riverpod`, `go_router` | UI Controllers (`Notifier`), routing, responsive screens and custom widgets |

---

## 3. All Files Created & Structure

### 🎨 Core & Theme Layer (`lib/core/`)
- [app_colors.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/core/theme/app_colors.dart): Curated Lavender, Mint, Sky Blue, Rose, and Sand palettes for Light and Dark modes.
- [app_tokens.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/core/theme/app_tokens.dart): Radii (e.g. `r24 = 24.0`), paddings, elevation shadows, durations, and typography tokens.
- [app_theme.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/core/theme/app_theme.dart): Material 3 `ThemeData` factory for Light and Dark themes.
- [app_constants.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/core/constants/app_constants.dart): Database names, max recording durations (20s soft cap, 29s hard cap for iOS), channel prefixes.
- [app_failure.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/core/errors/app_failure.dart): Failure types (`DatabaseFailure`, `AudioFailure`, `NotificationFailure`, `PermissionFailure`).
- [app_logger.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/core/utils/app_logger.dart): Structured debug logger.
- [date_time_extensions.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/core/extensions/date_time_extensions.dart): Helper extensions for formatted times, date stamps, and weekday masks.

### 🏛️ Domain Layer (`lib/domain/`)
- **Entities**:
  - [routine.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/domain/entities/routine.dart): Routine entity (name, category, weekday mask, date ranges, sound mode, sound file path).
  - [reminder_time.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/domain/entities/reminder_time.dart): Daily reminder time entity with hour, minute, and deterministic notification ID.
  - [audio_recording.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/domain/entities/audio_recording.dart): Audio metadata (file path, duration, sample rate, format).
  - [reminder_history_entry.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/domain/entities/reminder_history_entry.dart): History logs (done, skipped, snoozed, action timestamp).
  - [app_settings.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/domain/entities/app_settings.dart): User preferences (theme, 24h format, snooze duration, sound mode).
  - [today_occurrence.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/domain/entities/today_occurrence.dart): Dynamic projection of today's reminders with completion status.
- **Enums**:
  - [routine_category.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/domain/enums/routine_category.dart): Pill, Medicine, Vitamin, Supplement, Cream, Skincare, Drops, Custom.
  - [reminder_enums.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/domain/enums/reminder_enums.dart): `ReminderSoundMode`, `ReminderAction`, `ThemePreference`, `TimeFormatPreference`, `ExactAlarmCapability`, `OccurrenceStatus`.
- **Services**:
  - [occurrence_calculator.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/domain/services/occurrence_calculator.dart): Pure calculation engine that evaluates bitmasks, active dates, past-due statuses, and next upcoming cues.

### 💾 Data Layer (`lib/data/`)
- **Drift Tables** (`lib/data/database/tables/`):
  - `routines_table.dart`: Routines table schema with UUID PK, indexes, and cascades.
  - `reminder_times_table.dart`: Reminder times table schema with unique foreign key to routines.
  - `audio_recordings_table.dart`: Voice recording metadata table schema.
  - `reminder_history_table.dart`: History audit table schema.
  - `app_settings_table.dart`: Key-value settings table schema.
- **DAOs** (`lib/data/database/daos/`):
  - `routine_dao.dart`: Full CRUD, reactive streams (`watchAllActiveRoutines()`), and foreign key cascade deletions.
  - `reminder_history_dao.dart`: History queries and date-range filtering.
  - `settings_dao.dart`: Settings persistence and reactive updates.
- **Database Engine**:
  - [app_database.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/data/database/app_database.dart): Central Drift database definition with migrations and SQLite native bindings.
- **Mappers**:
  - [database_mappers.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/data/mappers/database_mappers.dart): Two-way converters between Drift data rows and Domain entities.

### 📦 Repositories Layer (`lib/repositories/`)
- [routine_repository_impl.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/repositories/routine_repository_impl.dart): Implementation of routine storage, creation, editing, and syncing.
- [history_repository_impl.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/repositories/history_repository_impl.dart): Implementation of history logging and streak statistics.
- [settings_repository_impl.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/repositories/settings_repository_impl.dart): Implementation of user preference persistence.

### ⚙️ Platform Services Layer (`lib/services/`)
- **Notifications**:
  - [notification_id_service.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/services/notifications/notification_id_service.dart): Deterministic 32-bit signed integer ID generator (`routineUuid.hashCode ^ (hour * 60 + minute)`).
  - [flutter_local_notification_scheduler.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/services/notifications/flutter_local_notification_scheduler.dart): Schedules exact alarms (`zonedSchedule`), creates custom notification channels (`AndroidNotificationChannel`), and manages action categories.
  - [notification_sync_service.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/services/notifications/notification_sync_service.dart): Synchronizes all active database routines to system alarms and clears deleted ones.
- **Audio Recording & Storage**:
  - [voice_recorder_service_impl.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/services/audio/voice_recorder_service_impl.dart): Linear PCM WAV recording using `record` package, live amplitude broadcast, and 20s/29s auto-stop.
  - [audio_storage_service.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/services/audio/audio_storage_service.dart): Sandboxed file persistence in `app_audio/` and automatic copying to iOS `Library/Sounds/`.
  - [audio_preview_service.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/services/audio/audio_preview_service.dart): In-app audio player for recorded voice cues via `audioplayers`.
- **Permissions**:
  - [permission_service.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/services/permissions/permission_service.dart): Verifies notifications, microphone, exact alarms, battery optimization, and opens system settings.

### 🕹️ Presentation & State Management Layer (`lib/presentation/`)
- **Controllers (Riverpod 3 `Notifier`)**:
  - `today_controller.dart`: Loads today's occurrences, provides quick Done/Snooze/Skip actions, and watches changes.
  - `routines_controller.dart`: Manages routine list, search, category filtering, and active/archive toggles.
  - `routine_editor_controller.dart`: Handles draft validation (name, weekdays, times, date ranges), voice recording attachment, and database save.
  - `recording_controller.dart`: Controls microphone start/stop/cancel, live amplitude stream, and playback preview.
  - `history_controller.dart`: Computes completion streaks and queries history logs.
  - `settings_controller.dart`: Controls theme mode, time format (12h vs 24h), snooze duration, and sound mode.
- **Pages**:
  - [onboarding_page.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/pages/onboarding/onboarding_page.dart): Introduction walkthrough explaining offline privacy and requesting critical permissions.
  - [today_page.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/pages/today/today_page.dart): Main dashboard with `NextReminderHeroCard`, `ProgressSummary`, and `TimelineReminderRow` list.
  - [routines_page.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/pages/routines/routines_page.dart): Routine catalog with category filter chips, search bar, and FAB to create routines.
  - [routine_editor_page.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/pages/routines/routine_editor_page.dart): Comprehensive 4-section editor (What, When, Cue Sound, Active Window).
  - [history_page.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/pages/history/history_page.dart): Streak statistics, total completed counters, and completion logs.
  - [settings_page.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/pages/settings/settings_page.dart): Theme selector, sound preference, snooze duration, permission health card, and reset options.
  - [reminder_ring_page.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/pages/ring/reminder_ring_page.dart): Full-screen reminder alert screen with animated cue icon, custom voice playback, Done, Snooze, and Skip buttons.
- **Components & Widgets**:
  - [app_scaffold.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/widgets/app_scaffold.dart): Navigation bar scaffold (Today, Routines, History, Settings).
  - [next_reminder_hero_card.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/widgets/next_reminder_hero_card.dart): Hero banner showing next upcoming cue, time countdown, and quick Done button.
  - [progress_summary.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/widgets/progress_summary.dart): Visual progress bar and percentage of today's completed routines.
  - [timeline_reminder_row.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/widgets/timeline_reminder_row.dart): Timeline item with status badge, dosage/instructions, and action menu.
  - [routine_card.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/widgets/routine_card.dart): Routine catalog card with category icon, active switch, and schedule chip.
  - [weekday_selector.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/widgets/weekday_selector.dart): Day picker chips (Mon-Sun) with quick presets (Daily, Weekdays, Weekends).
  - [reminder_time_tile.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/widgets/reminder_time_tile.dart): Interactive time chip with time-picker dialog trigger.
  - [recording_card.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/widgets/recording_card.dart): Voice cue container with record button, timer, preview player, and re-record options.
  - [recording_waveform.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/widgets/recording_waveform.dart): Dynamic animated bar visualizer connected to live mic amplitude.
  - [permission_health_card.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/widgets/permission_health_card.dart): System permission status card with one-tap fix buttons.
  - [empty_state.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/presentation/widgets/empty_state.dart): Reusable illustration and copy for empty timelines and lists.

### 🧪 Tests (`test/`)
- `occurrence_calculator_test.dart`: Validates daily ordering, completed statuses, and date boundaries.
- `weekday_mask_test.dart`: Validates bitwise weekday calculations.
- `routine_editor_validation_test.dart`: Validates name constraints, duplicate times, empty days, and start/end dates.
- `widget_test.dart`: Tests `EmptyState` rendering and `ProgressSummary` percentage calculations.

---

## 4. Files Modified

1. **[pubspec.yaml](file:///c:/Users/dedoa/StudioProjects/CueMe/pubspec.yaml)**:
   - Added Flutter Riverpod 3 (`flutter_riverpod: ^3.4.3`), Drift SQLite (`drift: ^2.35.0`, `drift_flutter: ^0.3.1`), Local Notifications (`flutter_local_notifications: ^22.3.0`, `timezone: ^0.11.1`), Audio Recording (`record: ^7.1.1`), Audio Playback (`audioplayers: ^6.8.1`), Navigation (`go_router: ^17.5.0`), Dynamic Color (`dynamic_color: ^1.8.1`), UUID (`uuid: ^4.6.0`), and pinned `permission_handler: 11.3.1`.
2. **[android/app/src/main/AndroidManifest.xml](file:///c:/Users/dedoa/StudioProjects/CueMe/android/app/src/main/AndroidManifest.xml)**:
   - Added permissions: `POST_NOTIFICATIONS`, `SCHEDULE_EXACT_ALARM`, `USE_EXACT_ALARM`, `RECEIVE_BOOT_COMPLETED`, `VIBRATE`, `RECORD_AUDIO`, `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS`.
   - Added broadcast receivers for reboot rescheduling:
     - `com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver`
     - `com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver`
3. **[ios/Runner/Info.plist](file:///c:/Users/dedoa/StudioProjects/CueMe/ios/Runner/Info.plist)**:
   - Added `NSMicrophoneUsageDescription`: "CueMe needs microphone access to record custom voice reminder cues."
4. **[android/app/build.gradle.kts](file:///c:/Users/dedoa/StudioProjects/CueMe/android/app/build.gradle.kts)**:
   - Set `minSdk = 23`.
   - Enabled `isCoreLibraryDesugaringEnabled = true`.
   - Added `coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")`.
5. **[android/gradle.properties](file:///c:/Users/dedoa/StudioProjects/CueMe/android/gradle.properties)**:
   - Added `kotlin.incremental=false` and `kotlin.incremental.useClasspathSnapshot=false`.
   - Added `kotlin.compiler.execution.strategy=in-process`.
   - Adjusted JVM arguments to `-Xmx4G -XX:MaxMetaspaceSize=1G`.
6. **[lib/main.dart](file:///c:/Users/dedoa/StudioProjects/CueMe/lib/main.dart)**:
   - Wired `bootstrap()` to initialize Flutter bindings, initialize timezone database (`tz.initializeTimeZones()`), initialize Drift database, and initialize notification plugin before running `CueMeApp`.

---

## 5. Critical Build Issues & Exact Solutions

During the build and deployment to your connected Android device, several platform and build-toolchain blockers arose. Here is exactly how each was diagnosed and resolved:

### Issue 1: `permission_handler: ^13.0.2` requiring unreleased `compileSdk = 37`
- **Symptom**: Gradle failed with: `Failed to find target with hash string 'android-37' in C:\Users\dedoa\AppData\Local\Android\Sdk`.
- **Root Cause**: The transitive dependency `permission_handler_android: 14.1.0` required Android SDK 37 (an unreleased developer preview). The installed Android SDKs on your system were 34, 35, and 36.
- **Solution**: Pinned `permission_handler: 11.3.1` in `pubspec.yaml`. This resolved `permission_handler_android: 12.1.0`, which compiles against stable Android SDKs (34/35/36) without any missing SDK errors.

### Issue 2: Cross-Drive Windows Pathing Bug in Kotlin Incremental Compilation
- **Symptom**: Gradle compilation crashed with:
  `IllegalArgumentException: this and base files have different roots: F:\pub_cache\hosted\pub.dev\dynamic_color-1.9.0\... and C:\Users\dedoa\StudioProjects\CueMe\android`
- **Root Cause**: Your Flutter pub cache is installed on drive `F:`, while the project workspace is located on drive `C:`. Kotlin's incremental cache toolchain calls `FilesKt__UtilsKt.relativeTo()`, which throws an exception on Windows when two paths have different root drive letters (`F:\` vs `C:\`).
- **Solution**: Added the following flags to `android/gradle.properties`:
  ```properties
  kotlin.incremental=false
  kotlin.incremental.useClasspathSnapshot=false
  ```
  This disabled multi-drive incremental caching, completely eliminating the cross-drive path error.

### Issue 3: Kotlin Daemon Socket Connection Failures
- **Symptom**: Compilation failed with: `e: Failed connecting to the daemon in 4 retries`.
- **Root Cause**: The Kotlin Gradle plugin attempted to spawn a standalone daemon process and connect over a local TCP socket, which was blocked or timed out.
- **Solution**: Added `kotlin.compiler.execution.strategy=in-process` in `android/gradle.properties`. This forces the Kotlin compiler to run inside the existing Gradle worker thread without spawning a separate daemon.

### Issue 4: Missing Java 8+ Core Library Desugaring for `flutter_local_notifications`
- **Symptom**: Build failed at `:app:checkDebugAarMetadata`:
  `Dependency ':flutter_local_notifications' requires core library desugaring to be enabled for :app.`
- **Root Cause**: Modern notification scheduling uses `java.time` APIs on older Android API levels, requiring desugaring support.
- **Solution**: Updated `android/app/build.gradle.kts`:
  ```kotlin
  compileOptions {
      isCoreLibraryDesugaringEnabled = true
      sourceCompatibility = JavaVersion.VERSION_17
      targetCompatibility = JavaVersion.VERSION_17
  }
  dependencies {
      coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
  }
  ```

### Issue 5: Android 16 Multi-User / Work Profile Shell Warning During App Start
- **Symptom**: Device package manager reported: `SecurityException: Shell does not have permission to access user 10/100`.
- **Root Cause**: Your device has dual-app or work profiles active.
- **Solution**: Explicitly targeted the primary user (`--user 0`) via ADB:
  `adb.exe -s A3SQUT5429018053 shell am start --user 0 -n com.cueme.cueme/.MainActivity`
  This immediately opened the app as the top-most active window on your device screen.

---

## 6. Verification, Tests & On-Device Launch

1. **Static Analysis**:
   - `flutter analyze` passed with **0 issues found**.
2. **Automated Unit & Widget Tests**:
   - `flutter test` executed and passed **16 of 16 tests**:
     - `OccurrenceCalculator` tests: daily ordering, status tracking, date window boundaries.
     - `WeekdayBitmask` tests: bitmask calculations and day inclusion.
     - `RoutineDraft` validation tests: name lengths, empty days/times, duplicate times, date ranges.
     - `Widget` tests: `EmptyState` and `ProgressSummary` percentage calculations.
3. **Physical Device Deployment**:
   - Device: `DNP NX9` (`A3SQUT5429018053`, Android 16 API 36).
   - Package: `com.cueme.cueme` built as `app-debug.apk` and installed.
   - Screen verified: User actively interacting with the **New Routine** screen.
