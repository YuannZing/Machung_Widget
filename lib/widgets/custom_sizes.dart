import 'package:flutter/material.dart';

class Sizes {
  // Menentukan ukuran berdasarkan lebar layar
  static double get XS {
    return _getResponsiveSize(0.2); // 3% dari lebar layar
  }

  static double get SM {
    return _getResponsiveSize(0.4); // 3% dari lebar layar
  }

  static double get MD {
    return _getResponsiveSize(0.6); // 6% dari lebar layar
  }

  static double get LG {
    return _getResponsiveSize(0.8); // 8% dari lebar layar
  }

  static double get XL {
    return _getResponsiveSize(1.0); // 8% dari lebar layar
  }

  // Fungsi untuk mendapatkan ukuran lebar responsif
  static double _getResponsiveSize(double percent) {
    double width = _getScreenWidth();
    return width * percent;
  }

  static double _getScreenWidth() {
    return MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.first)
        .size
        .width;
  }

  // Fungsi untuk mendapatkan ukuran tinggi responsif
  // static double _getResponsiveHeight(double percent) {
  //   double height = _getScreenHeight();
  //   return height * percent;
  // }

  // Mendapatkan lebar layar
  // static double _getScreenWidth() {
  //   return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  // }

  // Mendapatkan tinggi layar
  // static double _getScreenHeight() {
  //   return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  // }
}
