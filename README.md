# Ai Chat Bot🧙‍♂️

A Flutter-based social skills enhancement application that helps users improve their conversation abilities using AI-powered features.

## 📱 Features

- **Break the Ice Smoothly**: Get AI-generated conversation starters and ice-breaker suggestions
- **Handle the Curveballs**: Receive intelligent responses to handle awkward or challenging social situations
- **Image-based Context**: Upload images to get context-aware conversation suggestions
- **Multi-platform Support**: Android, iOS, Windows, Linux, macOS, and Web

## 🚀 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.5.4 or higher): [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Comes bundled with Flutter
- **Git**: [Install Git](https://git-scm.com/downloads)

### Platform-Specific Requirements

#### Android
- **Android Studio**: [Download](https://developer.android.com/studio)
- **Android SDK**: API Level 21 or higher
- **Java Development Kit (JDK)**: Version 11 or higher

#### iOS (macOS only)
- **Xcode**: Version 13 or higher
- **CocoaPods**: `sudo gem install cocoapods`
- **macOS**: 10.15 (Catalina) or higher

#### Windows
- **Visual Studio 2022**: With "Desktop development with C++" workload
- **Windows 10 SDK**: Version 10.0.17763.0 or higher

#### Linux
- **Clang**
- **CMake**
- **GTK 3.0 development libraries**
- **Ninja build system**

```sh
sudo apt-get install clang cmake ninja-build libgtk-3-dev
```

## 📦 Installation

1. **Clone the repository**
   ```sh
   git clone <repository-url>
   cd social_wizard_app-main
   ```

2. **Install dependencies**
   ```sh
   flutter pub get
   ```

3. **Verify Flutter installation**
   ```sh
   flutter doctor
   ```
   Address any issues reported by Flutter Doctor before proceeding.

## ⚙️ Configuration

### API Configuration

The app communicates with a backend API for chatbot functionality.

**Default API Endpoint**: `http://206.162.244.175:8056/api/chatbot/chat`

To change the API endpoint, update the following files:

1. **Break the Ice Module**
   ```dart
   // filepath: lib/app/modules/break_the_ice_smooth/controllers/break_the_ice_smooth_modules_controller.dart
   // Line ~195
   final url = Uri.parse('YOUR_API_ENDPOINT');
   ```

2. **Handle Curveballs Module**
   ```dart
   // filepath: lib/app/modules/handle_the_curveballs/controllers/handle_the_curveballs_controllers.dart
   // Line ~195
   final url = Uri.parse('YOUR_API_ENDPOINT');
   ```

### Android Configuration

#### Package Name
- **Default**: `com.example.social_wizard_app`
- **Location**: `android/app/build.gradle.kts`

To change:
```kotlin
// filepath: android/app/build.gradle.kts
android {
    namespace = "com.yourcompany.social_wizard_app"
    defaultConfig {
        applicationId = "com.yourcompany.social_wizard_app"
    }
}
```

#### App Name
- **Default**: "Social AI Wizard"
- **Location**: `android/app/src/main/AndroidManifest.xml`

```xml
<!-- filepath: android/app/src/main/AndroidManifest.xml -->
<application
    android:label="Your App Name"
    ...>
</application>
```

#### Signing Configuration (Release Builds)

1. **Create a keystore**:
   ```sh
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. **Create `key.properties`** in the `android` directory:
   ```properties
   storePassword=<your-keystore-password>
   keyPassword=<your-key-password>
   keyAlias=upload
   storeFile=<path-to-your-keystore>
   ```

3. **Update `android/app/build.gradle.kts`** (already configured to use key.properties)

### iOS Configuration

#### Bundle Identifier
- **Default**: `com.example.socialWizardApp`
- **Location**: `ios/Runner.xcodeproj/project.pbxproj`

To change:
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select the Runner target
3. Update Bundle Identifier in the General tab

#### CocoaPods Setup
```sh
cd ios
pod install
cd ..
```

#### App Name
- **Location**: `ios/Runner/Info.plist`
```xml
<key>CFBundleDisplayName</key>
<string>Your App Name</string>
```

### macOS Configuration

#### Bundle Identifier
- **Default**: `com.example.socialWizardApp`
- **Location**: `macos/Runner.xcodeproj/project.pbxproj`

#### CocoaPods Setup
```sh
cd macos
pod install
cd ..
```

### Web Configuration

Update the web app title in:
```html
<!-- filepath: web/index.html -->
<title>Your App Name</title>
```

## 🔨 Building the Project

### Android

#### Debug Build
```sh
flutter build apk --debug
```
📁 Output: `build/app/outputs/flutter-apk/app-debug.apk`

#### Release Build
```sh
flutter build apk --release
```
📁 Output: `build/app/outputs/flutter-apk/app-release.apk`

#### App Bundle (Google Play Store)
```sh
flutter build appbundle --release
```
📁 Output: `build/app/outputs/bundle/release/app-release.aab`

#### Split APKs (Smaller file sizes)
```sh
flutter build apk --split-per-abi --release
```

### iOS

1. **Install CocoaPods dependencies** (if not done):
   ```sh
   cd ios && pod install && cd ..
   ```

2. **Build IPA**:
   ```sh
   flutter build ios --release
   ```

3. **Archive in Xcode** (for App Store):
   ```sh
   open ios/Runner.xcworkspace
   ```
   - Select a real device (not simulator)
   - Product → Archive
   - Distribute App

### Windows

```sh
flutter build windows --release
```
📁 Output: `build/windows/x64/runner/Release/`

### Linux

```sh
flutter build linux --release
```
📁 Output: `build/linux/x64/release/bundle/`

### macOS

```sh
flutter build macos --release
```
📁 Output: `build/macos/Build/Products/Release/`

### Web

```sh
flutter build web --release
```
📁 Output: `build/web/`

## 🏃 Running the App

### Development Mode

```sh
# Run on default device
flutter run

# Run on specific platform
flutter run -d android
flutter run -d ios
flutter run -d windows
flutter run -d linux
flutter run -d macos
flutter run -d chrome

# Run with hot reload
flutter run --hot
```

### List Available Devices
```sh
flutter devices
```

### Run on Specific Device
```sh
flutter run -d <device-id>
```

## 📂 Project Structure

```
social_wizard_app-main/
├── android/              # Android native code
├── ios/                  # iOS native code
├── linux/                # Linux native code
├── macos/                # macOS native code
├── windows/              # Windows native code
├── web/                  # Web configuration
├── lib/                  # Flutter application code
│   ├── app/
│   │   ├── modules/      # Feature modules
│   │   ├── routes/       # App routing
│   │   └── data/         # Data models
│   └── main.dart         # App entry point
├── assets/               # Images, fonts, etc.
├── test/                 # Unit tests
├── pubspec.yaml          # Dependencies
└── README.md             # This file
```

## 🔑 Key Dependencies

- **GetX**: State management and routing
- **HTTP**: API communication
- **File Picker**: Image selection
- **Path Provider**: File system access

See `pubspec.yaml` for complete dependency list.

## 🧪 Testing

```sh
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

## 🐛 Troubleshooting

### Flutter Doctor Issues
```sh
flutter doctor -v
```
Follow the recommendations to resolve any issues.

### Android Build Failures

1. **Clean build**:
   ```sh
   cd android
   ./gradlew clean
   cd ..
   flutter clean
   flutter pub get
   ```

2. **Clear Gradle cache**:
   ```sh
   cd android
   ./gradlew cleanBuildCache
   ```

### iOS Build Issues

1. **Update CocoaPods**:
   ```sh
   cd ios
   pod repo update
   pod install
   cd ..
   ```

2. **Clean Xcode**:
   ```sh
   cd ios
   rm -rf Pods Podfile.lock
   pod install
   cd ..
   flutter clean
   ```

### Windows Build Issues

- Ensure Visual Studio 2022 with C++ development tools is installed
- Run Visual Studio Installer and verify "Desktop development with C++" workload

### Common Issues

1. **"Unable to load asset"**: Run `flutter pub get` and rebuild
2. **API connection errors**: Check your internet connection and API endpoint
3. **Gradle sync failed**: Update Android Studio and Gradle plugin
4. **Pod install failed**: Update CocoaPods: `sudo gem install cocoapods`

## 📱 Supported Image Formats

The app supports the following image formats for context-aware suggestions:
- PNG (.png)
- JPEG (.jpg, .jpeg)
- WebP (.webp)
- HEIC (.heic)
- HEIF (.heif)

## 🔒 Permissions

### Android
- **Internet**: Required for API communication (automatically configured)

### iOS
- **Photo Library**: For image selection (configured in Info.plist)

## 📄 License

[Add your license information here]

## 👥 Contributing

[Add contribution guidelines here]

## 📞 Support

For issues or questions:
- Open an issue on the repository
- Contact: [Add contact information]


## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Contributors and testers

---

Made with ❤️ using Flutter
