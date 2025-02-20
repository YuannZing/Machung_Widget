import 'package:flutter/material.dart';
import 'dart:math';

class DonutChartPainter extends CustomPainter {
  final List<double> values; // Data untuk persentase
  final List<Color> colors; // Warna setiap bagian

  DonutChartPainter({required this.values, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final double total = values.reduce((a, b) => a + b); // Total nilai
    final Paint paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 50; // Lebar lingkaran
    
    double startAngle = -pi / 2; // Mulai dari atas

    for (int i = 0; i < values.length; i++) {
      final double sweepAngle = (values[i] / total) * 2 * pi; // Hitung sudut setiap bagian
      paint.color = colors[i]; // Atur warna

      // Gambar bagian donat
      canvas.drawArc(
        Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width, height: size.height),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle; // Perbarui posisi mulai
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DonutChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donut Chart Manual')),
      body: Center(
        child: CustomPaint(
          size: Size(200, 200), // Ukuran canvas
          painter: DonutChartPainter(
            values: [2,90,1,1], // Data persentase
            colors: [Colors.blue, Colors.red, Colors.green, Colors.yellow], // Warna setiap bagian
          ),
        ),
      ),
    );
  }
}
