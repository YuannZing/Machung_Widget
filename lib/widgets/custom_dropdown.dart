import 'package:flutter/material.dart';

enum DropdownType { normal, multipleSelect }

class Listdata {
  final IconData? prefix;
  final String text;
  final String? subtext;
  final IconData? suffix;

  Listdata({this.prefix, required this.text, this.subtext, this.suffix});
  // Definisikan toJson() agar bisa dikonversi ke Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'subtext': subtext,
    };
  }
}

class CustomDropdown extends StatefulWidget {
  final List<Listdata> items;
  final String hint;
  final ValueChanged<List<Listdata>>? onChanged; // Bisa single atau multiple
  final Function? onChanged2;
  final Listdata? initialValue;
  final List<Listdata>? initialValues;
  final bool search;
  final DropdownType type;

  const CustomDropdown({
    Key? key,
    required this.items,
    this.hint = "Pilih item",
    this.onChanged,
    this.onChanged2,
    this.initialValue,
    this.initialValues,
    this.search = false,
    this.type = DropdownType.normal, // Default normal
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
              // borderRadius: BorderRadius.circular(12),
              // border bottom only
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Gunakan Expanded untuk membatasi lebar Column
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.type == DropdownType.multipleSelect)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: selectedValues
                                .map((e) => Chip(
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
                        ),
                      if (widget.search)
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: widget.hint,
                              border: InputBorder.none,
                            ),
                            onChanged: _filterItems,
                            onTap: _toggleDropdown,
                          ),
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
                if (isDropdownOpen)
                  Icon(Icons.arrow_drop_down, color: Colors.blue)
                else
                  Icon(Icons.arrow_drop_up, color: Colors.blue),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            // margin: EdgeInsets.only(top: 4),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),

            child: Column(
              children: filteredItems.map((Listdata item) {
                bool isSelected = selectedValues.contains(item);
                return Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue[200] : Colors.white,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (widget.type == DropdownType.multipleSelect) {
                        setState(() {
                          if (isSelected) {
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
                          widget.onChanged!([item]);
                        }
                      }
                    },
                    child: Row(
                      children: [
                        if (item.prefix != null)
                          Icon(item.prefix, color: Colors.blue),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.text),
                                if (item.subtext != null)
                                  Text(item.subtext!,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey))
                              ],
                            ),
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
          ),
      ],
    );
  }
}
