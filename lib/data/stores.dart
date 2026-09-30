import 'package:flutter/material.dart';

import '../models/store.dart';

// Lojas de varejo de Feira de Santana - BA.
// O ranking e os números de pedidos do trimestre são simulados.
// Fotos: Wikimedia Commons.
const List<Store> stores = [
  Store(
    id: 'mersan',
    name: 'Mersan',
    segment: 'Calçados, moda e celulares',
    address: 'Boulevard Shopping – Av. João Durval Carneiro, 3665',
    slogan: 'Tênis, roupas e celulares das marcas que você ama',
    imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f4/Boulevard_Feira_de_Santana.JPG/1280px-Boulevard_Feira_de_Santana.JPG',
    color: Color(0xFFE65100),
    salesRank: 1,
    quarterlyOrders: '12,8 mil',
  ),
  Store(
    id: 'riachuelo',
    name: 'Riachuelo',
    segment: 'Moda e casa',
    address: 'Boulevard Shopping – Av. João Durval Carneiro, 3665',
    slogan: 'Moda para toda a família e decoração para a sua casa',
    imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e4/Lojas_Riachuelo_Bras%C3%ADlia.JPG/1280px-Lojas_Riachuelo_Bras%C3%ADlia.JPG',
    color: Color(0xFF1D1D1B),
    salesRank: 2,
    quarterlyOrders: '10,4 mil',
  ),
  Store(
    id: 'cea',
    name: 'C&A',
    segment: 'Moda e acessórios',
    address: 'Boulevard Shopping – Av. João Durval Carneiro, 3665',
    slogan: 'Looks e acessórios para todos os estilos',
    imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/44/Loja_C%26A_Uberaba.jpg/1280px-Loja_C%26A_Uberaba.jpg',
    color: Color(0xFF0033A0),
    salesRank: 3,
    quarterlyOrders: '9,7 mil',
  ),
  Store(
    id: 'magalu',
    name: 'Magalu',
    segment: 'Eletrônicos, informática e casa',
    address: 'Boulevard Shopping – Av. João Durval Carneiro, 3665',
    slogan: 'Tecnologia e eletrodomésticos com entrega rápida',
    imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9d/Magazine_Luiza_Avare_REFON.jpg/1280px-Magazine_Luiza_Avare_REFON.jpg',
    color: Color(0xFF0086FF),
    salesRank: 4,
    quarterlyOrders: '8,9 mil',
  ),
  Store(
    id: 'renner',
    name: 'Renner',
    segment: 'Moda, bolsas e relógios',
    address: 'Boulevard Shopping – Av. João Durval Carneiro, 3665',
    slogan: 'Estilo e qualidade para o seu dia a dia',
    imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/cb/Renner_-_BarraShopping.jpg/1280px-Renner_-_BarraShopping.jpg',
    color: Color(0xFFD71920),
    salesRank: 5,
    quarterlyOrders: '7,6 mil',
  ),
  Store(
    id: 'centauro',
    name: 'Centauro',
    segment: 'Artigos esportivos',
    address: 'Boulevard Shopping – Av. João Durval Carneiro, 3665',
    slogan: 'Tudo para o seu esporte',
    imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b3/Loja-centauro-fachada-vitrine.jpg/1280px-Loja-centauro-fachada-vitrine.jpg',
    color: Color(0xFFE30613),
  ),
  Store(
    id: 'boticario',
    name: 'O Boticário',
    segment: 'Perfumaria e beleza',
    address: 'Boulevard Shopping – Av. João Durval Carneiro, 3665',
    slogan: 'Perfumes, maquiagem e cuidados para você',
    imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4e/Shopping_Boulevard_Feira_04.jpg/1280px-Shopping_Boulevard_Feira_04.jpg',
    color: Color(0xFF00573F),
  ),
  Store(
    id: 'atakarejo',
    name: 'Atakarejo',
    segment: 'Supermercado',
    address: 'Av. Ayrton Senna – Mangabeira',
    slogan: 'Preço baixo e produtos fresquinhos todo dia',
    imageUrl: 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/24/Outdoor_market_fruit_and_vegetable_stall_Market_Place_Romford_London_01.jpg/1280px-Outdoor_market_fruit_and_vegetable_stall_Market_Place_Romford_London_01.jpg',
    color: Color(0xFFD32F2F),
  ),
];

Store findStore(String id) {
  return stores.firstWhere((store) => store.id == id);
}

// Lojas do carrossel da tela inicial, em ordem de vendas no trimestre
List<Store> get topSellerStores {
  return stores.where((store) => store.isTopSeller).toList()
    ..sort((a, b) => a.salesRank!.compareTo(b.salesRank!));
}
