import 'package:flutter/material.dart';

class CustomTable extends StatefulWidget {
  final List<String> header;
  final List<String>? firstColumn; // Bisa null atau kosong
  final List<List<String>> data;

  CustomTable({
    required this.header,
    this.firstColumn, // Opsional
    required this.data,
  });

  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  Color headerColor = Color.fromRGBO(255, 255, 255, 1);
  Color columnColor = Color.fromRGBO(255, 255, 255, 1);
  Color borderColor = Color.fromRGBO(128, 196, 244, 1);
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _firstColumnScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _verticalScrollController.addListener(() {
      if (_firstColumnScrollController.hasClients) {
        _firstColumnScrollController.jumpTo(_verticalScrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    _firstColumnScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasFirstColumn =
        widget.firstColumn != null && widget.firstColumn!.isNotEmpty;

    String firstColumnHeader = hasFirstColumn ? widget.header[0] : "";
    List<String> tableHeader =
        hasFirstColumn ? widget.header.sublist(1) : widget.header;

    return Row(
      children: [
        // First Column (Jika ada)
        if (hasFirstColumn)
          Column(
            children: [
              firstColumnHeaderCell(firstColumnHeader), // Header First Column
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification) {
                      _firstColumnScrollController
                          .jumpTo(_verticalScrollController.offset);
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: _firstColumnScrollController,
                    child: Column(
                      children:
                          List.generate(widget.firstColumn!.length, (index) {
                        return firstColumnCell(widget.firstColumn![index]);
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),

        // Data Table (Scroll Horizontal + Vertikal)
        Expanded(
          child: Scrollbar(
            controller: _horizontalScrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(tableHeader),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification) {
                          _firstColumnScrollController
                              .jumpTo(_verticalScrollController.offset);
                        }
                        return true;
                      },
                      child: SingleChildScrollView(
                        controller: _verticalScrollController,
                        child: Column(
                          children: List.generate(widget.data.length, (index) {
                            return buildRow(widget.data[index]);
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Header Tabel
  Widget buildHeader(List<String> tableHeader) {
    return Container(
      color: Colors.blueGrey[300],
      child: Row(
        children: tableHeader.map((text) => tableHeaderCell(text)).toList(),
      ),
    );
  }

  // Baris Data
  Widget buildRow(List<String> rowData) {
    return Row(
      children: rowData.map((text) => tableCell(text)).toList(),
    );
  }

  // Widget untuk header cell
  Widget tableHeaderCell(String text) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.symmetric(
            vertical: BorderSide(color: Color.fromRGBO(128, 196, 244, 1))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Warna shadow
            offset: Offset(0, 4), // Posisi shadow hanya vertikal ke bawah
            blurRadius: 2, // Efek kabur untuk shadow
            spreadRadius: -2, // Shadow tidak menyebar ke samping
          ),
        ],
        color: headerColor,
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Widget untuk body cell
  Widget tableCell(String text) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor), color: columnColor),
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  // Widget untuk Header First Column
  Widget firstColumnHeaderCell(String text) {
    return Container(
      width: 100,
      // height: 50,
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black),
        color: headerColor,
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // Widget untuk First Column
  Widget firstColumnCell(String text) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: columnColor,
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
