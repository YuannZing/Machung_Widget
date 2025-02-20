import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double totalValues;
  final double Values;

  ProgressBar({
    required this.totalValues,
    required this.Values,
  });

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    // Hitung progress berdasarkan jumlah yang dibayar terhadap total
    double progress = widget.Values / widget.totalValues;

    return Container(
      width: double.infinity,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          // Bagian progress yang sudah dibayar (warna biru)
          Expanded(
            flex: (progress * 100).toInt(), // Menyesuaikan lebar berdasarkan progress
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
          ),
          // Bagian sisa progress yang belum dibayar (warna abu-abu)
          Expanded(
            flex: ((1 - progress) * 100).toInt(), // Menyesuaikan sisa lebar
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
