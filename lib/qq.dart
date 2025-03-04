import 'package:flutter/material.dart';
import 'pp.dart'; // Import file widget

class Mytable extends StatefulWidget{
  @override
  _MytableState createState() => _MytableState();
}

class _MytableState extends State<Mytable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table"),
      ),
      body: Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        child: ScrollableTable(
          headers: ['Nama', 'Usia', 'Kota', 'Profesi'],
          firstColumn: ['Andi', 'Budi', 'Citra', 'Doni', 'Eka'], // Frozen Column

          data: [
            ['Andi', '25', 'Jakarta', 'Programmer'],
            ['Budi', '30', 'Bandung', 'Designer'],
            ['Citra', '28', 'Surabaya', 'Dokter'],
            ['Doni', '24', 'Yogyakarta', 'Guru'],
            ['Eka', '35', 'Medan', 'Pengusaha'],
          ],
        ),
      ),
            ),
    );
  }
}