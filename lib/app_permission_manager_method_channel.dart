import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_permission_manager_platform_interface.dart';
import 'app_permission_manager_types.dart';

/// An implementation of [AppPermissionManagerPlatform] that uses method channels.
class MethodChannelAppPermissionManager extends AppPermissionManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_permission_manager');

  @visibleForTesting
  final eventChannel = const EventChannel('app_permission_manager_events');

  @override
  Future<AppPermissionManagerStatus> check(
    AppPermissionManagerPermission permission,
  ) async {
    final result = await methodChannel.invokeMethod<String>(
      'check',
      {'permission': permission.name},
    );
    return AppPermissionManagerStatus.values.byName(result!);
  }

  @override
  Future<AppPermissionManagerStatus> request(
    AppPermissionManagerPermission permission,
  ) async {
    final result = await methodChannel.invokeMethod<String>(
      'request',
      {'permission': permission.name},
    );
    return AppPermissionManagerStatus.values.byName(result!);
  }

  @override
  Future<Map<AppPermissionManagerPermission, AppPermissionManagerStatus>>
      checkMultiple(
    List<AppPermissionManagerPermission> permissions,
  ) async {
    final Map<String, String> result =
        await methodChannel.invokeMapMethod<String, String>(
      'checkMultiple',
      {'permissions': permissions.map((p) => p.name).toList()},
    ) ??
    {};

    return result.map((key, value) => MapEntry(
          AppPermissionManagerPermission.values.byName(key),
          AppPermissionManagerStatus.values.byName(value),
        ));
  }

  @override
  Future<Map<AppPermissionManagerPermission, AppPermissionManagerStatus>>
      requestMultiple(
    List<AppPermissionManagerPermission> permissions,
  ) async {
    final Map<String, String> result =
        await methodChannel.invokeMapMethod<String, String>(
      'requestMultiple',
      {'permissions': permissions.map((p) => p.name).toList()},
    ) ??
    {};

    return result.map((key, value) => MapEntry(
          AppPermissionManagerPermission.values.byName(key),
          AppPermissionManagerStatus.values.byName(value),
        ));
  }

  @override
  Stream<AppPermissionManagerStatus> statusStream(
    AppPermissionManagerPermission permission,
  ) {
    return eventChannel
        .receiveBroadcastStream({'permission': permission.name}).map(
      (event) => AppPermissionManagerStatus.values.byName(event as String),
    );
  }

  @override
  Future<void> openAppSettings() async {
    await methodChannel.invokeMethod('openAppSettings');
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
