## 1.0.0

### 🎉 Initial Release

- Initial release of `app_permission_manager`
- Simple and unified permission API for Flutter
- Support for Android and iOS
- Check and request permissions
- Open app settings when permission is permanently denied

### ✅ Supported Permissions
- Camera
- Microphone
- Location (when in use)
- Location (always / background)
- Storage
- Photos
- Notifications
- Contacts
- Phone

### 📱 Supported Permission Status
- granted
- denied
- permanentlyDenied (Android)
- restricted (iOS)
- limited (iOS Photos)

### 🔧 Platform Notes
- Android runtime permission handling
- iOS permission handling using native frameworks
- iOS permission descriptions must be added in `Info.plist`
- Android permissions must be declared in `AndroidManifest.xml`