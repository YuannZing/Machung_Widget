import 'package:flutter/material.dart';

enum DropdownType { normal, multipleSelect }

class Listdata {
  final IconData? prefix;
  final String text;
  final String? subtext;
  final IconData? suffix;

  Listdata({this.prefix, required this.text, this.subtext, this.suffix});
}

class CustomDropdown extends StatefulWidget {
  final List<Listdata> items;
  final String hint;
  final ValueChanged<dynamic>? onChanged;
  final Listdata? initialValue;
  final List<Listdata>? initialValues;
  final bool search;
  final DropdownType type;

  const CustomDropdown({
    Key? key,
    required this.items,
    this.hint = "Pilih item",
    this.onChanged,
    this.initialValue,
    this.initialValues,
    this.search = false,
    this.type = DropdownType.normal,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  Listdata? selectedValue;
  List<Listdata> selectedValues = [];
  List<Listdata> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    selectedValues = widget.initialValues ?? [];
    filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = widget.items
          .where((item) =>
              item.text.toLowerCase().contains(query.toLowerCase()) ||
              (item.subtext != null &&
                  item.subtext!.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  void _toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                ...selectedValues.map((item) => Chip(
                      label: Text(item.text),
                      onDeleted: () {
                        setState(() {
                          selectedValues.remove(item);
                        });
                        if (widget.onChanged != null) {
                          widget.onChanged!(selectedValues);
                        }
                      },
                    )),
                if (selectedValues.isEmpty)
                  Text(
                    widget.hint,
                    style: TextStyle(color: Colors.grey),
                  ),
                Icon(Icons.arrow_drop_down, color: Colors.blue),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            margin: EdgeInsets.only(top: 4),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Column(
              children: filteredItems.map((Listdata item) {
                return ListTile(
                  leading: item.prefix != null
                      ? Icon(item.prefix, color: Colors.blue)
                      : null,
                  title: Text(item.text),
                  subtitle: item.subtext != null
                      ? Text(item.subtext!,
                          style: TextStyle(fontSize: 12, color: Colors.grey))
                      : null,
                  trailing: item.suffix != null
                      ? Icon(item.suffix, color: Colors.blue)
                      : null,
                  onTap: () {
                    if (widget.type == DropdownType.multipleSelect) {
                      setState(() {
                        if (selectedValues.contains(item)) {
                          selectedValues.remove(item);
                        } else {
                          selectedValues.add(item);
                        }
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(selectedValues);
                      }
                    } else {
                      setState(() {
                        selectedValue = item;
                        searchController.text = item.text;
                        isDropdownOpen = false;
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(item);
                      }
                    }
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
