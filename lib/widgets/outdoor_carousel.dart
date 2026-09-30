import 'dart:async';

import 'package:flutter/material.dart';

import '../data/stores.dart';
import '../models/store.dart';
import '../screens/store_screen.dart';
import 'store_avatar.dart';

// Carrossel da tela inicial com as lojas que mais venderam no trimestre
class OutdoorCarousel extends StatefulWidget {
  const OutdoorCarousel({super.key});

  @override
  State<OutdoorCarousel> createState() => _OutdoorCarouselState();
}

class _OutdoorCarouselState extends State<OutdoorCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.90);

  final List<Store> _stores = topSellerStores;

  Timer? _timer;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_pageController.hasClients) {
        return;
      }

      final nextPage = (_currentPage + 1) % _stores.length;

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.orange),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Lojas que mais venderam no trimestre',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 180,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _stores.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final store = _stores[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _StoreBanner(
                  store: store,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoreScreen(store: store),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_stores.length, (index) {
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

class _StoreBanner extends StatelessWidget {
  final Store store;
  final VoidCallback onTap;

  const _StoreBanner({required this.store, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Foto da loja
          Image.network(
            store.imageUrl,
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
                  Colors.black.withValues(alpha: 0.80),
                  Colors.black.withValues(alpha: 0.15),
                ],
              ),
            ),
          ),

          // Texto da propaganda
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Posição no ranking
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${store.salesRank}º mais vendido',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                Row(
                  children: [
                    StoreAvatar(store: store, radius: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        store.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  store.slogan,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),

                const SizedBox(height: 2),

                Text(
                  '${store.quarterlyOrders} pedidos • Ver vitrine ›',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Toque em qualquer parte abre a vitrine da loja
          Material(
            color: Colors.transparent,
            child: InkWell(onTap: onTap),
          ),
        ],
      ),
    );
  }
}
