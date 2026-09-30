import 'package:flutter/material.dart';

// Imagem de produto carregada da internet, com fundo cinza,
// indicador de carregamento e ícone de erro.
class ProductImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double iconSize;
  final double borderRadius;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.iconSize = 60,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl.isEmpty
          ? Icon(Icons.image_outlined, size: iconSize, color: Colors.grey)
          : Image.network(
              imageUrl,
              fit: fit,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                    strokeWidth: 2,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported_outlined,
                  size: iconSize,
                  color: Colors.grey,
                );
              },
            ),
    );
  }
}
