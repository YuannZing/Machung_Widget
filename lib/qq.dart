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
  final bool search;
  final DropdownType type;
  final DropdownStyle style;

  const CustomDropdown({
    Key? key,
    required this.items,
    this.hint = "Pilih item",
    this.onChanged,
    this.initialValue,
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
  OverlayEntry? overlayEntry;
  TextEditingController searchController = TextEditingController();
  bool isDropdownOpen = false;
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;

    animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 0),
      vsync: this,
    );

    slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.2),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
  }

  void _toggleDropdown() {
    if (isDropdownOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;

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
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedValue = item;
                                  });
                                  if (widget.onChanged != null) {
                                    widget.onChanged!([item]);
                                  }
                                  _removeOverlay();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      if (item.prefix != null)
                                        Icon(item.prefix, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(item.text),
                                              if (item.subtext != null)
                                                Text(item.subtext!,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey))
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
                      ),
                    )),
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
            padding: EdgeInsets.only(top: 5),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: isDropdownOpen ? Colors.blue : Colors.grey,
                    width: 2),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedValue?.text ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedValue != null ? Colors.black : Colors.grey,
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
          AnimatedPositioned(
            duration: Duration(milliseconds: 90),
            left: 16,
            top: isDropdownOpen || selectedValue != null ? -2 : 20,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                selectedValue != null ? widget.hint : widget.hint,
                style: TextStyle(
                  fontSize: isDropdownOpen || selectedValue != null ? 12 : 14,
                  color: isDropdownOpen ? Colors.blue : Colors.grey,
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
