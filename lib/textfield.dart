import 'package:flutter/material.dart';
import 'widgets/custom.dart';

class FieldScreen extends StatefulWidget {
  @override
  _FieldScreenState createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsetsDirectional.only(start: 20, end: 20),
            child: Column(
              children: [
                CustomTextField(
                  label: 'Enter your name', // Label yang tampil di dalam input
                  controller: TextEditingController(), // Controller untuk input
                  style: TextFieldStyle.filled, // Mengatur gaya input
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  label: 'Outlined with Prefix & Suffix',
                  controller: TextEditingController(),
                  style: TextFieldStyle.outlined,
                  prefix: Icon(Icons.email),
                  suffix: Icon(Icons.check_circle),
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  label: 'Filled with Prefix',
                  controller: TextEditingController(),
                  style: TextFieldStyle.filled,
                  prefix: Icon(Icons.phone),
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  label: 'Standard with Suffix',
                  controller: TextEditingController(),
                  style: TextFieldStyle.standard,
                  suffix: Icon(Icons.visibility),
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  label: 'Angka',
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number, // Input angka
                  style: TextFieldStyle.outlined,
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  label: 'Kata Sandi',
                  controller: TextEditingController(),
                  isPassword: true, // Input password
                  style: TextFieldStyle.filled,
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  label: 'Hanya Dibaca',
                  controller:
                      TextEditingController(text: 'Contoh teks read-only'),
                  isReadOnly: true, // Mode read-only
                  style: TextFieldStyle.standard,
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  label: 'Disabled',
                  controller: TextEditingController(),
                  isDisabled: true, // Mode disabled
                  style: TextFieldStyle.outlined,
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
