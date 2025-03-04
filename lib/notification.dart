import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static void initialize() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Notifikasi Global',
          channelDescription: 'Menampilkan notifikasi dari server WebSocket',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          playSound: true,
        )
      ],
      debug: true,
    );
  }

  static void requestPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  static void showNotification({required String title, required String body}) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'basic_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'open_chat',
          label: 'Buka Chat',
        )
      ],
    );
  }
}
