import 'package:flutter/material.dart';

enum TextFieldStyle { outlined, filled, standard } // Jenis TextField

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType; // Jenis input (default: teks)
  final String? Function(String?)? validator;
  final TextFieldStyle style; // Gaya TextField
  final Widget? prefix; // Tambahan untuk prefix
  final Widget? suffix; // Tambahan untuk suffix
  final bool isPassword; // Apakah input untuk password
  final bool isReadOnly; // Mode read-only
  final bool isDisabled; // Mode disabled

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.style = TextFieldStyle.standard, // Default ke gaya standard
    this.prefix,
    this.suffix,
    this.isPassword = false, // Default bukan password
    this.isReadOnly = false, // Default tidak read-only
    this.isDisabled = false, // Default tidak disabled
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isObscured = false; // Untuk menampilkan/menyembunyikan password

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _isObscured = widget.isPassword; // Default menyembunyikan password
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Warna border aktif dan tidak aktif
    final Color activeColor = Colors.blue;
    final Color inactiveColor = Colors.grey;

    // Tentukan apakah TextField dalam keadaan disabled
    final bool isDisabled = widget.isDisabled;

    // Sesuaikan InputDecoration berdasarkan gaya
    InputDecoration inputDecoration;
    switch (widget.style) {
      case TextFieldStyle.outlined:
        inputDecoration = InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: isDisabled
                ? Colors.grey // Warna label untuk mode disabled
                : (_isFocused ? activeColor : inactiveColor),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: activeColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: isDisabled ? Colors.grey : inactiveColor,
              width: 1.0,
            ),
          ),
          prefixIcon: widget.prefix,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: isDisabled ? Colors.grey : Colors.black54,
                  ),
                  onPressed: isDisabled
                      ? null
                      : () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                )
              : widget.suffix,
        );
        break;
      case TextFieldStyle.filled:
        inputDecoration = InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: isDisabled
                ? Colors.grey
                : (_isFocused ? activeColor : inactiveColor),
            fontSize: _isFocused ? 14 : 16,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: isDisabled ? Colors.grey[300] : Colors.grey[200],
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 8),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: activeColor, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isDisabled ? Colors.grey : inactiveColor,
              width: 1.0,
            ),
          ),
          prefixIcon: widget.prefix,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: isDisabled ? Colors.grey : Colors.black54,
                  ),
                  onPressed: isDisabled
                      ? null
                      : () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                )
              : widget.suffix,
        );
        break;
      case TextFieldStyle.standard:
        inputDecoration = InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: isDisabled
                ? Colors.grey
                : (_isFocused ? activeColor : inactiveColor),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: activeColor, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isDisabled ? Colors.grey : inactiveColor,
              width: 1.0,
            ),
          ),
          prefixIcon: widget.prefix,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: isDisabled ? Colors.grey : Colors.black54,
                  ),
                  onPressed: isDisabled
                      ? null
                      : () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                )
              : widget.suffix,
        );
        break;
    }

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      obscureText: _isObscured, // Untuk menyembunyikan teks jika password
      decoration: inputDecoration,
      validator: widget.validator,
      readOnly: widget.isReadOnly, // Untuk mode read-only
      enabled: !widget.isDisabled, // Untuk mode disabled
    );
  }
}
