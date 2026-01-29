# The Daily Canon — iOS

Native iOS wrapper for [The Daily Canon](https://thedailycanon.org), a curated work of literature every day.

This is a thin [Capacitor](https://capacitorjs.com) shell that loads the deployed web app inside a native iOS WebView. All application logic, content, and styling live in the [web repo](https://github.com/wallcache/the_daily_canon) — this repo handles only native concerns: the Xcode project, app icon, splash screen, and App Store configuration.

## Architecture

```
the_daily_canon        → Next.js web app, deployed to Vercel, serves the PWA
the_daily_canon_ios    → This repo. Capacitor wrapper, Xcode project, native config
```

The iOS app points at `https://thedailycanon.org` at runtime. When you ship a web update to Vercel, every iOS user gets it immediately — no App Store review needed.

## Project Structure

```
the_daily_canon_ios/
├── capacitor.config.ts                 # Capacitor config (app ID, server URL, plugins)
├── package.json                        # Dependencies (Capacitor core + plugins)
├── tsconfig.json
├── www/
│   └── index.html                      # Minimal fallback shell (shown before remote loads)
└── ios/
    └── App/
        ├── App.xcworkspace             # Open this in Xcode
        ├── App.xcodeproj/
        ├── Podfile                     # CocoaPods dependencies
        └── App/
            ├── AppDelegate.swift       # Native entry point
            ├── Info.plist              # Bundle config (portrait-locked on iPhone)
            ├── capacitor.config.json   # Compiled Capacitor config
            ├── Assets.xcassets/
            │   ├── AppIcon.appiconset/ # App icon (1024x1024)
            │   └── Splash.imageset/    # Launch screen image
            └── Base.lproj/
                ├── LaunchScreen.storyboard
                └── Main.storyboard
```

## Configuration

| Key | Value |
|-----|-------|
| **Bundle ID** | `org.thedailycanon.app` |
| **App Name** | The Daily Canon |
| **Remote URL** | `https://thedailycanon.org` |
| **Background** | `#FAF9F6` (cream) |
| **Orientation** | Portrait (iPhone), all (iPad) |

### Capacitor Plugins

- **SplashScreen** — cream background, auto-hides with 300ms fade
- **StatusBar** — dark text on cream background
- **Keyboard** — body resize mode for form inputs

## Prerequisites

- **Xcode** (full app, not just Command Line Tools)
- **CocoaPods** — `sudo gem install cocoapods`
- **Node.js** 18+
- An Apple Developer account for signing and distribution

## Getting Started

```bash
# 1. Clone
git clone https://github.com/wallcache/the_daily_canon_ios.git
cd the_daily_canon_ios

# 2. Install dependencies
npm install

# 3. Ensure Xcode is the active developer tool
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# 4. Install CocoaPods dependencies
cd ios/App && pod install && cd ../..

# 5. Open in Xcode
npx cap open ios
```

In Xcode:
1. Select the **App** target
2. Under **Signing & Capabilities**, set your Team and Bundle Identifier
3. Select a simulator or connected device
4. Hit **Run** (Cmd+R)

## Common Commands

```bash
# Sync Capacitor config + plugins to the Xcode project
npx cap sync ios

# Open the Xcode workspace
npx cap open ios

# Update Capacitor plugins after changing capacitor.config.ts
npx cap update ios
```

## Customisation

### Changing the Remote URL

Edit `capacitor.config.ts`:

```ts
server: {
  url: 'https://your-new-url.com',
},
```

Then run `npx cap sync ios` to propagate the change.

### App Icon

Replace the file at:
```
ios/App/App/Assets.xcassets/AppIcon.appiconset/AppIcon-512@2x.png
```
with a **1024x1024** PNG. Xcode generates all smaller sizes automatically.

### Splash Screen

Replace the images in:
```
ios/App/App/Assets.xcassets/Splash.imageset/
```
or customise `Base.lproj/LaunchScreen.storyboard` in Xcode.

## App Store Submission

Before submitting:

- [ ] Set the correct **Bundle ID** in Xcode (must match App Store Connect)
- [ ] Configure **signing** with a distribution provisioning profile
- [ ] Replace the default splash screen images
- [ ] Add **App Store screenshots** (6.7", 6.5", 5.5" iPhones + iPad)
- [ ] Write App Store **description**, **keywords**, and **privacy policy URL**
- [ ] Set **version number** and **build number** in Xcode
- [ ] Archive and upload via **Product > Archive** in Xcode
- [ ] Submit for review in [App Store Connect](https://appstoreconnect.apple.com)

## Adding Native Features

To add native capabilities (push notifications, haptics, etc.), install the relevant Capacitor plugin:

```bash
npm install @capacitor/push-notifications
npx cap sync ios
```

Then enable the matching capability in Xcode under **Signing & Capabilities > + Capability**.

See the [Capacitor plugin directory](https://capacitorjs.com/docs/plugins) for all available plugins.

## Related

- **Web app** — [github.com/wallcache/the_daily_canon](https://github.com/wallcache/the_daily_canon)
- **Live site** — [thedailycanon.org](https://thedailycanon.org)
- **Capacitor docs** — [capacitorjs.com/docs](https://capacitorjs.com/docs)
