import 'package:flutter/material.dart';
import 'widgets/custom.dart';

List<Listdata> dropdownItems = [
  Listdata(
    // prefix: Icons.home,
    text: "Beranda",
    // subtext: "Halaman utama",
    // suffix: Icons.check,
  ),
  Listdata(
    // prefix: Icons.settings,
    text: "Pengaturan",
    subtext: "Atur aplikasi",
    // suffix: Icons.check,
  ),
  Listdata(
    // prefix: Icons.person,
    text: "Profil",
    subtext: "Lihat informasi akun",
    suffix: Icons.check,
  ),
];

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          CustomDropdown(
            items: dropdownItems,
            hint: "Pilih Teknologi",
            search: true,
            type: DropdownType.multipleSelect,
            onChanged: (value) {
              print("Item yang dipilih: $value");
              print("Data: $value");
              print("Tipe data: ${value.runtimeType}");
            },
              
          ),
        ],
      ),
    );
  }
}
