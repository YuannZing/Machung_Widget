import 'package:flutter/material.dart';

class ScrollableTable extends StatefulWidget {
  final List<String> headers;
  final List<String> firstColumn; // First Column (Frozen)
  final List<List<String>> data;

  ScrollableTable({
    required this.headers,
    required this.firstColumn,
    required this.data,
  });

  @override
  _ScrollableTableState createState() => _ScrollableTableState();
}

class _ScrollableTableState extends State<ScrollableTable> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _horizontalHeaderScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _verticalFirstColumnScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Sinkronisasi scroll horizontal header dengan isi tabel
    _horizontalScrollController.addListener(() {
      _horizontalHeaderScrollController.jumpTo(_horizontalScrollController.offset);
    });

    // Sinkronisasi scroll vertikal first column dengan isi tabel
    _verticalScrollController.addListener(() {
      _verticalFirstColumnScrollController.jumpTo(_verticalScrollController.offset);
    });
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _horizontalHeaderScrollController.dispose();
    _verticalScrollController.dispose();
    _verticalFirstColumnScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // First Column (Frozen Horizontal)
        Column(
          children: [
            _buildHeaderCell(""), // Header kosong agar sejajar dengan header utama
            Expanded(
              child: SingleChildScrollView(
                controller: _verticalFirstColumnScrollController, // Sinkronkan scroll vertikal
                scrollDirection: Axis.vertical,
                child: Column(
                  children: widget.firstColumn.map((text) => _buildFirstColumnCell(text)).toList(),
                ),
              ),
            ),
          ],
        ),
        // Tabel Utama
        Expanded(
          child: Column(
            children: [
              // Header Table (Frozen)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _horizontalHeaderScrollController,
                child: Row(
                  children: widget.headers.map((header) => _buildHeaderCell(header)).toList(),
                ),
              ),
              Divider(height: 1, color: Colors.black),
              // Isi Table (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _horizontalScrollController,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: _verticalScrollController,
                    child: Column(
                      children: widget.data.map((row) => _buildDataRow(row)).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget untuk First Column
  Widget _buildFirstColumnCell(String text) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.grey[200],
      ),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  // Widget untuk Header
  Widget _buildHeaderCell(String text) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.grey[300],
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // Widget untuk satu baris data
  Widget _buildDataRow(List<String> row) {
    return Row(
      children: row.map((cell) => _buildDataCell(cell)).toList(),
    );
  }

  // Widget untuk isi data
  Widget _buildDataCell(String text) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Text(text),
    );
  }
}
