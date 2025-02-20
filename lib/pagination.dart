import 'package:flutter/material.dart';

class PaginationExample extends StatefulWidget {
  @override
  _PaginationExampleState createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  List<int> _data = List.generate(30, (index) => index + 1); // 100 data
  int _itemsPerPage = 20; // Menampilkan 20 data per halaman
  int _currentPage = 1;

  // Mengambil data untuk halaman tertentu
  List<int> _getPaginatedData() {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    return _data.sublist(startIndex, endIndex > _data.length ? _data.length : endIndex);
  }

  // Navigasi ke halaman berikutnya
  void _goToNextPage() {
    if ((_currentPage * _itemsPerPage) < _data.length) {
      setState(() {
        _currentPage++;
      });
    }
  }

  // Navigasi ke halaman sebelumnya
  void _goToPreviousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
    }
  }

  // Menampilkan halaman yang bisa dipilih berdasarkan jumlah total halaman
  List<Widget> _buildPageNumbers() {
    int totalPages = (_data.length / _itemsPerPage).ceil();
    List<Widget> pageNumbers = [];

    for (int i = 1; i <= totalPages; i++) {
      pageNumbers.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0), // Margin antar tombol
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _currentPage = i;
              });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // Kotak tanpa melengkung
              ),
              backgroundColor: _currentPage == i ? Colors.blue : Colors.grey, // Warna tombol aktif
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Padding kotak
            ),
            child: Text('$i'),
          ),
        ),
      );
    }

    return pageNumbers;
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
          // Kontrol halaman
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _goToPreviousPage,
                    child: Text('Previous'),
                  ),
                  SizedBox(width: 20),
                  // Menampilkan nomor halaman
                  Row(
                    mainAxisSize: MainAxisSize.min, // Membuat Row minimal
                    children: _buildPageNumbers(),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _goToNextPage,
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
