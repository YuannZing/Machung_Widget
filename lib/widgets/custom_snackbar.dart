import 'package:flutter/material.dart';

class CustomSnackBar {
  static bool _isSnackBarActive = false; // Status untuk mencegah spam

  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    // Cegah pemanggilan jika snackbar masih aktif
    if (_isSnackBarActive) return;

    // Set status menjadi aktif
    _isSnackBarActive = true;

    // Tampilkan SnackBar
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      duration: duration,
      backgroundColor: Colors.black87,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      action: SnackBarAction(
        label: 'Close', // Teks untuk tombol close
        onPressed: () {
          // Menutup SnackBar saat tombol close ditekan
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          _isSnackBarActive = false;
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Reset status setelah debounceDuration
    Future.delayed(duration, () {
      _isSnackBarActive = false;
    });
  }
}
