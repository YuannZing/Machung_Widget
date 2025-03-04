import 'package:component/widgets/custom.dart';
import 'package:flutter/material.dart';

enum CheckboxType { single, multiple }

class CustomCheckbox extends StatefulWidget {
  final List<String> items;
  final CheckboxType type; // single atau multiple
  final Function(List<String>) onChanged;

  const CustomCheckbox({
    Key? key,
    required this.items,
    this.type = CheckboxType.single, // Defaultnya single
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  List<String> selectedItems = [];

  void _onItemTapped(String item) {
    setState(() {
      if (widget.type == CheckboxType.single) {
        selectedItems = [item]; // Hanya satu yang bisa dipilih
      } else {
        if (selectedItems.contains(item)) {
          selectedItems.remove(item);
        } else {
          selectedItems.add(item);
        }
      }
    });
    widget.onChanged(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.map((item) {
        return GestureDetector(
          onTap: () => _onItemTapped(item),
          child: Row(
            children: [
              Checkbox(
                activeColor: primary,
                value: selectedItems.contains(item),
                onChanged: (value) => _onItemTapped(item),
              ),
              Text(item),
            ],
          ),
        );
      }).toList(),
    );
  }
}
