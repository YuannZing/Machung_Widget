import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final IconData? leadingIcon;      // Ikon di sebelah kiri
  final String title;               // Judul utama
  final String? subtitle;           // Subjudul opsional
  final IconData? trailingIcon;     // Ikon di sebelah kanan
  final VoidCallback? onTap;        // Fungsi saat tile ditekan
  final double baseSize;            // Ukuran dasar (rem)
  final Color backgroundColor;      // Warna latar belakang
  final Color titleColor;           // Warna teks judul
  final Color subtitleColor;        // Warna teks subjudul
  final double borderRadius;        // Radius sudut tile

  const CustomTile({
    Key? key,
    this.leadingIcon,
    required this.title,
    this.subtitle,
    this.trailingIcon,
    this.onTap,
    this.baseSize = 16.0,           // Default ukuran dasar
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.subtitleColor = Colors.grey,
    this.borderRadius = 8.0,        // Default radius sudut
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dimensi dinamis berdasarkan baseSize
    final double padding = baseSize * 0.5; // Padding (0.5rem)
    final double iconSize = baseSize * 1.5; // Ukuran ikon (1.5rem)
    final double titleFontSize = baseSize; // Ukuran font judul (1rem)
    final double subtitleFontSize = baseSize * 0.75; // Ukuran font subjudul (0.75rem)

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            if (leadingIcon != null) ...[
              Icon(
                leadingIcon,
                size: iconSize,
                color: titleColor,
              ),
              SizedBox(width: padding), // Spasi antara ikon dan teks
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: padding * 0.25), // Spasi kecil
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: subtitleFontSize,
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailingIcon != null) ...[
              Icon(
                trailingIcon,
                size: iconSize,
                color: subtitleColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
