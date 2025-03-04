import 'package:flutter/material.dart';

class CustomSliderValueIndicator extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(50, 35); // Lebih tinggi agar ada ruang untuk lancipnya
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double textScaleFactor,
    required double value,
  }) {
    final canvas = context.canvas;
    const double width = 40;
    const double height = 24;
    const double arrowSize = 10; // Ukuran lancipnya

    // **Hitung posisi kotak dan segitiga (lancipnya)**
    final Rect rect = Rect.fromCenter(
      center: center - const Offset(0, 35),
      width: width,
      height: height,
    );

    // **Bentuk lancip di tengah bawah kotak**
    final Path trianglePath = Path()
      ..moveTo(center.dx - arrowSize / 2, rect.bottom) // Kiri bawah lancip
      ..lineTo(center.dx + arrowSize / 2, rect.bottom) // Kanan bawah lancip
      ..lineTo(center.dx, rect.bottom + arrowSize) // Puncak lancip di bawah
      ..close();

    // **Buat cat untuk menggambar**
    final Paint paint = Paint()..color = Colors.blue;

    // **Gambar kotak dan lancipnya**
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(5)), paint);
    canvas.drawPath(trianglePath, paint);

    // **Tampilkan teks nilai slider**
    final Offset textOffset =
        Offset(center.dx - (labelPainter.width / 2), rect.top + 6);
    labelPainter.paint(canvas, textOffset);
  }
}

class CustomSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final double min;
  final double max;
  final double trackHeight;
  final int divisions;

  const CustomSlider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.thumbColor = Colors.blue,
    this.min = 0.0,
    this.max = 100.0,
    this.trackHeight = 10.0,
    this.divisions = 100,
  }) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        valueIndicatorShape: CustomSliderValueIndicator(),
        showValueIndicator: ShowValueIndicator.always,
        trackHeight: widget.trackHeight,
        activeTrackColor: widget.activeColor,
        inactiveTrackColor: widget.inactiveColor,
        thumbColor: widget.thumbColor,
      ),
      child: Slider(
        value: widget.value,
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        label: widget.value.round().toString(),
        onChanged: widget.onChanged,
      ),
    );
  }
}
