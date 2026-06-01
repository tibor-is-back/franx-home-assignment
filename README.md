# Franx / ABN AMRO Home Assignment

This repository contains the iOS home assignment for Franx / ABN Amro. The **Places** companion app and a modified **Wikipedia** app.

## Repository structure

- **`places/`** — Companion app that opens Wikipedia at a chosen location via deep link.
- **`wikipedia-ios/`** — [Wikipedia iOS](https://github.com/wikimedia/wikipedia-ios) fork. 
- **`images/`** — Feature showcase GIFs. 

## Places app

### App features

* Downloads a list of locations according to the assignment; handles edge cases such as errors or an empty list
* Lets users enter coordinates manually on a separate screen
* Opens the Wikipedia app when available; shows an error if the Wikipedia app is not available

#### Feature Showcase

**Places list**

![Places list](https://raw.githubusercontent.com/tibor-is-back/franx-home-assignment/main/images/list.gif)

**Manual coordinates**

![Manual place](https://raw.githubusercontent.com/tibor-is-back/franx-home-assignment/main/images/manual.gif)

**Wikipedia app not installed**

![Wikipedia app not installed](https://raw.githubusercontent.com/tibor-is-back/franx-home-assignment/main/images/nowikiapp.gif)

### Implementation details

#### Features

* Written in Swift 6.2 (with Approachable concurrency) and the default project settings of Xcode 26.4
* Uses MVVM + Layered architecture (Presentation, Domain, Data)
* Dependency injection throughout the application
* Async/await-based implementation
* Comprehensive error handling and retry support
* Unit tests for business logic and data layers
* UI tests covering all user flows
* Accessibility audit tests for all flows
* Separate design system implementation for reusable UI components

#### Developer Remarks

* No unit tests were added for the service layer, as mocking `URLProtocol` and `UIApplication` would add significant overhead for a small assignment
* No use case layer was introduced because it would not contain any business logic
* View data mapping in `PlacesViewModel` is performed after the `await` call. The operation is O(n) on a small dataset, but could be moved to a nonisolated context if the processing became more expensive

#### Project folder structure

```
places/
├── Places.xcodeproj
├── Supporting/                 # Info.plist
├── Test Plans/
│   ├── UnitTests.xctestplan
│   ├── UITests.xctestplan
│   └── AccessibilityTests.xctestplan
├── Places/
│   ├── PlacesApp.swift
│   ├── Core/                   # DI, constants, networking, deep links, UI-test stubs
│   ├── Features/Places/
│   │   ├── PlacesList/         # View, ViewModel, ViewData, PreviewData
│   │   ├── ManualPlace/        # View, ViewModel, PreviewData
│   │   └── Services/LocationService/
│   ├── UI/                     # DesignSystem, CommonElements, PreviewData helpers
│   └── Resources/              # Assets, launch screen
├── PlacesTests/
│   ├── Features/Places/
│   └── Services/
└── PlacesUITests/
    ├── Places/
    ├── Accessibility/
    └── Helpers/
```

#### Targets

| Target | Role |
|--------|------|
| **Places** | SwiftUI app: locations list, manual coordinates, Wikipedia deep links |
| **PlacesTests** | Unit tests (view models, continent logic, location service) |
| **PlacesUITests** | UI tests and accessibility audits (via test plans) |

#### Testing

| Test plan | Role |
|-----------|------|
| **UnitTests** | View models, services, and helpers |
| **UITests** | PlacesView states and ManualPlaceView flows |
| **AccessibilityTests** | Accessibility audit on all screens |

## Wikipedia app

### New Features

Adds coordinate deep links to Places:

```
wikipedia://places?latitude=<lat>&longitude=<lon>
```

- Parse `latitude` / `longitude` in `NSUserActivity+WMFExtensions`
- Route in `WMFAppViewController` → `PlacesViewController.showLocation`
- Range validation in `showLocation`; docs in `docs/url_schemes.md`

**Tests:** `WikipediaUnitTests/Code/NSUserActivity+WMFExtensionsTest.m` (URL parsing).

#### Testing

Run Wikipedia on a **simulator or device**, then open a deep link:

```
wikipedia://places?latitude=51.5074&longitude=-0.1278   # London
```

**Safari or Notes** — paste a link and tap it (works on simulator and device).

**Simulator (bash):**

Run Wikipedia on the simulator, then in the terminal run one of the following commands:

```bash
# London
xcrun simctl openurl booted "wikipedia://places?latitude=51.5074&longitude=-0.1278"
```

## End-to-end test

Use the **same simulator or iPhone** for both apps.

1. Build and run **Wikipedia** from `wikipedia-ios/Wikipedia.xcodeproj` (Wikipedia scheme).
2. Build and run **Places** from `places/Places.xcodeproj` (Places scheme).
3. In **Places**, pick a location from the list or enter coordinates on the manual screen.
4. Wikipedia should open on the **Places** tab and centre the map on that location (not your current GPS position).

If Wikipedia is not installed on that simulator or device, Places shows an error instead.

## Usage of AI

AI-assisted tools (Cursor and Codex) were used for the following tasks:
* Generating SwiftUI preview data
* Helping write unit and UI tests
* Assisting with general refactoring
* Generating simple code snippets for trivial parts