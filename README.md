# GymApp — iOS Gym Exercise Application

A SwiftUI iOS app that collects basic user information and generates a personalised weekly workout routine and diet plan.

---

## Features

- **4-step onboarding** – name, age, weight, height → fitness goal → training level → muscle training style
- **Custom workout routine** – 7-day plan (bro-split, Push/Pull/Legs, or full-body) based on your preferences
- **Personalised diet plan** – calorie target, macro breakdown, 5-meal schedule, hydration goal, and nutrition tips
- **Expandable cards** – tap any workout day or meal to see full details and exercise instructions

---

## Requirements

| Tool | Minimum Version |
|---|---|
| macOS | **Ventura 13.0** or later |
| Xcode | **15.0** or later |
| iOS Simulator / Device | **iOS 17.0** or later |

> **Note:** Xcode is only available on macOS. You cannot build or run this app on Windows or Linux.

---

## Setup & Run

### 1. Clone the repository

```bash
git clone https://github.com/techpramit/gymapp.git
cd gymapp
```

### 2. Open the project in Xcode

```bash
open GymApp/GymApp.xcodeproj
```

Or open Xcode manually, choose **File → Open**, and select `GymApp/GymApp.xcodeproj`.

### 3. Select a simulator or device

In the Xcode toolbar, click the **device picker** (next to the run button) and choose an iPhone simulator such as:

- iPhone 15 Pro
- iPhone 16

If you want to run on a **physical device**:
1. Plug in your iPhone via USB.
2. Select your device from the device picker.
3. In the project settings (**GymApp target → Signing & Capabilities**), enable **Automatically manage signing** and select your Apple ID team.

### 4. Build and run

Press **⌘ R** (or click the ▶ Run button).

Xcode will build the app and launch it in the chosen simulator or on your device.

---

## Running the Tests

### In Xcode

Press **⌘ U** (or go to **Product → Test**).

All 21 unit tests covering the routine generator and diet plan generator will run and results will appear in the Test Navigator.

### From the command line (macOS only, requires Xcode Command Line Tools)

```bash
cd GymApp
xcodebuild test \
  -project GymApp.xcodeproj \
  -scheme GymApp \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=latest' \
  | xcpretty   # install with: gem install xcpretty
```

---

## Project Structure

```
GymApp/
├── GymApp.xcodeproj/           # Xcode project
└── GymApp/
    ├── GymAppApp.swift          # App entry point (@main)
    ├── ContentView.swift        # Screen navigator (Welcome → Onboarding → Results)
    ├── Models.swift             # Data models & UserProfile ObservableObject
    ├── ExerciseData.swift       # Exercise database (all muscle groups × 3 levels)
    ├── Generators.swift         # RoutineGenerator & DietPlanGenerator services
    ├── OnboardingViews.swift    # 4-step onboarding flow
    ├── ResultViews.swift        # Routine & Diet Plan result screens
    └── Assets.xcassets/        # App icon & accent colour
GymAppTests/
    └── GymAppTests.swift        # 21 unit tests
```

---

## Troubleshooting

| Problem | Fix |
|---|---|
| *"No such module 'SwiftUI'"* | Make sure you are using Xcode 15+ and the iOS 17 SDK. |
| *Signing error on device* | Go to **GymApp target → Signing & Capabilities**, enable **Automatically manage signing**, and pick your Apple ID. |
| *Simulator not listed* | Open **Xcode → Settings → Platforms** and download the iOS 17 simulator runtime. |
| *Build fails after pull* | In Xcode, go to **Product → Clean Build Folder** (⇧⌘K), then build again. |