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
  // Pilihan awal (null untuk hint)
  String? selectedItem;

  // Daftar item untuk dropdown
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: CustomTextField(label: "label", controller: TextEditingController(), style: TextFieldStyle
            .standard,),
          ),
          CustomDropdown(
            items: dropdownItems,
            hint: "Pilih Teknologi",
            // search: true,
            type: DropdownType.multipleSelect,
            // style: DropdownStyle.filled,
            onChanged: (value) {
              setState(() {
                selectedItems = value; // Update state saat ada perubahan
              });
            },
          ),
          SizedBox(height: 20),
          CustomDropdown(
            items: dropdownItems,
            hint: "Pilih Teknologi",
            // search: false,
            // type: DropdownType.normal,
            // style: DropdownStyle.outlined,
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
          
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: selectedItem == null ? null : 'Pilih Item', // Floating label muncul setelah memilih
              hintText: selectedItem == null ? 'Pilih Item' : null, // Hint text muncul sebelum memilih
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            ),
            value: selectedItem,
            onChanged: (newValue) {
              setState(() {
                selectedItem = newValue;
              });
            },
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            isExpanded: true,
            // Menambahkan properti untuk menyesuaikan tampilan dropdown
            dropdownColor: Colors.white,
            // Membatasi tinggi dropdown agar tidak terangkat
            itemHeight: 50.0, // Anda dapat menyesuaikan ini sesuai kebutuhan
          ),
        ),




      

        ],
      ),
    );
  }
}
