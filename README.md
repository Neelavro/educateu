# EducateU — Flutter Mobile Application

A full-featured educational platform mobile app built with Flutter. Students can authenticate, browse enrolled courses, access learning materials, watch lesson videos, take notes, participate in discussions, and manage their academic profile.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Tech Stack & Dependencies](#tech-stack--dependencies)
3. [Architecture](#architecture)
4. [Folder Structure](#folder-structure)
5. [Core Utilities](#core-utilities)
6. [State Management](#state-management)
7. [Dependency Injection](#dependency-injection)
8. [Navigation & Routing](#navigation--routing)
9. [Features](#features)
   - [Onboarding / Splash](#onboarding--splash)
   - [Authentication](#authentication)
   - [Dashboard / Explore](#dashboard--explore)
   - [Courses](#courses)
   - [Lesson Player](#lesson-player)
   - [Profile](#profile)
10. [Data Layer](#data-layer)
11. [Domain Layer](#domain-layer)
12. [Design System](#design-system)
13. [API Reference](#api-reference)
14. [Getting Started](#getting-started)

---

## Project Overview

EducateU is a student-facing learning management system (LMS) mobile app. It connects to a REST backend and allows students to:

- Sign in with email/password, with optional MFA via OTP
- Activate accounts using a temporary password and a security question
- Browse their enrolled courses filtered by status (Active, Completed, Withdrawn)
- View full course details: overview, module list, materials, and video library
- Watch lesson videos with an in-app player, take timestamped notes, read discussion threads, and access supplementary resources
- Manage their personal profile, academic information, security settings, notification preferences, and privacy controls

---

## Tech Stack & Dependencies

| Package | Version | Purpose |
|---|---|---|
| `flutter` | Channel stable, 3.41.7 | UI framework |
| `provider` | `^6.1.5+1` | Reactive state management |
| `go_router` | `^17.2.1` | Declarative navigation |
| `get_it` | `^9.2.1` | Service locator / dependency injection |
| `dartz` | `^0.10.1` | Functional programming — `Either<Failure, Data>` pattern |
| `equatable` | `^2.0.8` | Value equality for domain entities |
| `shared_preferences` | `^2.5.5` | Persistent local storage (auth token, student data) |
| `sizer` | `^3.1.3` | Responsive sizing (`2.h`, `3.w`) |
| `google_fonts` | `^6.2.1` | Roboto font family |
| `heroicons` | `^0.11.0` | Heroicons icon set |
| `cupertino_icons` | `^1.0.8` | iOS-style icons |

**Dev dependencies:** `flutter_lints ^5.0.0`

**Dart SDK:** `^3.9.2`  
**Flutter SDK:** Channel stable, 3.41.7  
**Platform:** macOS 15.3 darwin-arm64

---

## Architecture

EducateU follows **Clean Architecture** with three distinct layers separated by clear dependency rules. Outer layers depend on inner layers; inner layers know nothing about the UI.

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │  Screens, Widgets, Providers
│  (lib/presentation/, lib/providers/)   │  Flutter/UI only
├─────────────────────────────────────────┤
│             Domain Layer                │  Business logic, pure Dart
│  (lib/domain/)                          │  Entities, Repository interfaces, Use Cases
├─────────────────────────────────────────┤
│              Data Layer                 │  API calls, JSON serialization
│  (lib/data/)                            │  Repository implementations, Data models
└─────────────────────────────────────────┘
```

### Data flow

```
Screen
  └─► Provider (ChangeNotifier)
        └─► UseCase
              └─► Repository interface (domain)
                    └─► Repository implementation (data)
                          └─► HTTP API
                                └─► Returns Either<String, Entity>
```

- **Errors** are returned as `Left<String>` (error message string).
- **Success** is returned as `Right<T>` (typed entity).
- Providers call `.fold()` on the `Either` to handle both cases and call `notifyListeners()`.

---

## Folder Structure

```
educateu/
├── lib/
│   ├── main.dart                          # App entry point, MultiProvider setup
│   ├── injection_container.dart           # GetIt service locator registration
│   │
│   ├── core/
│   │   ├── colors.dart                    # AppColors — complete design-system palette
│   │   ├── textstyles.dart                # AppTextStyles — typography scale
│   │   ├── router.dart                    # GoRouter — all app routes
│   │   ├── helper.dart                    # Global ValueNotifier<StudentEntity>
│   │   └── urls.dart                      # API base URL and endpoint constants
│   │
│   ├── data/
│   │   ├── models/
│   │   │   ├── student_model.dart         # JSON ↔ StudentEntity
│   │   │   ├── profile_model.dart         # JSON ↔ ProfileEntity
│   │   │   ├── profile_photo_model.dart   # Profile photo metadata
│   │   │   └── security_question_model.dart
│   │   └── repositories/
│   │       ├── authentication_repository_impl.dart
│   │       └── profile_repository_impl.dart
│   │
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── student_entity.dart        # Equatable; id, name, email, tokens, flags
│   │   │   ├── profile_entity.dart        # fullName getter, 17 profile fields
│   │   │   └── security_question_entity.dart
│   │   ├── repositories/
│   │   │   ├── authentication_repository.dart   # Abstract interface
│   │   │   └── profile_repository.dart          # Abstract interface
│   │   └── usecases/
│   │       ├── authentication_usecase.dart      # login, loginOtp, getSecurityQuestions, changePassword
│   │       └── profile_usecase.dart             # getProfile, updateProfile
│   │
│   ├── providers/
│   │   ├── authentication_provider.dart   # Auth state + SharedPreferences persistence
│   │   └── profile_provider.dart          # Profile state
│   │
│   └── presentation/
│       ├── onboarding/
│       │   └── splash_screen.dart
│       │
│       ├── authentication/
│       │   ├── screens/
│       │   │   ├── login_screen.dart
│       │   │   ├── otp_screen.dart
│       │   │   ├── account_activate_screen.dart
│       │   │   └── forgot_password_screen.dart
│       │   └── widget/
│       │       ├── rounded_text_field_widget.dart
│       │       ├── rounded_check_box_widget.dart
│       │       ├── rounded_drop_down_widget.dart
│       │       └── toast_widget.dart
│       │
│       ├── main_shell/
│       │   └── main_shell_screen.dart     # Persistent bottom navigation shell
│       │
│       ├── dashboard/
│       │   ├── screens/
│       │   │   └── explore_screen.dart
│       │   └── widgets/
│       │       ├── stat_card_widget.dart
│       │       ├── course_progress_card_widget.dart
│       │       └── assignment_card_widget.dart
│       │
│       ├── course/
│       │   ├── screens/
│       │   │   ├── courses_screen.dart
│       │   │   ├── course_detail_screen.dart
│       │   │   ├── course_overview_screen.dart
│       │   │   ├── course_modules_screen.dart
│       │   │   ├── course_materials_screen.dart
│       │   │   ├── course_videos_screen.dart
│       │   │   └── lesson_player_screen.dart
│       │   ├── models/
│       │   │   ├── lesson.dart
│       │   │   ├── module.dart
│       │   │   ├── material.dart
│       │   │   └── video.dart
│       │   └── widgets/
│       │       ├── course_card_widget.dart
│       │       ├── module_card_widget.dart
│       │       ├── in_progress_module_body.dart
│       │       ├── video_tile_widget.dart
│       │       ├── video_module_section_widget.dart
│       │       ├── lesson_row_widget.dart
│       │       ├── file_card_widget.dart
│       │       ├── reading_card_widget.dart
│       │       ├── external_resource_row_widget.dart
│       │       ├── note_card_widget.dart
│       │       ├── comment_tile_widget.dart
│       │       └── next_session_card.dart
│       │
│       └── profile/
│           ├── screens/
│           │   ├── profile_screen.dart
│           │   ├── personal_info_screen.dart
│           │   ├── security_settings_screen.dart
│           │   ├── privacy_setting_screen.dart
│           │   └── notification_screen.dart
│           └── widgets/
│               ├── academic_info_widget.dart
│               ├── academic_details_widget.dart
│               ├── quick_access_button_widget.dart
│               ├── achieve_section_widget.dart
│               └── toggle_info_widget.dart
│
├── assets/
│   └── logo.png
├── pubspec.yaml
└── analysis_options.yaml
```

---

## Core Utilities

### `lib/core/colors.dart` — AppColors

A single static class that defines every color token used in the app. All widgets reference `AppColors.*` — no inline hex codes anywhere else.

| Token group | Examples |
|---|---|
| Brand | `primary` (`#013E5B`), `pill` (`#90EFEF`) |
| Text | `textPrimary`, `textSecondary`, `textTertiary`, `textInverse`, `textDisabled` |
| Text semantic | `textBrand`, `textDanger`, `textWarning`, `textSuccess`, `textInfo`, `textInfoPrimary` |
| Background | `bgPrimary` (white), `bgSecondary`, `bgTertiary`, `bgInverse` (dark) |
| Background semantic | `bgBrand`, `bgDanger`, `bgWarning`, `bgSuccess`, `bgInfo`, `bgInfoPrimary` |
| Border | `borderPrimary`, `borderSecondary`, `borderTertiary`, `borderBrand`, `borderInfo`, … |
| Icon | `iconPrimary`, `iconSecondary`, `iconTertiary`, `iconDisabled`, `iconBrand`, … |
| Solid | `bgBlackSolid` |

### `lib/core/textstyles.dart` — AppTextStyles

All typography is defined here using Roboto with consistent weights, sizes, line heights, and letter spacing. The naming convention is `[scale][Size][Emphasized?]`.

| Scale | Sizes | Notes |
|---|---|---|
| `display` | Large, Medium, Small | Largest text, hero headings |
| `headline` | Large, Medium, Small | Section headings |
| `title` | Large, Medium, Small | Card and panel titles |
| `label` | Large, Medium, Small | Buttons, badges, metadata |
| `body` | Large, Medium, Small | Paragraph and description text |

Each size has an `Emphasized` variant (heavier font weight). Example: `AppTextStyles.titleSmallEmphasized`.

### `lib/core/helper.dart` — Global State

```dart
final ValueNotifier<StudentEntity> currentStudent = ValueNotifier(StudentEntity(...));
```

A global `ValueNotifier` that holds the currently authenticated student. Set immediately after a successful login or OTP verification. Used where the full Provider tree is unavailable.

### `lib/core/urls.dart` — API Constants

```dart
class ApiConstants {
  static const String authBaseUrl = 'http://18.171.208.170:4040/';
}

String loginEndpoint        = 'student-auth/login/';
String sendOtpEndPoint      = 'student-auth/login/with-otp/';
String securityQuestionEndpoint = 'student-auth/security-questions';
String changePasswordEndpoint   = 'student-auth/change-password';
String profileEndpoint          = 'student-auth/profile';
```

---

## State Management

The app uses **Provider** (`ChangeNotifier`) for all reactive UI state. There are two providers, each scoped to its own feature domain.

### AuthenticationProvider

File: `lib/providers/authentication_provider.dart`

Manages authentication state and persists the logged-in student to `SharedPreferences`.

**State properties:**

| Property | Type | Description |
|---|---|---|
| `student` | `StudentEntity?` | Currently authenticated student |
| `isLoading` | `bool` | True while any async call is in progress |
| `errorMessage` | `String?` | Last error string from a failed API call |
| `tempPassword` | `String?` | Held temporarily during account activation flow |
| `securityQuestions` | `List<SecurityQuestionEntity>` | Loaded for the account activation dropdown |

**Methods:**

| Method | Description |
|---|---|
| `loadSavedStudent()` | Called at app start. Reads student JSON from SharedPreferences and restores session. |
| `login(context, payload)` | Calls the login use case. On MFA-disabled success, saves student and updates `currentStudent`. |
| `loginOtp(context, payload)` | Verifies OTP. On success, saves student token and clears `tempPassword`. |
| `getSecurityQuestions()` | Fetches the list of security questions for account activation. |
| `changePassword(context, payload)` | Submits a new password. Clears `tempPassword` on success. |
| `logout()` | Clears SharedPreferences and resets state. |
| `showToast(context, message, isSuccess)` | Injects a `ToastWidget` into the overlay for 3 seconds. |

**Persistence strategy:**

```
login success
  └─► jsonEncode(StudentEntity) ──► SharedPreferences key: 'saved_student'

app restart
  └─► SharedPreferences.getString('saved_student')
        └─► StudentEntity.fromJson() ──► student, currentStudent.value
```

### ProfileProvider

File: `lib/providers/profile_provider.dart`

Manages the student's full profile data.

**State properties:**

| Property | Type | Description |
|---|---|---|
| `profile` | `ProfileEntity?` | Full profile data |
| `isLoading` | `bool` | Guard against duplicate requests |
| `errorMessage` | `String?` | Last failure string |

**Methods:**

| Method | Description |
|---|---|
| `getProfile()` | Fetches the full profile. Guards against duplicate concurrent calls with `if (isLoading) return`. |
| `updateProfile(context, payload)` | Submits profile updates. Shows success toast on completion. |

---

## Dependency Injection

File: `lib/injection_container.dart`

Uses **GetIt** as a service locator. All dependencies are registered once at app startup in `main.dart` before `runApp`.

```
GetIt registry
├── AuthenticationProvider    [factory]         ← new instance each time
├── ProfileProvider           [factory]         ← new instance each time
├── AuthenticationUseCase     [lazySingleton]   ← created once, on first access
├── ProfileUseCase            [lazySingleton]
├── AuthenticationRepository  [lazySingleton]   ← registered as abstract interface
└── ProfileRepository         [lazySingleton]   ← registered as abstract interface
```

**Providers** are registered as `factory` so each `ChangeNotifierProvider` wrapping a screen gets a fresh instance. **Use cases** and **repositories** are singletons since they are stateless.

---

## Navigation & Routing

File: `lib/core/router.dart`

The app uses **GoRouter** with a `StatefulShellRoute.indexedStack` for the main bottom navigation, which preserves the state of each tab independently.

### Route map

```
/                               → SplashScreen
/login                          → LoginScreen
/forgot-password                → ForgotPasswordScreen
/account-activate               → AccountActivateScreen  (extra: AuthenticationProvider)
/otp                            → OtpScreen              (extra: {email, provider})

StatefulShellRoute (bottom nav — 5 branches)
├── /explore                    → ExploreScreen
├── /courses                    → CoursesScreen
│   ├── /courses/overview       → CourseDetailScreen     (extra: {title, type, instructor, progress})
│   └── /courses/lesson         → LessonPlayerScreen
├── /exams                      → (placeholder)
├── /inbox                      → (placeholder)
└── /profile                    → ProfileScreen
    ├── profile/personal-info   → PersonalInfoScreen     (extra: ProfileProvider)
    ├── /notifications          → NotificationScreen
    ├── /security               → SecuritySettingsScreen (extra: ProfileProvider)
    └── /privacy                → PrivacySettingScreen
```

### Passing data between routes

GoRouter's `state.extra` is used to pass typed objects. The receiving builder casts immediately:

```dart
// Navigating
context.push('/courses/overview', extra: {
  'title': course.title,
  'instructor': course.instructor,
  'type': course.type,
  'progress': course.progress,
});

// Receiving
builder: (context, state) {
  final extra = state.extra as Map<String, dynamic>;
  return CourseDetailScreen(
    title: extra['title'] as String,
    ...
  );
}
```

### Authentication flow decisions

```
Login success
  ├── isTemporaryPassword == true  →  push /account-activate
  ├── mfaEnabled == true           →  push /otp
  └── normal                       →  go /explore

OTP success                        →  go /explore
```

---

## Features

### Onboarding / Splash

**Screen:** `lib/presentation/onboarding/splash_screen.dart`

Animated splash screen shown at app start. Runs a comet and loader animation while `AuthenticationProvider.loadSavedStudent()` checks for a persisted session. Navigates to `/login` or `/explore` depending on whether a valid session exists.

---

### Authentication

#### Login (`/login`)

**Screen:** `lib/presentation/authentication/screens/login_screen.dart`

- Email + password fields using `RoundedTextField`
- "Remember me" checkbox
- "Forgot password?" link → `/forgot-password`
- Full client-side validation before API call:
  - Empty field check
  - Email regex validation (`^[\w.-]+@[\w.-]+\.\w{2,}$`)
- On success:
  - If `isTemporaryPassword` → push `/account-activate`
  - If `mfaEnabled` → push `/otp` with email and provider
  - Otherwise → `go /explore`
- Loading state disables the sign-in button and shows `CircularProgressIndicator`
- Security banner (shield icon + encryption notice) at the bottom

#### OTP Verification (`/otp`)

**Screen:** `lib/presentation/authentication/screens/otp_screen.dart`

- 4 individual digit input boxes with automatic focus advancement
- Auto-advances to the next box on digit entry; steps back on delete
- `FilteringTextInputFormatter.digitsOnly` enforced on each field
- "Send Again?" resend link
- On success → `go /explore`
- Displays the email address the code was sent to via `widget.email`

#### Account Activation (`/account-activate`)

**Screen:** `lib/presentation/authentication/screens/account_activate_screen.dart`

Used when a student logs in with a temporary password (`isTemporaryPassword == true`).

- Security question dropdown (loaded from `getSecurityQuestions()`)
- New password field with real-time strength indicator
- Password rules enforced client-side:
  - Minimum 8 characters
  - At least one uppercase letter
  - At least one lowercase letter
  - At least one number
  - At least one special character

#### Forgot Password (`/forgot-password`)

**Screen:** `lib/presentation/authentication/screens/forgot_password_screen.dart`

Email input form for initiating a password reset flow.

#### Authentication Widgets

| Widget | Description |
|---|---|
| `RoundedTextField` | Custom `TextField` wrapper with icon, hint, obscure toggle, background color, and border radius |
| `RoundedCheckbox` | Styled checkbox with custom border color |
| `RoundedDropDown` | Dropdown with rounded styling, used for security questions |
| `ToastWidget` | Overlay notification shown for 3 seconds. Green for success, red for error. Injected via `Overlay.of(context)` |

---

### Dashboard / Explore

**Route:** `/explore`  
**Screen:** `lib/presentation/dashboard/screens/explore_screen.dart`

The home screen after login. Displays a summary of the student's activity.

**Widgets:**

| Widget | Description |
|---|---|
| `StatCardWidget` | Displays a KPI stat with an icon, number, and label (e.g. "3 Active Courses") |
| `CourseProgressCardWidget` | Shows a course with a progress bar, percentage, and last activity timestamp |
| `AssignmentCardWidget` | Shows an upcoming assignment with due date and course name |

---

### Courses

#### Course List (`/courses`)

**Screen:** `lib/presentation/course/screens/courses_screen.dart`

- Three filter tabs: **Active**, **Completed**, **Withdrawn**
- Each course shown in a `CourseCardWidget` with title, instructor, type badge, and progress
- Tapping a card navigates to `/courses/overview` passing title, type, instructor, and progress via `state.extra`

#### Course Detail (`/courses/overview`)

**Screen:** `lib/presentation/course/screens/course_detail_screen.dart`

The main course page. Uses a `TabController` with 4 tabs rendered inside a single `SingleChildScrollView` — the entire screen (header + tab bar + content) scrolls as one unit.

**Architecture note:** Tab content widgets (`CourseOverviewTab`, `CourseModulesTab`, etc.) are `Padding` + `Column` — they do NOT have their own scroll. They flow into the parent `SingleChildScrollView`. This is the single-scroll pattern.

```
CourseDetailScreen (StatefulWidget)
├── SingleChildScrollView
│   └── Column
│       ├── Course header (image, title, progress bar, AnimatedSize progress card)
│       ├── TabBar (4 tabs)
│       └── Conditional content:
│           ├── if _currentTab == 0 → CourseOverviewTab
│           ├── if _currentTab == 1 → CourseModulesTab
│           ├── if _currentTab == 2 → CourseMaterialsTab
│           └── if _currentTab == 3 → CourseVideosTab
```

Tab switching uses `TabController` with an `indexIsChanging` guard to prevent double setState:
```dart
_tabController.addListener(() {
  if (!_tabController.indexIsChanging) return;
  setState(() => _currentTab = _tabController.index);
});
```

**Tabs:**

**1. Overview Tab** — `CourseOverviewTab` (`course_overview_screen.dart`)

- About section with course description
- Stats row (duration, enrolled students, difficulty level)
- "What you'll learn" section with green checkmark bullet points
- Instructor card with name, title, and avatar
- Resume button

**2. Modules Tab** — `CourseModulesTab` (`course_modules_screen.dart`, `StatefulWidget`)

Each module is a `ModuleCard` with three states:

| `ModuleStatus` | Appearance |
|---|---|
| `completed` | Green checkmark pill, module info shown |
| `inProgress` | Blue "In Progress" pill, expanded body with resume button + download toggle |
| `locked` | Grey pill, locked message shown |

`InProgressModuleBody` handles the expanded state: resume button, download toggle switch, and "Available offline" label.

**3. Materials Tab** — `CourseMaterialsTab` (`course_materials_screen.dart`)

Three sections:

| Section | Widget | Model |
|---|---|---|
| Core Textbooks | `FileCard` | `MaterialFile` (title, fileType, fileSize) |
| Required Reading | `ReadingCard` | `RequiredReading` (title, description, readTime) |
| External Resources | `ExternalResourceRow` | `ExternalResource` (title, url) |

Each section has a count badge styled with `AppColors.bgWarning`.

**4. Videos Tab** — `CourseVideosTab` (`course_videos_screen.dart`)

Videos grouped by module using `VideoModuleSection`. Each section has a colored accent bar and lists `VideoTile` rows.

`VideoTile` states:

| `VideoStatus` | Thumbnail overlay | Status row |
|---|---|---|
| `watched` | None | Green checkmark + "Watched" |
| `inProgress` | Play circle icon | Blue clock + "In progress" |
| `locked` | Lock icon + dim overlay | Grey + "Next lesson" |

Tapping an unlocked tile navigates to `/courses/lesson` via `context.push('/courses/lesson')`.

---

### Lesson Player

**Route:** `/courses/lesson`  
**Screen:** `lib/presentation/course/screens/lesson_player_screen.dart`

A full-screen experience for watching a lesson. Uses a custom `PreferredSize` AppBar (72px height) with:
- Back button (HeroIcon)
- Course title
- `LinearProgressIndicator` showing overall course progress (65%)
- Bell notification icon

**Video player area:** `AspectRatio(16/10)` dark container with a centered play button, scrubber bar, timestamp, and playback controls (rewind, play/pause, forward, settings).

**Lesson info:** Module label in `AppColors.bgInfo`, lesson title in `headlineSmallEmphasized`, and "Now Playing" status.

**Previous / Next buttons:** `OutlinedButton` (previous) and `ElevatedButton` (next) in a row below the info.

**Inner tabs** (pill-style segmented control):

| Tab | Content |
|---|---|
| **Video** | List of `LessonRow` widgets grouped by `LessonModule`. Shows all lessons in the current module with watched/in-progress/locked status. |
| **Notes** | Note composer (timestamp auto-fills, text field) + list of `NoteCard` widgets with left accent color bar. |
| **Discussion** | List of `CommentTile` widgets (supports one level of replies) + discussion composer with send button. |
| **Resources** | `FileCard` list + `ExternalResourceRow` list + featured `ReadingCard`. Reuses the same widgets and models as `CourseMaterialsTab`. |

**Presentation models used in `LessonPlayerScreen`:**

| Model | Location | Used for |
|---|---|---|
| `VideoLesson` | `models/lesson.dart` | Lesson list in Video tab |
| `LessonModule` | `models/lesson.dart` | Module sections in Video tab |
| `LessonNote` | `models/lesson.dart` | Notes tab cards |
| `DiscussionComment` | `models/lesson.dart` | Discussion tab comments + replies |
| `MaterialFile` | `models/material.dart` | Resources tab file cards |
| `ExternalResource` | `models/material.dart` | Resources tab link rows |
| `RequiredReading` | `models/material.dart` | Resources tab featured reading |

---

### Profile

#### Main Profile (`/profile`)

**Screen:** `lib/presentation/profile/screens/profile_screen.dart`

Calls `ProfileProvider.getProfile()` on `initState`. Displays:
- Avatar with student name and email
- Academic info section (`AcademicInfoWidget`)
- Achievements and certifications (`AchieveSectionWidget`)
- Quick access buttons (`QuickAccessButtonWidget`) for navigating to sub-screens

#### Personal Info (`profile/personal-info`)

**Screen:** `lib/presentation/profile/screens/personal_info_screen.dart`

Editable form fields for: first name, last name, phone number, and address. Calls `ProfileProvider.updateProfile()` on save. Receives `ProfileProvider` via `state.extra` for scoped state.

#### Security Settings (`/security`)

**Screen:** `lib/presentation/profile/screens/security_settings_screen.dart`

Change password form with the same strength validation rules as account activation. Receives `ProfileProvider` via `state.extra`.

#### Notification Preferences (`/notifications`)

**Screen:** `lib/presentation/profile/screens/notification_screen.dart`

Toggle controls for various notification categories using `ToggleInfoWidget`.

#### Privacy Settings (`/privacy`)

**Screen:** `lib/presentation/profile/screens/privacy_setting_screen.dart`

Privacy controls for the student account.

---

## Data Layer

### Models

Located in `lib/data/models/`. Each model handles JSON deserialization and converts to its domain entity.

**`StudentModel`**

```dart
// Fields: id, firstName, email, mfaEnabled, isTemporaryPassword, accessToken, refreshToken
factory StudentModel.fromJson(Map<String, dynamic> json)
StudentEntity toEntity()
```

**`ProfileModel`**

```dart
// 17 fields including: id, firstName, lastName, email, bio, profilePhoto,
// joinDate, program, department, year, gpa, credits, advisor, campus
factory ProfileModel.fromJson(Map<String, dynamic> json)
ProfileEntity toEntity()
```

**`ProfilePhotoModel`**

```dart
// Fields: path, mimetype, size, originalname
```

**`SecurityQuestionModel`**

```dart
// Fields: id, question
SecurityQuestionEntity toEntity()
```

### Repository Implementations

**`AuthenticationRepositoryImpl`** — `lib/data/repositories/authentication_repository_impl.dart`

Implements `AuthenticationRepository`. Makes HTTP calls, deserializes responses using model `fromJson`, and wraps results in `Either<String, Entity>`.

| Method | Endpoint | Returns |
|---|---|---|
| `login(payload)` | `POST student-auth/login/` | `Either<String, StudentEntity>` |
| `loginOtp(payload)` | `POST student-auth/login/with-otp/` | `Either<String, StudentEntity>` |
| `getSecurityQuestions()` | `GET student-auth/security-questions` | `Either<String, List<SecurityQuestionEntity>>` |
| `changePassword(payload)` | `POST student-auth/change-password` | `Either<String, String>` |

**`ProfileRepositoryImpl`** — `lib/data/repositories/profile_repository_impl.dart`

| Method | Endpoint | Returns |
|---|---|---|
| `getProfile()` | `GET student-auth/profile` | `Either<String, ProfileEntity>` |
| `updateProfile(payload)` | `PUT student-auth/profile` | `Either<String, String>` |

---

## Domain Layer

### Entities

Located in `lib/domain/entities/`. Pure Dart classes with no Flutter dependencies.

**`StudentEntity extends Equatable`**

```dart
final String id;
final String firstName;
final String? email;
final bool mfaEnabled;
final bool isTemporaryPassword;
final String? accessToken;
final String? refreshToken;
```

**`ProfileEntity`**

Full student profile with `String get fullName => '$firstName $lastName'` convenience getter. Contains 17 fields covering personal, academic, and account information.

**`SecurityQuestionEntity`**

```dart
final String id;
final String question;
```

### Repository Interfaces

Abstract classes in `lib/domain/repositories/`. The domain layer defines the contract; the data layer provides the implementation.

```dart
abstract class AuthenticationRepository {
  Future<Either<String, StudentEntity>> login(Map<String, dynamic> payload);
  Future<Either<String, StudentEntity>> loginOtp(Map<String, dynamic> payload);
  Future<Either<String, List<SecurityQuestionEntity>>> getSecurityQuestions();
  Future<Either<String, String>> changePassword(Map<String, dynamic> payload);
}

abstract class ProfileRepository {
  Future<Either<String, ProfileEntity>> getProfile();
  Future<Either<String, String>> updateProfile(Map<String, dynamic> payload);
}
```

### Use Cases

Located in `lib/domain/usecases/`. Thin orchestration layer — each method delegates directly to the repository. Provides a clear, named API for the presentation layer.

```dart
class AuthenticationUseCase {
  Future<Either<String, StudentEntity>> login(payload)
  Future<Either<String, StudentEntity>> loginOtp(payload)
  Future<Either<String, List<SecurityQuestionEntity>>> getSecurityQuestions()
  Future<Either<String, String>> changePassword(payload)
}

class ProfileUseCase {
  Future<Either<String, ProfileEntity>> getProfile()
  Future<Either<String, String>> updateProfile(payload)
}
```

---

## Design System

### Responsive Sizing (Sizer)

The `sizer` package provides screen-relative units. All spacing and sizing uses these values consistently across the app:

| Sizer value | Approximate px | Common use |
|---|---|---|
| `0.3.h` | ~2px | Tight padding |
| `0.5.h` | ~4px | Between label and field |
| `0.8.h` | ~6px | Small gap |
| `1.h` | ~8px | Standard inner gap |
| `1.25.h` | ~10px | Action row gap |
| `1.5.h` | ~12px | Between sections (small) |
| `1.75.h` | ~14px | Card inner padding |
| `2.h` | ~16px | Standard section gap |
| `2.5.h` | ~20px | Between major blocks |
| `15.h` | ~120px | Bottom padding for tab content (clears nav bar) |
| `1.5.w` | ~6px | Icon-to-text gap |
| `3.w` | ~12px | Avatar-to-content gap |
| `3.5.w` | ~14px | Thumbnail-to-text gap |
| `4.w` | ~16px | Icon row spacing |
| `8.w` | ~32px | Reply indentation in discussion |

### Color Palette

| Color | Hex | Usage |
|---|---|---|
| `primary` | `#013E5B` | Brand color, buttons, active states |
| `pill` | `#90EFEF` | Accent chips |
| `bgInfo` | `#3A82F6` | Info badges, in-progress indicators |
| `bgSuccess` | `#22C55E` | Watched/completed indicators |
| `bgWarning` | `#F59E0B` | Section count badges, warnings |
| `bgDanger` | `#EF4444` | Error states |

### Typography Scale

All text uses **Roboto**. The scale follows Material Design 3 naming conventions extended with Emphasized variants:

| Scale | Size range | Usage |
|---|---|---|
| `display` | 57/45/36px | Hero text |
| `headline` | 32/28/24px | Page headings |
| `title` | 22/16/14px | Card titles, section headers |
| `label` | 14/12/11px | Buttons, chips, metadata |
| `body` | 16/14/12px | Paragraphs, descriptions |

Each size has an `Emphasized` variant with heavier font weight. Example: `AppTextStyles.titleSmallEmphasized`.

---

## API Reference

**Base URL:** `http://18.171.208.170:4040/`

| Method | Path | Description | Auth required |
|---|---|---|---|
| `POST` | `student-auth/login/` | Email + password login | No |
| `POST` | `student-auth/login/with-otp/` | OTP verification | No |
| `GET` | `student-auth/security-questions` | Fetch security questions list | No |
| `POST` | `student-auth/change-password` | Submit new password | Yes |
| `GET` | `student-auth/profile` | Get full student profile | Yes |
| `PUT` | `student-auth/profile` | Update student profile | Yes |

Authenticated requests include the `accessToken` from `currentStudent.value.accessToken`.

---

## Getting Started

### Prerequisites

- Flutter SDK — Channel stable, **3.41.7** (darwin-arm64)
- Dart SDK `^3.9.2`
- FVM (Flutter Version Manager) recommended — project uses `fvm flutter` commands
- Android Studio / Xcode for device emulation

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd educateu

# Install dependencies
flutter pub get
# or with FVM:
fvm flutter pub get

# Run on a device or emulator
flutter run
# or with FVM:
fvm flutter run
```

### Running on a specific platform

```bash
fvm flutter run -d android
fvm flutter run -d ios
fvm flutter run -d chrome   # Web
```

### Build

```bash
# Android APK
fvm flutter build apk --release

# Android App Bundle
fvm flutter build appbundle --release

# iOS
fvm flutter build ios --release
```

### Environment

The API base URL is hardcoded in `lib/core/urls.dart`. To point to a different backend, update `ApiConstants.authBaseUrl`.

---

## Key Architectural Decisions

**Why Clean Architecture?**  
Separating domain logic from data sources and UI makes the authentication and profile features independently testable. Swapping the HTTP implementation (e.g., for a mock in tests) only requires replacing the repository implementation registered in `injection_container.dart`.

**Why single-scroll instead of `TabBarView` in course detail?**  
`TabBarView` creates independent scroll contexts per tab, which means the tab bar scrolls out of view independently of the content. The single `SingleChildScrollView` wrapping both the tab bar and conditional tab content gives a native "sections of a page" feel where everything moves together.

**Why `state.extra` for route data instead of path params?**  
Course and profile data are typed objects (`CourseDetailScreen` takes 4 typed params). Path params are strings only and require reparsing. `state.extra` passes the exact types with no serialization overhead, at the cost of not supporting deep-linking to those routes.

**Why `factory` for providers in GetIt?**  
Providers hold mutable state tied to a user session. Using `factory` ensures each `ChangeNotifierProvider` wrapping a screen gets a fresh instance, preventing stale state from a previous navigation session bleeding into a new one.

**Why are presentation models separate from domain entities?**  
Features like the course video list, lesson player, and notes are currently static/UI-only. Their models (`VideoModule`, `LessonNote`, `DiscussionComment`) live in `presentation/course/models/` rather than the domain layer to avoid polluting the domain with UI-specific structures that have no backend contract yet. When the API for these features is built, the models will be promoted to the domain layer.
