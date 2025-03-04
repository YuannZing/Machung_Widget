import 'package:component/widgets/custom.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_pagination.dart'; // Sesuaikan dengan nama package-mu

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaginationExample(),
    );
  }
}

class PaginationExample extends StatefulWidget {
  @override
  _PaginationExampleState createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  List<int> _data = List.generate(100, (index) => index + 1); // Contoh data
  int _itemsPerPage = 10;
  int _currentPage = 1;

  List<int> _getPaginatedData() {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    return _data.sublist(startIndex, endIndex > _data.length ? _data.length : endIndex);
  }

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<int> paginatedData = _getPaginatedData();

    return Scaffold(
      appBar: AppBar(title: Text('Pagination Example')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: paginatedData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item ${paginatedData[index]}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PaginationWidget(
              totalItems: _data.length,
              itemsPerPage: _itemsPerPage,
              onPageChanged: _onPageChanged,
              activeColor: primary,
            ),
          ),
        ],
      ),
    );
  }
}
