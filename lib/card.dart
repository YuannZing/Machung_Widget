import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/custom.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsetsDirectional.only(start: 20, end: 20),
            child: Column(
              children: [
                CustomCard(
                  title: "Judul 1",
                  content:
                      "Ini adalah deskripsi untuk card pertamaaaaaaaaaaaaaaaaaaaaaaaaaaa.",
                  onTap: () {
                    print("Card 1 clicked!");
                  },
                ),
                CustomCard(
                  title: "Judul 2",
                  content: "Kartu ini memiliki lebar 300 pixel.",
                  width: 350, // Set lebar kartu
                  backgroundColor: Colors.blue[50]!,
                  onTap: () {
                    print("Card 2 clicked!");
                  },
                ),
                CustomCard(
                  title: "Judul 2",
                  content: "Ini adalah deskripsi untuk card kedua.",
                  backgroundColor: Colors.blue[50]!,
                  borderRadius: 16.0,
                  titleStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  contentStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[700],
                  ),
                  onTap: () {
                    print("Card 2 clicked!");
                  },
                ),
                CustomCard(
                  title: "Kartu dengan Gambar Lokal",
                  content: "Ini adalah kartu dengan gambar lokal.",
                  imageAsset: "assets/images/image.png", // Path ke gambar lokal
                  onTap: () {
                    print("Card dengan gambar lokal di-klik!");
                  },
                ),
                CustomCard(
                  title: "Machung University",
                  content:
                      "Ma Chung University is an Indonesian private university located in Villa Puncak Tidar, Malang City, East Java. ",
                  imageUrl:
                      "https://cdn.rri.co.id/berita/50/images/1683378478013-IMG_6589/1683378478013-IMG_6589.jpeg",
                  onTap: () {
                    print("Card dengan gambar lokal di samping di-klik!");
                  },
                ),
                CustomCard(
                  title: "Custom Card",
                  content: "Klik tautan di bawah untuk informasi lebih lanjut.",
                  imageUrl: "https://i.pinimg.com/736x/2d/0e/6b/2d0e6b20eb617c56109d9baadd60051e.jpg", // Gambar lokal
                  width: 300,
                  links: [
                    {
                      'title': "INSTAGRAM",
                      'linkurl': "https://www.instagram.com/krisnadwiaryandi/",
                    },
                    {
                      'title': "FACEBOOK",
                      'linkurl': "https://www.facebook.com/farrel.d.purnama",
                    },
                  ],
                ),
                CustomCard(
                  title: "Custom Card",
                  content: "This card contains links without URL Launcher.",
                  imageAsset: "assets/images/image.jpg", // Gambar lokal
                  width: 300,
                  links: [
                    {
                      'title': "Flutter",
                      'linkurl': "https://flutter.dev",
                    },
                    {
                      'title': "FACEBOOK",
                      'linkurl': "https://dart.dev",
                    },
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
