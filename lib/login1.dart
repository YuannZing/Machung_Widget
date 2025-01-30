import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen1 extends StatefulWidget{
  @override
  _LoginScreenState1 createState() => _LoginScreenState1();
} 


class _LoginScreenState1 extends State<LoginScreen1> {
  final String imageUrl = "assets/images/machung.png"; // Ganti dengan URL gambar Anda

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      imageUrl,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "你好 Ma Chungers!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.white),
                        border: UnderlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
                        border: UnderlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        suffixIcon: Icon(Icons.visibility, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Login"),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Or",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.account_circle),
                        label: Text("Continue With Microsoft"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                    Spacer(),
                    Center(
                      child: Text(
                        "Copyright © 2024 MAC IS Mobile - Universitas Ma Chung.\nAll Rights Reserved",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
