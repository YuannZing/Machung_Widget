import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:awesome_notifications/awesome_notifications.dart';

class WebSocketService {
  late IO.Socket socket;

  void connect(String userId) {
    socket = IO.io("http://your_server_ip:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.connect();
    socket.onConnect((_) {
      print("Connected to WebSocket Server!");

      // Kirim user_id saat terhubung
      socket.emit("register", {"user_id": userId});
    });

    // Menerima notifikasi baru
    socket.on("new_notification", (data) {
      String message = data["message"];
      print("Notifikasi: $message");

      // Tampilkan notifikasi di Flutter
      showNotification("Notifikasi Baru", message);
    });

    socket.onDisconnect((_) => print("Disconnected from WebSocket"));
  }

  void sendGlobalNotification(String message) {
    socket.emit("send_global", {"message": message});
  }

  void sendToUser(String targetUserId, String message) {
    socket.emit("send_to_user", {"user_id": targetUserId, "message": message});
  }

  void joinGroup(String userId, String groupId) {
    socket.emit("join_group", {"user_id": userId, "group_id": groupId});
  }

  void leaveGroup(String userId, String groupId) {
    socket.emit("leave_group", {"user_id": userId, "group_id": groupId});
  }

  void sendToGroup(String groupId, String message) {
    socket.emit("send_to_group", {"group_id": groupId, "message": message});
  }

  void showNotification(String title, String body) {
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
