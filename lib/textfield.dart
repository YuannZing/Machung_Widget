import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/custom.dart';

class FieldScreen extends StatefulWidget {
  @override
  _FieldScreenState createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  String _inputText = "";
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
                // Row(
                //   children: [
                //     CustomTextField(
                //       label: 'Outlined with Prefix & Suffix',
                //       controller: TextEditingController(),
                //       style: TextFieldStyle.outlined,
                //       prefix: Icon(Icons.email),
                //       suffix: Icon(Icons.check_circle),
                //     ),
                //     CustomTextField(
                //       label: 'Filled with Prefix',
                //       controller: TextEditingController(),
                //       style: TextFieldStyle.filled,
                //       prefix: Icon(Icons.phone),
                //     ),
                //   ],
                // ),
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
                  maxChar: 30,
                  helperText: "Woi, ini kata sandi",
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
                SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                  label: 'Email',
                  controller: TextEditingController(),
                  inputType: InputType.email,
                  helperText: 'Masukkan email aktif Anda',
                  style: TextFieldStyle.outlined,
                ),
                CustomTextField(
                  label: 'Password',
                  inputType: InputType.password,
                  controller: TextEditingController(),
                  isRequired: true,
                  helperText: 'Gunakan minimal 8 karakter',
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Password tidak boleh kosong';
                  //   } else if (value.length < 8) {
                  //     return 'Password harus minimal 8 karakter';
                  //   }
                  //   return null;
                  // },
                  style: TextFieldStyle.filled,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                  label: 'Kode Produks',
                  inputType: InputType.email,
                  isRequired: true,
                  // keyboardType: TextInputType.number, // Sesuaikan dengan jenis input yang diinginkan
                  controller: TextEditingController(),
                  helperText: 'Hanya dapat mengisi huruf, angka, - dan .',
                  style: TextFieldStyle.outlined,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                  label: 'Email',
                  controller: TextEditingController(),
                  // keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp(r"[a-zA-Z0-9\s\.\-]"),
                        allow: true),
                  ],
                  helperText: 'Masukkan email aktif Anda',
                  validator: (value) {
                    // Cek apakah input null atau kosong
                    if (value == null || value.isEmpty) {
                      return 'Field tidak boleh kosong';
                    }
                    // Regex untuk membatasi karakter yang diperbolehkan (huruf, angka, titik, pagar, koma)
                    if (!RegExp(r"[a-zA-Z0-9\s\.\-]").hasMatch(value)) {
                      return 'Hanya huruf, angka, titik, pagar, dan koma yang diperbolehkan';
                    }
                    return null; // Validasi berhasil
                  },
                ),
                Column(
                  children: [
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          _inputText = text;
                        });
                      },
                    ),
                    Text('Teks yang dimasukkan: $_inputText'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
