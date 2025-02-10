import 'package:flutter/material.dart';

enum DropdownType { normal, multipleSelect }

class Listdata {
  final IconData? prefix;
  final String text;
  final String? subtext;
  final IconData? suffix;

  Listdata({this.prefix, required this.text, this.subtext, this.suffix});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'subtext': subtext,
    };
  }
}

enum DropdownStyle { outlined, filled, standard }

class CustomDropdown extends StatefulWidget {
  final List<Listdata> items;
  final String hint;
  final ValueChanged<List<Listdata>>? onChanged;
  final Function? onChanged2;
  final Listdata? initialValue;
  final List<Listdata>? initialValues;
  final bool search;
  final DropdownType type;
  final DropdownStyle style;

  const CustomDropdown({
    Key? key,
    required this.items,
    this.hint = "Pilih item",
    this.onChanged,
    this.onChanged2,
    this.initialValue,
    this.initialValues,
    this.search = false,
    this.type = DropdownType.normal,
    this.style = DropdownStyle.standard,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown>
    with SingleTickerProviderStateMixin {
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
              color: widget.style == DropdownStyle.filled
                  ? const Color.fromRGBO(242, 246, 248, 1)
                  : Colors.white,
              borderRadius: widget.style == DropdownStyle.outlined
                  ? BorderRadius.circular(8)
                  : null,
              border: widget.style == DropdownStyle.outlined
                  ? Border.all(color: Colors.blue, width: 2)
                  : Border(bottom: BorderSide(color: Colors.grey, width: 2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.type == DropdownType.multipleSelect)
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: selectedValues
                              .map((e) => Chip(
                                deleteIcon: Icon(Icons.close, color: Color.fromRGBO(1, 126, 216, 1)),
                                shape: StadiumBorder(side: BorderSide.none),
                                side: BorderSide(color: Color.fromRGBO(225, 242, 255, 1)),
                                backgroundColor: Color.fromRGBO(225, 242, 255, 1),
                                labelStyle: TextStyle(color: Color.fromRGBO(1, 126, 216, 1)),
                                    label: Text(e.text),
                                    onDeleted: () {
                                      setState(() {
                                        selectedValues.remove(e);
                                      });
                                      if (widget.onChanged != null) {
                                        widget.onChanged!(selectedValues);
                                      }
                                    },
                                  ))
                              .toList(),
                        ),
                      if (widget.search)
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: widget.hint,
                            border: InputBorder.none,
                          ),
                          onChanged: _filterItems,
                          onTap: () {
                            if (!isDropdownOpen) _toggleDropdown();
                          },
                        )
                      else
                        Text(
                          widget.type == DropdownType.multipleSelect
                              ? (selectedValues.isEmpty
                                  ? widget.hint
                                  : "${selectedValues.length} item dipilih")
                              : (selectedValue?.text ?? widget.hint),
                        ),
                    ],
                  ),
                ),
                Icon(
                  isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isDropdownOpen
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Column(
                    children: filteredItems.map((Listdata item) {
                      bool isSelected = selectedValues.contains(item);
                      return InkWell(
                        onTap: () {
                          if (widget.type == DropdownType.multipleSelect) {
                            setState(() {
                              isSelected
                                  ? selectedValues.remove(item)
                                  : selectedValues.add(item);
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
                              widget.onChanged!([item]);
                            }
                          }
                        },
                        child: Container(
                          height: 40,
                          color: isSelected ? Colors.blue[200] : Colors.white,
                          child: Row(
                            children: [
                              if (item.prefix != null)
                                Icon(item.prefix, color: Colors.blue),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(item.text),
                                ),
                              ),
                              if (item.suffix != null)
                                Icon(item.suffix, color: Colors.blue),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              : SizedBox(),
        ),
      ],
    );
  }
}
