import 'app_permission_manager_platform_interface.dart';
import 'app_permission_manager_types.dart';

export 'app_permission_manager_types.dart';

class AppPermissionManager {
  static Future<AppPermissionManagerStatus> check(
    AppPermissionManagerPermission permission,
  ) {
    return AppPermissionManagerPlatform.instance.check(permission);
  }

  static Future<AppPermissionManagerStatus> request(
    AppPermissionManagerPermission permission,
  ) {
    return AppPermissionManagerPlatform.instance.request(permission);
  }

  static Future<void> openAppSettings() {
    return AppPermissionManagerPlatform.instance.openAppSettings();
  }

  static Future<Map<AppPermissionManagerPermission, AppPermissionManagerStatus>>
      checkMultiple(
    List<AppPermissionManagerPermission> permissions,
  ) {
    return AppPermissionManagerPlatform.instance.checkMultiple(permissions);
  }

  static Future<Map<AppPermissionManagerPermission, AppPermissionManagerStatus>>
      requestMultiple(
    List<AppPermissionManagerPermission> permissions,
  ) {
    return AppPermissionManagerPlatform.instance.requestMultiple(permissions);
  }

  static Stream<AppPermissionManagerStatus> statusStream(
    AppPermissionManagerPermission permission,
  ) {
    return AppPermissionManagerPlatform.instance.statusStream(permission);
  }

  static Future<String?> getPlatformVersion() {
    return AppPermissionManagerPlatform.instance.getPlatformVersion();
  }
}
