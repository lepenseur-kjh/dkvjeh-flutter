import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin _local =
    FlutterLocalNotificationsPlugin();

// 권한을 요청 받지 않는 상태라면 권한을 요청하고, 거부 또는 허용된 상태에서는 요청하지 않는다.
Future<void> permissionWithNotification() async {
  if (await Permission.notification.isDenied &&
      !await Permission.notification.isPermanentlyDenied) {
    await [Permission.notification].request();
  }
}

// 안드로이드 초기화 아이콘 설정
// iOS 초기화 시 권한 요청 false
Future<void> initialization() async {
  AndroidInitializationSettings android =
      const AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings ios = const DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
  InitializationSettings settings = InitializationSettings(
    android: android,
    iOS: ios,
  );
  await _local.initialize(settings);
}

Future<void> setupPushNotification() async {
  // foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
    if (message != null) {
      if (message.notification != null) {
        //
        print("foreground: $message");
      }
    }
  });
  // background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
    if (message != null) {
      if (message.notification != null) {
        //
        print("background: $message");
      }
    }
  });
  // terminate
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      if (message.notification != null) {
        //
        print("terminate: $message");
      }
    }
  });
}
