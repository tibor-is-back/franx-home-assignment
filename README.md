# Franx / ABN AMRO Home Assignment

iOS home assignment: a **Places** companion app and a modified **Wikipedia** app.

## Folders

- **`places/`** — Companion app that opens Wikipedia at a chosen location via deep link.
- **`wikipedia-ios/`** — [Wikipedia iOS](https://github.com/wikimedia/wikipedia-ios) fork. 

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

### Testing

Run Wikipedia on a **simulator or device**, then open a deep link:

```
wikipedia://places?latitude=51.5074&longitude=-0.1278   # London
wikipedia://places?latitude=52.3676&longitude=4.9041   # Amsterdam
```

**Safari or Notes** — paste a link and tap it (works on simulator and device).

**Simulator (bash):**

Run Wikipedia on the simulator then in the terminal run one of the following commands:

```bash
# London
xcrun simctl openurl booted "wikipedia://places?latitude=51.5074&longitude=-0.1278"
# Amsterdam
xcrun simctl openurl booted "wikipedia://places?latitude=52.3676&longitude=4.9041"
```
