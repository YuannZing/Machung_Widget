import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initialize();
  NotificationService.requestPermission();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WebSocketChannel? channel;
  String userId = "user_1234"; // ID pengguna

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    try {
      channel = IOWebSocketChannel.connect("ws://10.50.2.128:8080");

      channel!.stream.listen(
        (message) {
          final data = jsonDecode(message);

          if (data["event"] == "private_message") {
            print("📩 Notifikasi Diterima: ${data["message"]}");

            // 🔹 Tampilkan notifikasi
            NotificationService.showNotification(
              title: "Pesan Baru dari ${data["from"]}",
              body: data["message"],
            );
          } else if (data["event"] == "global_message") {
            print("🌍 Broadcast Diterima: ${data["message"]}");

            NotificationService.showNotification(
              title: "Pengumuman",
              body: data["message"],
            );
          } else if (data["event"] == "error") {
            print("⚠️ Error dari server: ${data["message"]}");
          }
        },
        onDone: () {
          print("❌ WebSocket terputus!");
        },
        onError: (error) {
          print("⚠️ WebSocket Error: $error");
        },
      );

      // 🔹 Kirim ID pengguna ke server setelah koneksi berhasil
      channel!.sink.add(jsonEncode({"type": "register", "user_id": userId}));
    } catch (e) {
      print("❌ Gagal terhubung ke WebSocket: $e");
    }
  }

  void sendTestNotification() {
    if (channel != null) {
      channel!.sink.add(jsonEncode({
        "type": "send_to_user",
        "user_id": userId,
        "message": "Halo dari Flutter!"
      }));
    } else {
      print("⚠️ WebSocket belum terhubung!");
    }
  }

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("WebSocket & Notifikasi")),
        body: Center(
          child: ElevatedButton(
            onPressed: sendTestNotification,
            child: Text("Kirim Notifikasi ke Saya"),
          ),
        ),
      ),
    );
  }
}

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
    );
  }
}
