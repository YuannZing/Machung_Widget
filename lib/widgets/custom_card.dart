import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String content;
  final double width;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final String? imageUrl;
  final String? imageAsset;
  final double? imageHeight;
  final double? imageWidth;
  final bool imageAboveText;
  final List<Map<String, String>>? links;
  final Widget? bottomWidget;
  final Widget? topWidget;
  final double? height;

  const CustomCard({
    Key? key,
    required this.title,
    required this.content,
    this.width = 300,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(8.0),
    this.borderRadius = 8.0,
    this.boxShadow,
    this.onTap,
    this.titleStyle,
    this.contentStyle,
    this.imageUrl,
    this.imageAsset,
    this.imageHeight,
    this.imageWidth,
    this.imageAboveText = true,
    this.links,
    this.bottomWidget,
    this.topWidget,
    this.height = 85,
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
            if (imageAboveText && (imageUrl != null || imageAsset != null))
              SizedBox(
                height:
                    imageHeight ?? 150, // Menentukan ukuran pasti untuk Stack
                width: imageWidth ?? double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(borderRadius),
                      ),
                      child: imageAsset != null
                          ? Image.asset(
                              imageAsset!,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                            ),
                    ),
                    if (topWidget != null && imageAboveText)
                      Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        child: topWidget!,
                      ),
                  ],
                ),
              ),
            if (!imageAboveText && (imageUrl != null || imageAsset != null))
              Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(borderRadius),
                            bottomLeft: Radius.circular(borderRadius)),
                        child: imageAsset != null
                            ? Image.asset(
                                imageAsset!,
                                height: imageHeight ?? 100,
                                width: imageWidth ?? 100,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                imageUrl!,
                                height: imageHeight ?? 100,
                                width: imageWidth ?? 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        // Tambahkan ini agar teks tidak melebihi batas Card
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0, right: 6),
                          child: _buildTextContent(),
                        ),
                      ),
                    ],
                  ),
                  if (bottomWidget != null && !imageAboveText)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: bottomWidget!,
                    ),
                ],
              ),
            if (imageAboveText)
              Padding(
                padding: padding,
                child: _buildTextContent(),
              ),
            if (links != null && links!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padding.horizontal / 2,
                  vertical: padding.vertical / 2,
                ),
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
                          launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Text(
                        link['title'] ?? 'Tautan',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            if (bottomWidget != null && imageAboveText)
              Padding(
                padding: EdgeInsets.only(
                    left: padding.horizontal / 2,
                    top: 0,
                    bottom: padding.vertical / 2,
                    right: padding.horizontal / 2),
                child: bottomWidget!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ??
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 8),
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
