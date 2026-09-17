import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class OutdoorCarousel extends StatefulWidget {
  const OutdoorCarousel({super.key});

  @override
  State<OutdoorCarousel> createState() => _OutdoorCarouselState();
}

class _OutdoorCarouselState extends State<OutdoorCarousel> {
  final PageController _pageController = PageController(
    viewportFraction: 0.90,
  );

  final List<String> _images = [
    'https://picsum.photos/800/350?random=11',
    'https://picsum.photos/800/350?random=22',
    'https://picsum.photos/800/350?random=33',
    'https://picsum.photos/800/350?random=44',
  ];

  Timer? _timer;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _images.shuffle(Random());

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (!_pageController.hasClients) {
          return;
        }

        final nextPage = (_currentPage + 1) % _images.length;

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    _images[index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _images.length,
            (index) {
              final isActive = index == _currentPage;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isActive ? 18 : 7,
                height: 7,
                margin: const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isActive
                      ? Colors.deepPurple
                      : Colors.grey.shade400,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}