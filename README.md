# app_permission_manager 🚀

A modern, **federated** Flutter plugin to manage app permissions across all platforms with a simple, unified API.

This plugin helps you **check**, **request**, and **listen** to permission states without dealing with platform-specific complexity.

## 📱 Supported Platforms

| Android | iOS | Web | macOS | Windows | Linux |
|:---:|:---:|:---:|:---:|:---:|:---:|
| ✅ | ✅ | ✅ | ✅ | ✅ | 🚧 |

## ✨ Features

- 🏗 **Federated Architecture**: Built using a modern structure for future-proof multi-platform support.
- ✅ **Multiple Permissions**: Request or check multiple permissions simultaneously.
- 🖼 **Android 13 Media**: Granular support for Images, Video, and Audio (with backward compatibility).
- ⚡ **Real-time Updates**: Listen to permission status changes via a stream.
- 🤖 **Android Specialized**: Support for Battery Optimization, Overlay, and Exact Alarms.
- 🍏 **iOS Parity**: Handles restricted, limited, and not-determined states gracefully.
- 🛠 **Simple API**: Single unified class for all operations.

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  app_permission_manager: ^2.0.0
```

## � Usage

### 🔐 Request a Permission
```dart
import 'package:app_permission_manager/app_permission_manager.dart';

final status = await AppPermissionManager.request(
  AppPermissionManagerPermission.camera,
);

if (status == AppPermissionManagerStatus.granted) {
  // Permission granted
} else if (status == AppPermissionManagerStatus.permanentlyDenied) {
  // Open app settings
  await AppPermissionManager.openAppSettings();
}
```

### � Request Multiple Permissions
```dart
final statuses = await AppPermissionManager.requestMultiple([
  AppPermissionManagerPermission.camera,
  AppPermissionManagerPermission.location,
  AppPermissionManagerPermission.contacts,
]);

print(statuses[AppPermissionManagerPermission.camera]);
```

### 📡 Listen to Status Changes
```dart
AppPermissionManager.statusStream(AppPermissionManagerPermission.camera).listen((status) {
  print('Camera status changed to: $status');
});
```

## 🔍 Supported Permissions

| Permission Enum | Platform Support | Description |
|:--- |:---:|:--- |
| `AppPermissionManagerPermission.camera` | All | Access to camera device |
| `AppPermissionManagerPermission.microphone` | All | Access to microphone/audio recording |
| `AppPermissionManagerPermission.location` | All | Access to device location (While in Use) |
| `AppPermissionManagerPermission.locationAlways` | Android/iOS | Access to background location |
| `AppPermissionManagerPermission.contacts` | All | Access to device contacts |
| `AppPermissionManagerPermission.notifications` | All | System notification access |
| `AppPermissionManagerPermission.photos` | All | Photo library access |
| `AppPermissionManagerPermission.storage` | Android/iOS | General storage access (Gallery/Files) |
| `AppPermissionManagerPermission.phone` | Android | Read phone state |
| `AppPermissionManagerPermission.mediaImages` | Android 13+ | Granular access to images only |
| `AppPermissionManagerPermission.mediaVideo` | Android 13+ | Granular access to video only |
| `AppPermissionManagerPermission.mediaAudio` | Android 13+ | Granular access to audio only |
| `AppPermissionManagerPermission.ignoreBatteryOptimizations` | Android | Requests to bypass battery saving |
| `AppPermissionManagerPermission.systemAlertWindow` | Android | Display over other apps (Overlay) |
| `AppPermissionManagerPermission.scheduleExactAlarm` | Android | Schedule precise alarms |

## 🤖 Android Setup

Add required permissions to your `AndroidManifest.xml`:

```xml
<!-- General -->
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.READ_CONTACTS"/>

<!-- Android 13+ Media -->
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />

<!-- Specialized -->
<uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS"/>
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW"/>
<uses-permission android:name="android.permission.SCHEDULE_EXEACT_ALARM"/>
```

## 🍎 iOS Setup

Add usage descriptions to your `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required</string>
<key>NSMicrophoneUsageDescription</key>
<string>Microphone access is required</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Photo library access is required</string>
<key>NSContactsUsageDescription</key>
<string>Contacts access is required</string>
```

## 📝 License
This package is available under the MIT License.

## 👨‍💻 Author

**Manoj Patadiya**
📧 Email: patadiyamanoj4@gmail.com


