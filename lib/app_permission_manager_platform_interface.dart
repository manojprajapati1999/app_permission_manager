import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_permission_manager_method_channel.dart';
import 'app_permission_manager_types.dart';

abstract class AppPermissionManagerPlatform extends PlatformInterface {
  /// Constructs a AppPermissionManagerPlatform.
  AppPermissionManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppPermissionManagerPlatform _instance =
      MethodChannelAppPermissionManager();

  /// The default instance of [AppPermissionManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppPermissionManager].
  static AppPermissionManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppPermissionManagerPlatform] when
  /// they register themselves.
  static set instance(AppPermissionManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<AppPermissionManagerStatus> check(
    AppPermissionManagerPermission permission,
  ) {
    throw UnimplementedError('check() has not been implemented.');
  }

  Future<AppPermissionManagerStatus> request(
    AppPermissionManagerPermission permission,
  ) {
    throw UnimplementedError('request() has not been implemented.');
  }

  Future<Map<AppPermissionManagerPermission, AppPermissionManagerStatus>>
      checkMultiple(
    List<AppPermissionManagerPermission> permissions,
  ) {
    throw UnimplementedError('checkMultiple() has not been implemented.');
  }

  Future<Map<AppPermissionManagerPermission, AppPermissionManagerStatus>>
      requestMultiple(
    List<AppPermissionManagerPermission> permissions,
  ) {
    throw UnimplementedError('requestMultiple() has not been implemented.');
  }

  Stream<AppPermissionManagerStatus> statusStream(
    AppPermissionManagerPermission permission,
  ) {
    throw UnimplementedError('statusStream() has not been implemented.');
  }

  Future<void> openAppSettings() {
    throw UnimplementedError('openAppSettings() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
