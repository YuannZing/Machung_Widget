import 'package:flutter/material.dart';
import 'widgets/custom.dart';

class ProgressBarExample extends StatefulWidget {
  @override
  _ProgressBarExampleState createState() => _ProgressBarExampleState();
}

class _ProgressBarExampleState extends State<ProgressBarExample> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Progress Pembayaran")),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // Gunakan widget ProgressBar yang sudah dibuat
            Container(
              height: 30,
              width: 100,
              child: ProgressBar(
                Values: 100,
                totalValues: 200,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
