class Product {
  final String category;
  final String name;

  // Loja que vende o produto (ver lib/data/stores.dart)
  final String storeId;

  // Preço atual de venda
  final String price;

  // Preço antes da promoção; nulo quando o produto não está em promoção
  final String? originalPrice;

  final String description;

  // Imagem de capa exibida no card e no topo da tela do produto
  final String imageUrl;

  // Imagens exibidas na seção de descrição da tela do produto
  final List<String> descriptionImages;

  const Product({
    required this.category,
    required this.name,
    required this.storeId,
    required this.price,
    this.originalPrice,
    required this.description,
    required this.imageUrl,
    this.descriptionImages = const [],
  });

  bool get isOnSale => originalPrice != null;
}
