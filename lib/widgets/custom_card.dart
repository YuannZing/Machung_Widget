import 'package:component/widgets/custom.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String content;
  final double? width;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final String? imageUrl; // Gambar URL atau null jika pakai asset
  final String? imageAsset; // Gambar lokal dari asset
  final double? imageHeight;
  final bool imageAboveText;
  final List<Map<String, String>>? links; // Daftar tautan

  const CustomCard({
    Key? key,
    required this.title,
    required this.content,
    this.width,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(8.0),
    this.borderRadius = 8.0,
    this.boxShadow,
    this.onTap,
    this.titleStyle,
    this.contentStyle,
    this.imageUrl, // Untuk URL gambar
    this.imageAsset, // Untuk gambar lokal
    this.imageHeight = 150.0,
    this.imageAboveText = true,
    this.links, // Tambahkan properti untuk tautan
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageAboveText && (imageUrl != null || imageAsset != null)) ...[
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(borderRadius),
                ),
                child: imageAsset != null
                    ? Image.asset(
                        imageAsset!,
                        height: imageHeight,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        imageUrl!,
                        height: imageHeight,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(height: 8),
            ],
            if (!imageAboveText && (imageUrl != null || imageAsset != null))
              Row(
                children: [
                  if (imageAsset != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        imageAsset!,
                        height: imageHeight,
                        width: imageHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        imageUrl!,
                        height: imageHeight,
                        width: imageHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                  SizedBox(width: 12),
                ],
              )
            else
              _buildTextContent(),
            if (links != null && links!.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.only(left: padding.horizontal / 2, top: 0, bottom: padding.vertical / 2),
                child: Wrap(
                  spacing: 12.0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: links!.map((link) {
                    return GestureDetector(
                      onTap: () async {
                        final url = link['linkurl'];
                        if (url != null && url.isNotEmpty) {
                          final Uri uri = Uri.parse(url);
                          print('Attempting to launch URL: $url');
                          launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          bool isPressed = false;
                          return GestureDetector(
                            child: Text(
                              link['title'] ?? 'Tautan',
                              style: TextStyle(
                                color: primary,
                                decoration: isPressed
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ??
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: contentStyle ??
                TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
