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
  final int typeCard; // 1: Image above text, 2: Image beside text
  final List<Map<String, String>>? links;
  final Widget? bottomWidget;
  final Widget? topWidget;
  final double height;

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
    this.typeCard = 1, // Default tipe card adalah type 1 (gambar di atas teks)
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
            if (typeCard == 1 && (imageUrl != null || imageAsset != null))
              _buildImageStack(),
            if (typeCard == 2 && (imageUrl != null || imageAsset != null))
              _buildImageBesideText(),
            if (typeCard == 1)
              Padding(
                padding: padding,
                child: _buildTextContent(),
              ),
            if (typeCard == 3 && (imageUrl != null || imageAsset != null))
              _buildTextinImage(),
            if (links != null && links!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padding.horizontal / 2,
                  vertical: padding.vertical / 2,
                ),
                child: _buildLinks(),
              ),
            if (bottomWidget != null && typeCard == 1)
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

  /// **Widget untuk gambar di atas teks (Type 1)**
  Widget _buildImageStack() {
    return SizedBox(
      height: imageHeight ?? 150,
      width: imageWidth ?? double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadius),
            ),
            child: imageAsset != null
                ? Image.asset(imageAsset!, fit: BoxFit.cover)
                : Image.network(imageUrl!, fit: BoxFit.cover),
          ),
          if (topWidget != null)
            Container(
              child: topWidget!,
            ),
        ],
      ),
    );
  }

  /// **Widget untuk gambar di samping teks (Type 2)**
  Widget _buildImageBesideText() {
    return Stack(
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
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: Column(
                  children: [
                    if (topWidget != null) topWidget!,
                    SizedBox(height: 10),
                    _buildTextContent(),
                    if (bottomWidget != null && typeCard == 2)
                      Padding(
                        padding: EdgeInsets.only(),
                        child: bottomWidget!,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // if (bottomWidget != null)
        //   Positioned(
        //     bottom: 10,
        //     right: 10,
        //     child: bottomWidget!,
        //   ),
      ],
    );
  }

  // **Widget untuk teks di dalam gambar (Type 3)**

  Widget _buildTextinImage() {
    return SizedBox(
      height: imageHeight ?? 150,
      width: imageWidth ?? 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: imageAsset != null
                ? Image.asset(imageAsset!, fit: BoxFit.cover)
                : Image.network(imageUrl!, fit: BoxFit.cover),
          ),
          if (topWidget != null)
            Container(
              child: topWidget!,
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(35, 31, 32, 0.75),
                    Color.fromRGBO(76, 86, 92, 0.7),
                    Color.fromRGBO(142, 175, 189, 0),
                  ],
                ),
              ),
            ),
          ),
          // if (typeCard == 3)
          //   Padding(
          //     padding: padding,
          //     child: _buildTextContent(),
          //   ),
          Positioned(
              bottom: 5,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 10),
                child: Container(
                    child: Column(
                  children: [
                    _buildTextContent(),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: bottomWidget!,
                    ),
                  ],
                )),
              )),
        ],
      ),
    );
  }

  /// **Widget untuk menampilkan teks dalam card**
  Widget _buildTextContent() {
    return Container(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment:
            typeCard == 3 ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ??
                TextStyle(
                    fontSize: typeCard == 1 ? 18 : 16,
                    color: typeCard == 3 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
          ),
          Text(
            content,
            maxLines: 3,
            overflow: TextOverflow.clip,
            style: contentStyle ??
                TextStyle(
                    fontSize: typeCard == 1 ? 14 : 10,
                    color: typeCard == 1 ? Colors.grey[700] : Colors.white),
          ),
        ],
      ),
    );
  }

  /// **Widget untuk menampilkan tautan**
  Widget _buildLinks() {
    return Wrap(
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
    );
  }
}
