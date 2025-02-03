import 'dart:async';
import 'package:flutter/material.dart';

class CarouselCustom extends StatefulWidget {
  final List<String> imageUrls;
  final List<String> captions; // Tambahan teks untuk setiap slide
  final double height;
  final bool autoScroll;
  final Duration scrollDuration;
  final Color activeIndicatorColor;
  final Color inactiveIndicatorColor;
  final double indicatorHeight;
  final double indicatorWidth;
  final Curve transitionCurve;
  final Duration transitionDuration;

  const CarouselCustom({
    Key? key,
    required this.imageUrls,
    required this.captions,
    this.height = 250,
    this.autoScroll = true,
    this.scrollDuration = const Duration(seconds: 3),
    this.activeIndicatorColor = Colors.blue,
    this.inactiveIndicatorColor = Colors.grey,
    this.indicatorHeight = 10.0,
    this.indicatorWidth = 25.0,
    this.transitionCurve = Curves.easeInOut,
    this.transitionDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  _CarouselCustomState createState() => _CarouselCustomState();
}

class _CarouselCustomState extends State<CarouselCustom> {
  late PageController _pageController;
  late int _currentIndex;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentIndex =
        1; // Mulai dari indeks 1 karena indeks 0 adalah slide terakhir (untuk looping)
    _pageController = PageController(initialPage: _currentIndex);

    if (widget.autoScroll) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.scrollDuration, (timer) {
      _nextSlide();
    });
  }

  void _nextSlide() {
    if (_currentIndex == widget.imageUrls.length) {
      _jumpToRealFirst();
    }

    _pageController.nextPage(
      duration: widget.transitionDuration,
      curve: widget.transitionCurve,
    );
  }

  void _jumpToRealFirst() {
    Future.delayed(widget.transitionDuration, () {
      setState(() {
        _currentIndex = 1;
        _pageController.jumpToPage(_currentIndex);
      });
    });
  }

  void _jumpToRealLast() {
    Future.delayed(widget.transitionDuration, () {
      setState(() {
        _currentIndex = widget.imageUrls.length;
        _pageController.jumpToPage(_currentIndex);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tambahkan duplikasi slide pertama & terakhir untuk efek infinite loop
    final List<String> loopedImages = [
      widget.imageUrls.last,
      ...widget.imageUrls,
      widget.imageUrls.first,
    ];

    final List<String> loopedCaptions = [
      widget.captions.last,
      ...widget.captions,
      widget.captions.first,
    ];

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: loopedImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });

              if (index == 0) {
                _jumpToRealLast();
              } else if (index == loopedImages.length - 1) {
                _jumpToRealFirst();
              }
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Gambar utama
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(loopedImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Shadow gradient di bawah gambar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: widget.height / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
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

                  // Teks di bagian kiri bawah gambar
                  Positioned(
                    bottom: 10,
                    left: 15,
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.75, // Maks 70% dari lebar layar
                      
                      child: Text(
                        loopedCaptions[index],
                        
                        softWrap: true, // Pastikan teks wrap jika kepanjangan
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        SizedBox(height: 10),

        // Indikator dengan animasi pil
        AnimatedDotIndicator(
          currentIndex: _currentIndex == 0
              ? widget.imageUrls.length - 1
              : (_currentIndex == loopedImages.length - 1
                  ? 0
                  : _currentIndex - 1),
          itemCount: widget.imageUrls.length,
          activeColor: widget.activeIndicatorColor,
          inactiveColor: widget.inactiveIndicatorColor,
          indicatorHeight: widget.indicatorHeight,
          indicatorWidth: widget.indicatorWidth,
          onDotTap: (index) {
            setState(() {
              _currentIndex = index + 1;
            });
            _pageController.animateToPage(
              _currentIndex,
              duration: widget.transitionDuration,
              curve: widget.transitionCurve,
            );
          },
        ),
      ],
    );
  }
}

class AnimatedDotIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;
  final Color activeColor;
  final Color inactiveColor;
  final double indicatorHeight;
  final double indicatorWidth;
  final Function(int) onDotTap;

  const AnimatedDotIndicator({
    Key? key,
    required this.currentIndex,
    required this.itemCount,
    required this.activeColor,
    required this.inactiveColor,
    required this.indicatorHeight,
    required this.indicatorWidth,
    required this.onDotTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        bool isActive = index == currentIndex;
        return GestureDetector(
          onTap: () => onDotTap(index),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: indicatorHeight,
            width: isActive ? indicatorWidth : indicatorHeight,
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(indicatorHeight / 2),
            ),
          ),
        );
      }),
    );
  }
}
