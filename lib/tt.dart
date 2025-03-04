import 'package:flutter/material.dart';


class OverlayMultiSelectSearchExample extends StatefulWidget {
  @override
  _OverlayMultiSelectSearchExampleState createState() => _OverlayMultiSelectSearchExampleState();
}

class _OverlayMultiSelectSearchExampleState extends State<OverlayMultiSelectSearchExample> {
  OverlayEntry? overlayEntry;
  Set<int> selectedItems = {}; // Menyimpan item yang dipilih
  TextEditingController searchController = TextEditingController();
  List<String> allItems = ["Apel", "Jeruk", "Mangga", "Pisang", "Anggur"];
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(allItems);
  }

  void showOverlay(BuildContext context) {
    if (overlayEntry != null) return;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 150,
        left: 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Hasil item yang dipilih
                if (selectedItems.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 5,
                      children: selectedItems.map((index) {
                        return Chip(
                          label: Text(allItems[index]),
                          backgroundColor: Colors.blue,
                          labelStyle: TextStyle(color: Colors.white),
                          deleteIcon: Icon(Icons.close, color: Colors.white),
                          onDeleted: () {
                            setState(() {
                              selectedItems.remove(index);
                              overlayEntry?.markNeedsBuild();
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),

                // Search bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Cari item...",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredItems = allItems
                            .where((item) => item.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                        overlayEntry?.markNeedsBuild();
                      });
                    },
                  ),
                ),

                // List item dengan multiple select
                Container(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      int originalIndex = allItems.indexOf(filteredItems[index]);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedItems.contains(originalIndex)) {
                              selectedItems.remove(originalIndex);
                            } else {
                              selectedItems.add(originalIndex);
                            }
                            overlayEntry?.markNeedsBuild();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: selectedItems.contains(originalIndex) ? Colors.blue : Colors.transparent,
                          child: Text(
                            filteredItems[index],
                            style: TextStyle(
                              color: selectedItems.contains(originalIndex) ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
    setState(() {}); // Perbarui state jika diperlukan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Overlay Select + Search")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => showOverlay(context),
              child: Text("Tampilkan Overlay"),
            ),
            SizedBox(height: 100,),
            ElevatedButton(
              onPressed: hideOverlay,
              child: Text("Sembunyikan Overlay"),
            ),
            SizedBox(height: 20),
            Text("Item yang dipilih: ${selectedItems.map((e) => allItems[e]).join(', ')}"),
          ],
        ),
      ),
    );
  }
}
