import 'package:flutter/material.dart';
import 'widgets/custom.dart';
import 'package:getwidget/getwidget.dart';

// Widget Stateful untuk menampilkan tombol dan angka
class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0; // Variabel untuk menyimpan angka
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                CustomButton(
                  label: 'Click Me!',
                  onPressed: () {
                    print('Tombol ditekan!');
                  },
                  width: Sizes.SM,
                  // borderRadiusScale: 0.3,
                  color: Colors.blue,
                  textColor: Colors.white,
                  isDisabled: false,
                ),
                CustomButton(
                  label: 'Click Me!',
                  onPressed: () {
                    CustomSnackBar.show(
                      context,
                      message: "Anda Berhasil Menekan Tombol",
                      duration: Duration(seconds: 5),
                    );
                  },
                  icon: Icons.facebook, // Ikon yang ditampilkan
                  // iconOnRight: true, // Ikon di kanan teks
                  color: secondary,
                  width: Sizes.SM, // Rem dasar
                  // fontScale: 1.5, // Font size 1.5em
                ),
                SizedBox(height: 16.0),
                CustomButton(
                  label: 'Click Me!',
                  onPressed: () {
                    CustomSnackBar.show(
                      context,
                      message: "Anda Berhasil Menekan Tombol",
                      duration: Duration(seconds: 5),
                    );
                  },
                  // icon: Icons.facebook, // Ikon yang ditampilkan
                  // iconOnRight: true, // Ikon di kanan teks
                  color: primary,
                  width: Sizes.XS, // Rem dasar
                  // fontScale: 1.5, // Font size 1.5em
                ),
                SizedBox(height: 16.0),
                CustomButton(
                  label: 'Click Me!',
                  onPressed: () {
                    CustomSnackBar.show(
                      context,
                      message: "Anda Berhasil Menekan Tombol",
                      duration: Duration(seconds: 5),
                    );
                  },
                  // icon: Icons.facebook, // Ikon yang ditampilkan
                  // iconOnRight: true, // Ikon di kanan teks
                  color: secondary,
                  width: Sizes.SM, // Rem dasar
                  // fontScale: 1.5, // Font size 1.5em
                ),
                SizedBox(height: 16.0),
                CustomButton(
                  label: 'Click Me!',
                  onPressed: () {
                    CustomSnackBar.show(
                      context,
                      message: "Anda Berhasil Menekan Tombol",
                      duration: Duration(seconds: 5),
                    );
                  },
                  // icon: Icons.facebook, // Ikon yang ditampilkan
                  // iconOnRight: true, // Ikon di kanan teks
                  color: warning,
                  width: Sizes.MD, // Rem dasar
                  // fontScale: 1.5, // Font size 1.5em
                ),
                SizedBox(height: 16.0),
                CustomButton(
                  label: 'Click Me!',
                  onPressed: () {
                    CustomSnackBar.show(
                      context,
                      message: "Anda Berhasil Menekan Tombol",
                      duration: Duration(seconds: 5),
                    );
                  },
                  // icon: Icons.facebook, // Ikon yang ditampilkan
                  // iconOnRight: true, // Ikon di kanan teks
                  color: danger,
                  width: Sizes.LG, // Rem dasar
                  // fontScale: 1.5, // Font size 1.5em
                ),
                SizedBox(height: 16.0),
                CustomButton(
                  label: 'Click Me!',
                  onPressed: () {
                    CustomSnackBar.show(
                      context,
                      message: "Anda Berhasil Menekan Tombol",
                      duration: Duration(seconds: 5),
                    );
                  },
                  // icon: Icons.facebook, // Ikon yang ditampilkan
                  // iconOnRight: true, // Ikon di kanan teks
                  isDisabled: true,
                  width: Sizes.XL, // Rem dasar
                  // fontScale: 1.5, // Font size 1.5em
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: Column(
                    children: [
                      CustomTextField(
                        label:
                            'Enter your name', // Label yang tampil di dalam input
                        controller:
                            TextEditingController(), // Controller untuk input
                        style: TextFieldStyle.filled, // Mengatur gaya input
                      ),
                      SizedBox(height: 16.0),

                      CustomTextField(
                        label: 'Outlined with Prefix & Suffix',
                        controller: TextEditingController(),
                        style: TextFieldStyle.outlined,
                        prefix: Icon(Icons.email),
                        suffix: Icon(Icons.check_circle),
                      ),
                      SizedBox(height: 16.0),
                      CustomTextField(
                        label: 'Filled with Prefix',
                        controller: TextEditingController(),
                        style: TextFieldStyle.filled,
                        prefix: Icon(Icons.phone),
                      ),
                      SizedBox(height: 16.0),
                      CustomTextField(
                        label: 'Standard with Suffix',
                        controller: TextEditingController(),
                        style: TextFieldStyle.standard,
                        suffix: Icon(Icons.visibility),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                CustomButton(
                  label: "Masuk",
                  onPressed: () {},
                  color: Colors.blue,
                  textColor: Colors.white,
                  prefixIcon: Icons.login, // Ikon di depan teks
                  suffixIcon: Icons.arrow_forward, // Ikon di belakang teks
                ),
                SizedBox(height: 16.0),
                CustomButton(
                  label: "Masuk",
                  onPressed: () {},
                  color: Colors.blue,
                  textColor: Colors.white,
                  prefixIcon: Icons.login, // Ikon di depan teks
                ),
                SizedBox(height: 16.0),

                CustomButton(
                  label: "Keluar",
                  onPressed: () {},
                  color: Colors.blue,
                  textColor: Colors.white,
                  suffixIcon: Icons.arrow_forward, // Ikon di belakang teks
                ),

                SizedBox(height: 16.0),
                // CustomTile(
                //   leadingIcon: Icons.person,
                //   title: "John Doe",
                //   subtitle: "Software Engineer",
                //   trailingIcon: Icons.arrow_forward_ios,
                //   onTap: () {
                //     print("Tile tapped!");
                //   },
                //   baseSize: Sizes.MD, // Ukuran dasar (rem)
                //   backgroundColor: Colors.blue.shade50,
                //   titleColor: Colors.blue.shade900,
                //   subtitleColor: Colors.blue.shade600,
                //   borderRadius: 12.0,
                // ),
                // SizedBox(height: 16.0),
                // CustomTile(
                //   leadingIcon: Icons.settings,
                //   title: "Settings",
                //   trailingIcon: Icons.chevron_right,
                //   onTap: () {
                //     print("Settings tapped!");
                //   },
                //   baseSize: Sizes.MD,
                // ),
              ],
            ),
          ),

          // Tampilkan angka
          Text(
            '$_counter', // Menampilkan nilai angka
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20), // Spasi antar widget
          // CustomButton untuk menambah angka
          CustomButton(
            label: 'Primary',
            onPressed: () {
              setState(() {
                _counter++; // Tambahkan angka
              });
            },
            color: primary,
            // baseSize: Sizes.medium, // Rem dasar
          ),
          SizedBox(height: 20),
          // CustomButton untuk menambah angka
          CustomButton(
            label: 'Secondary',
            onPressed: () {
              setState(() {
                _counter++; // Tambahkan angka
              });
            },
            color: secondary,
            // baseSize: Sizes.medium, // Rem dasar
          ),
          SizedBox(height: 20),
          // CustomButton untuk menambah angka
          CustomButton(
            label: 'Warning',
            onPressed: () {
              setState(() {
                _counter++; // Tambahkan angka
              });
            },
            color: warning,
            // baseSize: Sizes.medium, // Rem dasar
          ),
          SizedBox(height: 20),
          // CustomButton untuk menambah angka
          CustomButton(
            label: 'Danger',
            onPressed: () {
              setState(() {
                _counter++; // Tambahkan angka
              });
            },
            color: danger,
            // baseSize: Sizes.medium, // Rem dasar
          ),
          SizedBox(height: 20),
          // CustomButton untuk menambah angka
          CustomButton(
            label: 'Disabled',
            onPressed: () {
              setState(() {
                _counter++; // Tambahkan angka
              });
            },
            isDisabled: true,

            // baseSize: Sizes.medium, // Rem dasar
          ),
          SizedBox(height: 20),
          GFButton(
            onPressed: () {},
            text: "primary",
            icon: Icon(Icons.facebook),
            size: GFSize.MEDIUM,
          ),
          CustomToggle(
            initialValue: false,
            activeColor: Colors.blue,
            // inactiveColor: Colors.red,
            onChanged: (bool isActive) {
              print('Toggle state: $isActive');
            },
          ),
        ],
      ),
    );
  }
}
