import 'package:web/web.dart' as web;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:js_interop';
import 'app_permission_manager_platform_interface.dart';
import 'app_permission_manager_types.dart';

/// A web implementation of the AppPermissionManagerPlatform of the AppPermissionManager plugin.
class AppPermissionManagerWeb extends AppPermissionManagerPlatform {
  /// Constructs a AppPermissionManagerWeb.
  AppPermissionManagerWeb();

  static void registerWith(Registrar registrar) {
    AppPermissionManagerPlatform.instance = AppPermissionManagerWeb();
  }

  @override
  Future<AppPermissionManagerStatus> check(
    AppPermissionManagerPermission permission,
  ) async {
    final status = await _getWebPermissionStatus(permission);
    return status;
  }

  @override
  Future<AppPermissionManagerStatus> request(
    AppPermissionManagerPermission permission,
  ) async {
    return check(permission);
  }

  Future<AppPermissionManagerStatus> _getWebPermissionStatus(
    AppPermissionManagerPermission permission,
  ) async {
    final permissions = web.window.navigator.permissions;

    String? webPermissionName;
    switch (permission) {
      case AppPermissionManagerPermission.camera:
        webPermissionName = 'camera';
        break;
      case AppPermissionManagerPermission.microphone:
        webPermissionName = 'microphone';
        break;
      case AppPermissionManagerPermission.notifications:
        webPermissionName = 'notifications';
        break;
      case AppPermissionManagerPermission.location:
        webPermissionName = 'geolocation';
        break;
      default:
        return AppPermissionManagerStatus.denied;
    }

    try {
      final status = await permissions.query({'name': webPermissionName}.jsify() as JSObject).toDart;
      switch (status.state) {
        case 'granted':
          return AppPermissionManagerStatus.granted;
        case 'prompt':
          return AppPermissionManagerStatus.denied;
        case 'denied':
          return AppPermissionManagerStatus.permanentlyDenied;
        default:
          return AppPermissionManagerStatus.denied;
      }
    } catch (e) {
      return AppPermissionManagerStatus.denied;
    }
  }

  @override
  Future<Map<AppPermissionManagerPermission, AppPermissionManagerStatus>>
      checkMultiple(
    List<AppPermissionManagerPermission> permissions,
  ) async {
    final results = <AppPermissionManagerPermission, AppPermissionManagerStatus>{};
    for (final p in permissions) {
      results[p] = await check(p);
    }
    return results;
  }

  @override
  Future<Map<AppPermissionManagerPermission, AppPermissionManagerStatus>>
      requestMultiple(
    List<AppPermissionManagerPermission> permissions,
  ) async {
    return checkMultiple(permissions);
  }

  @override
  Stream<AppPermissionManagerStatus> statusStream(
    AppPermissionManagerPermission permission,
  ) {
    // Placeholder for web stream
    return Stream.empty();
  }

  @override
  Future<void> openAppSettings() async {
    // No direct "App Settings" on Web
  }
}
