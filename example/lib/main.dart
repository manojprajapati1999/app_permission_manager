import 'package:flutter/material.dart';
import 'package:app_permission_manager/app_permission_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PermissionExamplePage(),
    );
  }
}

class PermissionExamplePage extends StatefulWidget {
  const PermissionExamplePage({super.key});

  @override
  State<PermissionExamplePage> createState() => _PermissionExamplePageState();
}

class _PermissionExamplePageState extends State<PermissionExamplePage> {
  AppPermissionManagerStatus? _status;
  Map<AppPermissionManagerPermission, AppPermissionManagerStatus> _multipleStatuses = {};

  Future<void> _requestPermission(
    AppPermissionManagerPermission permission,
  ) async {
    final status = await AppPermissionManager.request(permission);

    setState(() {
      _status = status;
    });

    if (status == AppPermissionManagerStatus.permanentlyDenied) {
      await AppPermissionManager.openAppSettings();
    }
  }

  Future<void> _requestMultiple() async {
    final results = await AppPermissionManager.requestMultiple([
      AppPermissionManagerPermission.camera,
      AppPermissionManagerPermission.contacts,
      AppPermissionManagerPermission.microphone,
      AppPermissionManagerPermission.mediaImages,
      AppPermissionManagerPermission.mediaVideo,
      AppPermissionManagerPermission.mediaAudio,
    ]);

    setState(() {
      _multipleStatuses = results;
    });
  }

  Widget _permissionButton({
    required String title,
    required AppPermissionManagerPermission permission,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        onPressed: () => _requestPermission(permission),
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Permission Manager')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Single Permission Requests:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _permissionButton(
              title: 'Camera',
              permission: AppPermissionManagerPermission.camera,
            ),
            _permissionButton(
              title: 'Microphone',
              permission: AppPermissionManagerPermission.microphone,
            ),
            _permissionButton(
              title: 'Notifications',
              permission: AppPermissionManagerPermission.notifications,
            ),
            
            const Divider(),
            const Text('Android Specialized Permissions:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _permissionButton(
              title: 'Battery Optimization',
              permission: AppPermissionManagerPermission.ignoreBatteryOptimizations,
            ),
            _permissionButton(
              title: 'Overlay Permission',
              permission: AppPermissionManagerPermission.systemAlertWindow,
            ),
            _permissionButton(
              title: 'Exact Alarm',
              permission: AppPermissionManagerPermission.scheduleExactAlarm,
            ),
            
            const Divider(),
            const Text('Multiple Permissions:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _requestPermission(AppPermissionManagerPermission.mediaImages),
              child: const Text('Request Media Images'),
            ),
            ElevatedButton(
              onPressed: () => _requestPermission(AppPermissionManagerPermission.mediaVideo),
              child: const Text('Request Media Video'),
            ),
            ElevatedButton(
              onPressed: () => _requestPermission(AppPermissionManagerPermission.mediaAudio),
              child: const Text('Request Media Audio'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: _requestMultiple,
              child: const Text('Request Camera, Contacts, Mic, Media'),
            ),
            if (_multipleStatuses.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: _multipleStatuses.entries
                      .map((e) => Text('${e.key.name}: ${e.value.name}'))
                      .toList(),
                ),
              ),
              
            const Divider(),
            const Text('Permission Stream (Camera):',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            StreamBuilder<AppPermissionManagerStatus>(
              stream: AppPermissionManager.statusStream(AppPermissionManagerPermission.camera),
              builder: (context, snapshot) {
                return Text('Stream Status: ${snapshot.data?.name ?? "Waiting..."}');
              },
            ),

            const SizedBox(height: 24),
            Text(
              'Last Action Status:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              _status?.name ?? 'No permission requested',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
