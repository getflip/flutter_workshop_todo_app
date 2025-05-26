# Flutter Todo Workshop

This is a workshop application for Flutter developers to learn about clean architecture, data handling, and state management.

## Environment Setup

### Prerequisites
Before starting, make sure you have the following installed:

- An IDE (VS Code, Android Studio, or IntelliJ)
  - If using VS Code, install the [Flutter extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) for Flutter development support
- Platform-specific requirements:
  - For iOS development:
    - Xcode (Mac only)
    - iOS Simulator (comes with Xcode)
  - For Android development:
    - Android Studio
    - Android SDK
    - Android Emulator (can be set up through Android Studio)

For more detailed installation instructions, visit the [official Flutter installation guide](https://docs.flutter.dev/get-started/install). We'll show you how to install the Flutter SDK in the next section.

### Setting Up Flutter Using FVM (Flutter Version Management)

We recommend using FVM (https://fvm.app/) to manage your Flutter SDK versions, which makes it easier to manage multiple Flutter versions and switch between them effortlessly.

1. **Install FVM**:
   ```bash
   # Using Homebrew (Mac)
   brew tap leoafarias/fvm
   brew install fvm
   
   ```

2. **Install Flutter using FVM**:
   ```bash
   # Install Flutter version 3.29.2
   fvm install 3.29.2
   
   # Set it as the default
   fvm global 3.29.2
   ```

3. **Verify Installation**:
   ```bash
   fvm flutter --version
   ```

### Setting Up the Project

1. **Get dependencies**:
   ```bash
   fvm flutter pub get
   ```

2. **Generate code**:
   ```bash
   fvm flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Run the application**:
   ```bash
   fvm flutter run
   ```

## Application Structure

The application follows a feature-first layered architecture:

```
lib/
├── core/                     # Core functionality
│   └── di/                   # Dependency injection setup
├── features/
│   └── todo/                 # Todo feature
│       ├── data/             # Data layer
│       │   ├── datasources/  # Remote and local data sources
│       │   ├── models/       # DTOs (Data Transfer Objects)
│       │   └── repositories/ # Repository implementations
│       ├── domain/           # Domain layer
│       │   └── models/       # Domain entities/models
│       └── presentation/     # Presentation layer
│           ├── cubits/       # State management with Cubit
│           ├── screens/      # UI screens
│           └── widgets/      # Reusable widgets
```

## Architecture Overview

1. **Domain Layer** - Contains the business logic and entities (TodoModel).
2. **Data Layer** - Handles data operations:
   - DTOs (Data Transfer Objects) - Model the raw API response
   - Data Sources - Fetch data from API or local storage
   - Repositories - Convert DTOs to domain models and coordinate between data sources
3. **Presentation Layer** - Handles UI and user interactions:
   - Cubits - Manage state (using flutter_bloc package)
   - Screens - The main screens of the app
   - Widgets - Reusable UI components


## Workshop Tasks

1. **Implementing Description and Image for Todos**
   - Study the API response to understand the structure
   - Add description and imageUrl fields to TodoDTO and TodoModel
   - Update TodoRemoteDataSource, TodoRepository and TodoCubit to handle the new fields
   - Modify the UI to display changes: Show the imageurl as a thumbnail and limit the description to max two lines

2. **Implementing "Complete" Feature**
   - Modify the necessary layers, files, and classes to capture the isDone status from the API.  
   - Add the functionality to toggle a todo in the UI and also update the data in the backend to reflect those changes.

4. **Bonus: Additional improvements (pick the ones you want)**
   - Improve the TodoFormScreen, so the user optionally can add description and imageUrl to their Todo when they create one
   - Implement the "Favourite" feature, where you can locally save the favorited todos. Tip: You can use TodoLocalDataSource.  
   - Implement a todo detail page when the user taps on a todo to show the image bigger and with the full description.  
   - Implement a delete Todo functionality, where the user can delete todos on the list and also update the data in the backend to reflect those changes.

## Dependencies

- **State Management & Architecture**
  - flutter_bloc: State management using BLoC pattern
  - equatable: Value equality for objects
  - injectable + get_it: Dependency injection
  - injectable_generator: Code generation for dependency injection

- **Data Handling**
  - http: API requests
  - shared_preferences: Local storage
  - uuid: Generating unique IDs

- **Code Generation & Serialization**
  - freezed: Immutable classes and union types
  - freezed_annotation: Annotations for freezed
  - json_annotation: Annotations for JSON serialization
  - json_serializable: Code generation for JSON serialization
  - build_runner: Code generation tool

- **UI & Utilities**
  - intl: Internationalization and formatting
  - cupertino_icons: iOS-style icons

- **Development**
  - flutter_lints: Recommended lints for Flutter apps

