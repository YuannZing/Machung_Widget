import 'package:flutter/material.dart';
import 'widgets/custom.dart';

List<Listdata> dropdownItems = [
  Listdata(text: "Beranda"),
  Listdata(text: "Benda"),
  Listdata(text: "Auuuuu"),
  Listdata(text: "Pengaturan", subtext: "Atur aplikasi"),
  Listdata(prefix: Icons.person,text: "Profil", subtext: "Lihat informasi akun", suffix: Icons.import_contacts),
];

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List<Listdata> selectedItems = []; // Menyimpan item yang dipilih

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      child: Column(
        children: [
          CustomDropdown(
            items: dropdownItems,
            hint: "Pilih Teknologi",
            search: true,
            type: DropdownType.multipleSelect,
            onChanged: (value) {
              setState(() {
                selectedItems = value; // Update state saat ada perubahan
              });
            },
          ),
          SizedBox(height: 20),
          Text(
            "Dipilih: ${selectedItems.map((e) => e.toJson()).toList()}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
