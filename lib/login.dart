import 'package:flutter/material.dart';
import 'widgets/custom.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String imageUrl = "assets/images/machung.png"; // Ganti dengan path gambar yang sesuai

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 65),
                child: Center(
                  child: Text(
                    "你好 Ma Chungers!",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 45),
              Positioned(
                bottom: 0,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.contain,
                        
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 211.8), // Jarak dari gambar ke form
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primary, Color.fromRGBO(0, 96, 166, 1)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: 'Username',
                              inputType: InputType.text,
                              isRequired: true,
                              controller: TextEditingController(),
                              maxChar: 60,
                              errorColor: Color.fromRGBO(253, 186, 207, 1),

                            ),
                            SizedBox(height: 5),
                            CustomTextField(
                              label: 'Password',
                              inputType: InputType.password,
                              controller: TextEditingController(),
                              isRequired: true,
                              maxChar: 60,
                              errorColor: Color.fromRGBO(253, 186, 207, 1),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                label: "Login",
                                onPressed: () {
                                  print('Tombol Login ditekan');
                                },
                                color: Colors.white,
                                textColor: primary,
                                height: 50.0,
                                fontSize: 18.0,
                                borderRadius: 12.0,
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                "Or",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                label: "Continue With Microsoft",
                                icon: Icons.window_sharp,
                                onPressed: () {
                                  print('Tombol Login ditekan');
                                },
                                color: secondary,
                                textColor: Colors.white,
                                height: 50.0,
                                fontSize: 18.0,
                                borderRadius: 12.0,
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "Copyright © 2024 MAC IS Mobile - Universitas Ma Chung.\nAll Rights Reserved",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
