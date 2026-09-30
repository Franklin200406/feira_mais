import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class OutdoorCarousel extends StatefulWidget {
  const OutdoorCarousel({super.key});

  @override
  State<OutdoorCarousel> createState() => _OutdoorCarouselState();
}

class _OutdoorCarouselState extends State<OutdoorCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.90);

  // Propagandas de lojas do varejo local.
  // Fotos: Wikimedia Commons.
  final List<_StoreAd> _ads = [
    const _StoreAd(
      storeName: 'Hortifruti Da Terra',
      slogan: 'Frutas e verduras fresquinhas todos os dias',
      tag: 'Hortifruti',
      imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/24/Outdoor_market_fruit_and_vegetable_stall_Market_Place_Romford_London_01.jpg/1280px-Outdoor_market_fruit_and_vegetable_stall_Market_Place_Romford_London_01.jpg',
    ),
    const _StoreAd(
      storeName: 'Padaria Pão Quentinho',
      slogan: 'Pães artesanais saindo do forno a toda hora',
      tag: 'Padaria',
      imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3b/Bread_at_a_Massachusetts_bakery.jpg/1280px-Bread_at_a_Massachusetts_bakery.jpg',
    ),
    const _StoreAd(
      storeName: 'Calçados Passo Certo',
      slogan: 'Conforto e estilo para todos os passos',
      tag: 'Calçados',
      imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b0/Genuine_leather_shoes_in_shop_window.jpg/1280px-Genuine_leather_shoes_in_shop_window.jpg',
    ),
    const _StoreAd(
      storeName: 'Floricultura Jardim Florido',
      slogan: 'Flores e plantas para alegrar a sua casa',
      tag: 'Floricultura',
      imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/37/Floriculture.jpg/1280px-Floriculture.jpg',
    ),
    const _StoreAd(
      storeName: 'Peixaria Maré Alta',
      slogan: 'Peixes e frutos do mar direto do pescador',
      tag: 'Peixaria',
      imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/03/Fresh_fish_displayed_on_a_market_stall_at_the_port_in_Antibes%2C_France_%2854479363589%29.jpg/1280px-Fresh_fish_displayed_on_a_market_stall_at_the_port_in_Antibes%2C_France_%2854479363589%29.jpg',
    ),
  ];

  Timer? _timer;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _ads.shuffle(Random());

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_pageController.hasClients) {
        return;
      }

      final nextPage = (_currentPage + 1) % _ads.length;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
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
    return Column(
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _ads.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _StoreAdBanner(ad: _ads[index]),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_ads.length, (index) {
            final isActive = index == _currentPage;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isActive ? 18 : 7,
              height: 7,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isActive ? Colors.deepPurple : Colors.grey.shade400,
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _StoreAd {
  final String storeName;
  final String slogan;
  final String tag;
  final String imageUrl;

  const _StoreAd({
    required this.storeName,
    required this.slogan,
    required this.tag,
    required this.imageUrl,
  });
}

class _StoreAdBanner extends StatelessWidget {
  final _StoreAd ad;

  const _StoreAdBanner({required this.ad});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Foto da loja
          Image.network(
            ad.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return Container(
                color: Colors.grey.shade200,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.deepPurple.shade100,
                child: const Icon(
                  Icons.storefront_outlined,
                  size: 50,
                  color: Colors.deepPurple,
                ),
              );
            },
          ),

          // Degradê para dar leitura ao texto
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withValues(alpha: 0.75),
                  Colors.black.withValues(alpha: 0.10),
                ],
              ),
            ),
          ),

          // Texto da propaganda
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ad.tag,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  ad.storeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  ad.slogan,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
