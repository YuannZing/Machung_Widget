import 'package:flutter/material.dart';
import 'widgets/custom.dart';

class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int _counter = 0; // Variabel untuk menyimpan angka
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 35),
          CarouselCustom(
            imageUrls: [
              'https://i.pinimg.com/736x/25/d8/59/25d859c73cbe8e437a10422846af5ddd.jpg',
              'https://malangvoice.com/wp-content/uploads/2016/03/Machung-anja.jpg',
              'https://cdn.rri.co.id/berita/50/images/1683378478013-IMG_6589/1683378478013-IMG_6589.jpeg',
            ],
            height: 200,
            captions: [
              'Caption 1',
              'Caption 2',
              'Universitas Ma Chung: Pendaftaran Mahasiswa Baru Tahun Akademik 2025/2026'
            ],
            autoScroll: true, // Menyalakan auto-scroll
            scrollDuration: Duration(seconds: 4), // Durasi slide otomatis
            activeIndicatorColor: primary,
            inactiveIndicatorColor: Colors.grey,
            indicatorHeight: 10.0,
            indicatorWidth: 20.0, // Panjang pill indikator
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Meratakan ke kiri dan kanan
                  children: [
                    Text(
                      "Recomendation",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CustomCard(
                  title: "Universitas Ma Chung",
                  content:
                      "Ma Chung University is an Indonesian private university located in Villa Puncak Tidar, Malang City, East Java. ",
                  topWidget: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color.fromRGBO(0, 101, 176, 1),
                                  Color.fromRGBO(1, 126, 216, 1),
                                ],
                              ),
                            ),
                            child: Text(
                              "General",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10),
                            )),
                      ),
                    ],
                  ),
                  imageUrl:
                      "https://cdn.rri.co.id/berita/50/images/1683378478013-IMG_6589/1683378478013-IMG_6589.jpeg", // Path ke gambar lokal
                  onTap: () {
                    print("Card dengan gambar lokal di-klik!");
                  },
                  bottomWidget: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Meratakan ke kiri dan kanan
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 246, 248, 1),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: Text(
                          "General",
                          style: TextStyle(
                              color: Color.fromRGBO(142, 175, 189, 1)),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Color.fromRGBO(167, 192, 203, 1),
                            size: 16,
                          ),
                          Text(
                            "1h ago",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(142, 175, 189, 1)),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.remove_red_eye_outlined,
                            color: Color.fromRGBO(167, 192, 203, 1),
                            size: 16,
                          ),
                          Text(
                            "2,781",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(142, 175, 189, 1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomCard(
                  title: "Custom Card",
                  content: "Klik tautan di bawah untuk informasi lebih lanjut.",
                  imageUrl:
                      "https://i.pinimg.com/736x/2d/0e/6b/2d0e6b20eb617c56109d9baadd60051e.jpg", // Gambar lokal
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
                  title: "Machung University",
                  content:
                      "Ma Chung University is an Indonesian private university located in Villa Puncak Tidar, Malang City, East Java. ",
                  imageUrl:
                      "https://cdn.rri.co.id/berita/50/images/1683378478013-IMG_6589/1683378478013-IMG_6589.jpeg",
                  onTap: () {
                    print("Card dengan gambar lokal di samping di-klik!");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Meratakan ke kiri dan kanan
                  children: [
                    Text(
                      "Latest",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                CustomCard(
                  title: "Ma Chung Malang Hadirkan Prodi Profesi Apoteker ",
                  titleStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  content:
                      "Ma Chung University is an Indonesian private university located in Villa Puncak Tidar, Malang City, East Java. ",
                  contentStyle: TextStyle(fontSize: 10, color: Colors.grey),
                  imageHeight: 162,
                  width: 354,
                  imageUrl:
                      "https://cdn.rri.co.id/berita/50/images/1683378478013-IMG_6589/1683378478013-IMG_6589.jpeg",
                  onTap: () {},
                  typeCard: 2,
                  topWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromRGBO(0, 101, 176, 1),
                                Color.fromRGBO(1, 126, 216, 1),
                              ],
                            ),
                          ),
                          child: Text(
                            "General",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 10),
                          )),
                    ],
                  ),
                  // imageAboveText: false,
                  bottomWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Color.fromRGBO(167, 192, 203, 1),
                        size: 16,
                      ),
                      Text(
                        "1h ago",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(142, 175, 189, 1)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: Color.fromRGBO(167, 192, 203, 1),
                        size: 16,
                      ),
                      Text(
                        "2,781",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(142, 175, 189, 1)),
                      ),
                    ],
                  ),
                ),
                CustomCard(
                  typeCard: 3,
                  borderRadius: 10,
                  width: 300,
                  title: "Universitas Ma Chung",
                  content:
                      "Ma Chung University is an Indonesian private university located in Villa Puncak Tidar, Malang City, East Java. ",
                  topWidget: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color.fromRGBO(0, 101, 176, 1),
                                  Color.fromRGBO(1, 126, 216, 1),
                                ],
                              ),
                            ),
                            child: Text(
                              "General",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10),
                            )),
                      ),
                    ],
                  ),
                  imageUrl:
                      "https://cdn.rri.co.id/berita/50/images/1683378478013-IMG_6589/1683378478013-IMG_6589.jpeg", // Path ke gambar lokal
                  onTap: () {
                    print("Card dengan gambar lokal di-klik!");
                  },
                  bottomWidget: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .end, // Meratakan ke kiri dan kanan
                    children: [
                      
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Color.fromRGBO(167, 192, 203, 1),
                            size: 16,
                          ),
                          Text(
                            "1h ago",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(142, 175, 189, 1)),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.remove_red_eye_outlined,
                            color: Color.fromRGBO(167, 192, 203, 1),
                            size: 16,
                          ),
                          Text(
                            "2,781",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(142, 175, 189, 1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
