import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String imageUrl;
  final String originalPrice;
  final String promotionalPrice;

  const ProductCard({
    super.key,
    required this.productName,
    required this.imageUrl,
    required this.originalPrice,
    required this.promotionalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do produto
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: imageUrl.isEmpty
                    ? const Icon(
                        Icons.image_outlined,
                        size: 60,
                        color: Colors.grey,
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported_outlined,
                            size: 60,
                            color: Colors.grey,
                          );
                        },
                      ),
              ),
            ),

            const SizedBox(height: 10),

            // Nome do produto
            Text(
              productName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 6),

            // Preço original
            Text(
              originalPrice,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),

            const SizedBox(height: 2),

            // Preço promocional
            Text(
              promotionalPrice,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}