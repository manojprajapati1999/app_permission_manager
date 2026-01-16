enum AppPermissionManagerPermission {
  camera,
  microphone,
  location,
  locationAlways,
  storage,
  photos,
  notifications,
  contacts,
  phone,
  // Android specific
  ignoreBatteryOptimizations,
  systemAlertWindow,
  scheduleExactAlarm,
  // Android 13+ Media
  mediaImages,
  mediaVideo,
  mediaAudio,
}

enum AppPermissionManagerStatus {
  granted,
  denied,
  permanentlyDenied,
  restricted, // iOS
  limited, // iOS photos
}
