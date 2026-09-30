import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/product.dart';
import '../models/store.dart';
import '../widgets/product_grid.dart';
import '../widgets/store_avatar.dart';

// Vitrine com todos os produtos de uma loja
class StoreScreen extends StatelessWidget {
  final Store store;

  const StoreScreen({super.key, required this.store});

  List<Product> get storeProducts {
    return products.where((product) => product.storeId == store.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    final saleProducts = storeProducts
        .where((product) => product.isOnSale)
        .toList();
    final regularProducts = storeProducts
        .where((product) => !product.isOnSale)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,

      body: CustomScrollView(
        slivers: [
          // Topo com a foto da loja
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            elevation: 0,
            title: Text(
              store.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Lojas criadas pelo usuário podem não ter foto
                  if (store.imageUrl.isEmpty)
                    Container(color: store.color)
                  else
                    Image.network(
                      store.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: store.color);
                      },
                    ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.deepPurple.withValues(alpha: 0.85),
                          Colors.black.withValues(alpha: 0.25),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Nome e segmento da loja
                Row(
                  children: [
                    StoreAvatar(store: store, radius: 32),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            store.segment,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Destaque de vendas do trimestre
                if (store.isTopSeller) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.emoji_events, color: Colors.orange),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${store.salesRank}ª loja que mais vendeu no '
                            'trimestre • ${store.quarterlyOrders} pedidos',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Informações da loja
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      _StoreInfoRow(
                        icon: Icons.location_on_outlined,
                        text: '${store.address} – Feira de Santana, BA',
                      ),
                      const SizedBox(height: 12),
                      _StoreInfoRow(
                        icon: Icons.storefront_outlined,
                        text: store.slogan,
                      ),
                      const SizedBox(height: 12),
                      _StoreInfoRow(
                        icon: Icons.shopping_bag_outlined,
                        text: '${storeProducts.length} produtos na vitrine',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                if (storeProducts.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'Esta loja ainda não tem produtos na vitrine.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),

                // Produtos em promoção
                if (saleProducts.isNotEmpty) ...[
                  const _SectionTitle(title: 'Ofertas da loja'),
                  ProductGrid(products: saleProducts),
                  const SizedBox(height: 28),
                ],

                // Produtos sem promoção
                if (regularProducts.isNotEmpty) ...[
                  const _SectionTitle(title: 'Produtos'),
                  ProductGrid(products: regularProducts),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _StoreInfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: Colors.deepPurple),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
