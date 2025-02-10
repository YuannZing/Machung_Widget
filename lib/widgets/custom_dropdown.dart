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

enum DropdownStyle {
  outlined,
  filled,
  standard,
}

class CustomDropdown extends StatefulWidget {
  final List<Listdata> items;
  final String hint;
  final ValueChanged<List<Listdata>>? onChanged;
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
    this.search = false,
    this.initialValue,
    this.initialValues,
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
  OverlayEntry? overlayEntry;
  bool isDropdownOpen = false;
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;
  final GlobalKey containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    selectedValues = widget.initialValues ?? [];

    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
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
    if (isDropdownOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    Future.delayed(Duration.zero, () {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      // RenderBox renderBox = containerKey.currentContext!.findRenderObject() as RenderBox;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      Size size = renderBox.size;

      overlayEntry?.remove();
      overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeOverlay,
                behavior: HitTestBehavior.translucent,
                child: Container(),
              ),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: size.width,
              child: Material(
                color: Colors.transparent,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: widget.items.length > 3
                              ? 150
                              : double.infinity, // Maks 3 item sebelum scroll
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: widget.items.map((item) {
                              bool isSelected = selectedValues.contains(item);

                              return InkWell(
                                onTap: () {
                                  if (widget.type ==
                                      DropdownType.multipleSelect) {
                                    setState(() {
                                      if (isSelected) {
                                        selectedValues.remove(item);
                                      } else {
                                        selectedValues.add(item);
                                      }
                                    });
                                    widget.onChanged?.call(selectedValues);
                                    _showOverlay(); // Update posisi overlay agar item yang dipilih terlihat
                                  } else {
                                    setState(() {
                                      selectedValue = item;
                                      searchController.text = item.text;
                                      // isDropdownOpen = false;
                                    });
                                    widget.onChanged?.call([item]);
                                    _removeOverlay(); // Pastikan overlay ditutup setelah memilih item di mode normal
                                  }
                                },
                                child: Container(
                                  color: isSelected
                                      ? Colors.blue.withOpacity(0.2)
                                      : Colors.transparent,
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      if (item.prefix != null)
                                        Icon(item.prefix, color: Colors.blue),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(item.text),
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

      Overlay.of(context).insert(overlayEntry!);
      animationController.forward();
      setState(() {
        isDropdownOpen = true;
      });
    });
  }

  void _removeOverlay() {
    if (!isDropdownOpen) return;

    animationController.reverse().then((_) {
      overlayEntry?.remove();
      overlayEntry = null;
      setState(() {
        isDropdownOpen = false;
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleDropdown,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: isDropdownOpen ? Colors.blue : Colors.grey,
                    width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.type == DropdownType.multipleSelect)
                    Wrap(
                      spacing: 8,
                      // runSpacing: 4,
                      children: selectedValues
                          .map((e) => Chip(
                                deleteIcon: Icon(Icons.close,
                                    color: Color.fromRGBO(1, 126, 216, 1)),
                                shape: StadiumBorder(side: BorderSide.none),
                                side: BorderSide(
                                    color: Color.fromRGBO(225, 242, 255, 1)),
                                backgroundColor:
                                    Color.fromRGBO(225, 242, 255, 1),
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(1, 126, 216, 1)),
                                label: Text(e.text),
                                onDeleted: () {
                                  setState(() {
                                    selectedValues.remove(e);
                                  });
                                  widget.onChanged?.call(selectedValues);
                                },
                              ))
                          .toList(),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedValue != null
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      Icon(
                        isDropdownOpen
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: isDropdownOpen ? Colors.blue : Colors.grey,
                      ),
                    ],
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
