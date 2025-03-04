
import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  final int totalItems;
  final int itemsPerPage;
  final Function(int) onPageChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color TextaciveColor;
  final Color TextinactiveColor;

  const PaginationWidget({
    Key? key,
    required this.totalItems,
    this.itemsPerPage = 20,
    required this.onPageChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.white,
    this.TextaciveColor = Colors.white,
    this.TextinactiveColor = Colors.black,
  }) : super(key: key);

  @override
  _PaginationWidgetState createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  int _currentPage = 1;

  int get totalPages => (widget.totalItems / widget.itemsPerPage).ceil();

  void _goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      setState(() {
        _currentPage = page;
      });
      widget.onPageChanged(_currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: _currentPage > 1 ? () => _goToPage(_currentPage - 1) : null,
        ),
        
        ...List.generate(totalPages, (index) {
          int pageIndex = index + 1;
          return GestureDetector(
            onTap: () => _goToPage(pageIndex),
            child: Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              margin: EdgeInsets.symmetric(horizontal: 4),
              // padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
                color: _currentPage == pageIndex ? widget.activeColor : widget.inactiveColor,
              ),
              child: Text(
                "$pageIndex",
                style: TextStyle(color: _currentPage == pageIndex ? widget.TextaciveColor : widget.TextinactiveColor),
              ),
            ),
          );
        }),
        
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: _currentPage < totalPages ? () => _goToPage(_currentPage + 1) : null,
        ),
      ],
    );
  }
}
