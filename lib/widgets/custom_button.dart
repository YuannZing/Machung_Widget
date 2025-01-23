import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String label; // Teks tombol
  final VoidCallback onPressed; // Fungsi ketika tombol ditekan
  final Color color; // Warna latar belakang tombol
  final Color textColor; // Warna teks tombol
  final double width; // Lebar tombol
  final double height; // Tinggi tombol
  final double fontSize; // Ukuran font
  final double borderRadius; // Radius sudut tombol
  final bool isDisabled; // Apakah tombol dinonaktifkan
  final IconData? prefixIcon; // Ikon di depan teks
  final IconData? suffixIcon; // Ikon di belakang teks opsional
  final IconData? icon; // Ikon yang akan ditampilkan


  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = Colors.blue, // Default warna biru
    this.textColor = Colors.white, // Default warna teks putih
    this.width = 150.0, // Default lebar tombol
    this.height = 40.0, // Default tinggi tombol
    this.fontSize = 14.0, // Default ukuran font
    this.borderRadius = 10.0, // Default radius sudut
    this.isDisabled = false, // Default tidak dinonaktifkan
    this.prefixIcon, // Ikon opsional
    this.suffixIcon, // Ikon di belakang teks opsional
    this.icon, // Ikon opsional
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // Fungsi untuk membuat warna menjadi lebih terang
    Color _brighten(Color color, double factor) {
      assert(factor >= 0 && factor <= 1, 'Factor must be between 0 and 1');
      final hsl = HSLColor.fromColor(color);
      final HSLColor brightened = hsl.withLightness(
        (hsl.lightness + factor).clamp(0.0, 0.8),
      );
      return brightened.toColor();
    }

    // Menghitung warna tombol ketika ditekan (lebih terang)
    final Color brightenedColor = _brighten(widget.color, 0.6);

    // Ukuran ikon lebih besar 1.5x dari ukuran font
    final double iconSize = widget.fontSize * 1.75;

    return GestureDetector(
      onTapDown: (_) {
        if (!widget.isDisabled) {
          setState(() {
            _isPressed = true;
          });
        }
      },
      onTapUp: (_) {
        if (!widget.isDisabled) {
          setState(() {
            _isPressed = false;
          });
          widget.onPressed();
        }
      },
      onTapCancel: () {
        if (!widget.isDisabled) {
          setState(() {
            _isPressed = false;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.isDisabled
              ? Colors.grey
              : _isPressed
                  ? brightenedColor
                  : widget.color,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: widget.icon != null ?
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.icon != null ) // Ikon di kiri
              Icon(
                widget.icon,
                color: _isPressed ? widget.color : widget.textColor,
                size: iconSize,
              ),
            if (widget.icon != null )
              const SizedBox(width: 8.0), // Jarak antara ikon dan teks
            Text(
              widget.label,
              style: TextStyle(
                color: widget.isDisabled
                    ? Color.fromRGBO(90, 135, 155, 1)
                    : _isPressed
                        ? widget.textColor
                        : widget.textColor,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
        : Stack(
          alignment: Alignment.center, // Menyusun konten di tengah
          children: [
            // Menempatkan teks di tengah
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.label,
                style: TextStyle(
                  color: widget.isDisabled
                      ? Colors.black45
                      : _isPressed
                          ? widget.textColor
                          : widget.textColor,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Menempatkan prefixIcon di kiri atas
            if (widget.prefixIcon != null)
              Positioned(
                left: 8.0,
                top: widget.height / 2 - iconSize / 2,
                child: Icon(
                  widget.prefixIcon,
                  color: _isPressed ? widget.color : widget.textColor,
                  size: iconSize,
                ),
              ),
            // Menempatkan suffixIcon di kanan atas
            if (widget.suffixIcon != null)
              Positioned(
                right: 8.0,
                top: widget.height / 2 - iconSize / 2,
                child: Icon(
                  widget.suffixIcon,
                  color: _isPressed ? widget.color : widget.textColor,
                  size: iconSize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
