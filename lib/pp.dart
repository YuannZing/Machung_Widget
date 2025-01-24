import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldStyle { outlined, filled, standard }

enum InputType { text, email, password, number, phone, url }

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextFieldStyle style;
  final Widget? prefix;
  final Widget? suffix;
  final bool isPassword;
  final bool isReadOnly;
  final bool isDisabled;
  final String? helperText;
  final int? maxChar;
  final bool showCharCount;
  final List<TextInputFormatter>? inputFormatters;
  final InputType inputType;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.style = TextFieldStyle.standard,
    this.prefix,
    this.suffix,
    this.isPassword = false,
    this.isReadOnly = false,
    this.isDisabled = false,
    this.helperText,
    this.maxChar,
    this.showCharCount = true,
    this.inputFormatters,
    this.inputType = InputType.text,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isObscured = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _validateField();
      }
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    _isObscured = widget.isPassword;
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPassword != oldWidget.isPassword) {
      setState(() {
        _isObscured = widget.isPassword;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _validateField() {
    if (widget.validator != null) {
      final error = widget.validator!(widget.controller.text);
      setState(() {
        _errorMessage = error;
      });
    }
  }

  String? Function(String?) _getValidator(InputType inputType) {
    // if (widget.validator != null) return widget.validator!;

    switch (inputType) {
      case InputType.email:
        return _emailValidator;
      case InputType.password:
        return _passwordValidator;
      case InputType.number:
        return _numberValidator;
      case InputType.phone:
        return _phoneValidator;
      case InputType.url:
        return _urlValidator;
      default:
        return _defaultValidator;
    }
  }

  // Email Validator
  String? _emailValidator(String? value) {
    final emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  // Password Validator
  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }

  // Number Validator
  String? _numberValidator(String? value) {
    final numberPattern = r'^\d+$';
    final regex = RegExp(numberPattern);
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid number.';
    }
    return null;
  }

  // Phone Validator
  String? _phoneValidator(String? value) {
    final phonePattern = r'^\+?[0-9]{7,15}$';
    final regex = RegExp(phonePattern);
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid phone number.';
    }
    return null;
  }

  // URL Validator
  String? _urlValidator(String? value) {
    final urlPattern = r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$';
    final regex = RegExp(urlPattern);
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid URL.';
    }
    return null;
  }

  // Default Validator
  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  // Menentukan keyboard type berdasarkan inputType
  TextInputType _getKeyboardType(InputType inputType) {
    switch (inputType) {
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.number:
        return TextInputType.number;
      case InputType.phone:
        return TextInputType.phone;
      case InputType.url:
        return TextInputType.url;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Colors.blue;
    final Color inactiveColor = Colors.grey;
    final Color errorColor = Colors.red;

    final bool isDisabled = widget.isDisabled;
    final bool showCharCount = widget.showCharCount;

    InputDecoration inputDecoration;
    switch (widget.style) {
      case TextFieldStyle.outlined:
        inputDecoration = InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: _errorMessage != null
                ? Colors.red
                : (isDisabled
                    ? Colors.grey
                    : (_isFocused ? activeColor : inactiveColor)),
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          errorText: _errorMessage,
          prefixIcon: widget.prefix,
          suffixIcon: widget.inputType == InputType.password
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
          helperText: widget.helperText,
          helperStyle: TextStyle(color: Colors.grey[600], fontSize: 12),
        );
        break;
      case TextFieldStyle.filled:
        inputDecoration = InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: _errorMessage != null
                ? Colors.red
                : (isDisabled
                    ? Colors.grey
                    : (_isFocused ? activeColor : inactiveColor)),
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
          errorText: _errorMessage,
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
          helperText: widget.helperText,
          helperStyle: TextStyle(color: Colors.grey[600], fontSize: 12),
        );
        break;
      case TextFieldStyle.standard:
        inputDecoration = InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: _errorMessage != null
                ? Colors.red
                : (isDisabled
                    ? Colors.grey
                    : (_isFocused ? activeColor : inactiveColor)),
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
          errorText: _errorMessage,
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
          helperText: widget.helperText,
          helperStyle: TextStyle(color: Colors.grey[600], fontSize: 12),
        );
        break;
    }

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      readOnly: widget.isReadOnly,
      enabled: !widget.isDisabled,
      maxLength: widget.maxChar,
      inputFormatters: widget.inputFormatters,
      keyboardType: _getKeyboardType(widget.inputType),
      obscureText: _isObscured,
      validator: _getValidator(widget.inputType),
      decoration: inputDecoration,
    );

  }
}
