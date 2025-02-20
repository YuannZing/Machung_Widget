import 'package:flutter/material.dart';
import 'widgets/custom.dart';

class StickyHeaderTable extends StatefulWidget {
  @override
  _StickyHeaderTableState createState() => _StickyHeaderTableState();
}

class _StickyHeaderTableState extends State<StickyHeaderTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sticky Header + First Column Fixed")),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              child: CustomTable(
                header: ["ID", "Nama", "Umur", "Kota"],
                // firstColumn: List.generate(50, (index) => "ID ${index + 1}"),
                firstColumn: ["ID 1", "ID 2", "ID 3", "ID 4", "ID 5"],
                // data: List.generate(
                //   50,
                //   (index) => [
                //     "User $index",
                //     "${20 + (index % 10)}",
                //     "Kota ${index % 5}"
                //   ],
                // ),
                data: [
                  ["Alice", "25", "Jakarta"],
                  ["Bob", "30", "Surabaya"],
                  ["Charlie", "22", "Bandung"],
                  ["David", "28", "Medan"],
                  ["Eve", "24", "Makassar"],
                ],
              ),
            ),
            Center(
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4), // Warna shadow
                      offset:
                          Offset(0, 4), // Posisi shadow hanya vertikal ke bawah
                      blurRadius: 4, // Efek kabur untuk shadow
                      spreadRadius: -2, // Shadow tidak menyebar ke samping
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Contoh Shadow Bawah',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //     Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         height: 50,
      //         color: Colors.grey[300],
      //       ),
      //       // color: Colors.blue,
      //       // child: Row(
      //       //   children: [
      //       //   ],
      //       // ),
      //     )
      //   ],
      // ),
    );
  }
}
