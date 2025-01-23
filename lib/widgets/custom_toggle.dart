import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  final bool initialValue; // Nilai awal toggle (true/false)
  final ValueChanged<bool>? onChanged; // Callback ketika toggle berubah
  final Color activeColor; // Warna saat toggle aktif
  final Color inactiveColor; // Warna saat toggle tidak aktif
  final double width; // Lebar toggle
  final double height; // Tinggi toggle
  final double borderRadius; // Radius sudut toggle

  const CustomToggle({
    Key? key,
    this.initialValue = false,
    this.onChanged,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.width = 50.0,
    this.height = 25.0,
    this.borderRadius = 20.0,
  }) : super(key: key);

  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  late bool _isToggled;

  @override
  void initState() {
    super.initState();
    _isToggled = widget.initialValue; // Mengatur nilai awal
  }

  void _toggle() {
    setState(() {
      _isToggled = !_isToggled; // Mengubah nilai toggle
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_isToggled); // Memanggil callback onChanged
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: _isToggled ? widget.activeColor : widget.inactiveColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        alignment: _isToggled ? Alignment.centerRight : Alignment.centerLeft,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.height - 6,
          height: widget.height - 6,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
