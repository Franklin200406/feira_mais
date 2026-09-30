import 'package:flutter/material.dart';

class Store {
  final String id;
  final String name;

  // Segmento exibido abaixo do nome (ex.: "Moda e calçados")
  final String segment;
  final String address;
  final String slogan;

  // Foto da fachada usada no carrossel e no topo da vitrine
  final String imageUrl;

  // Cor da marca usada no avatar da loja
  final Color color;

  // Posição no ranking de vendas do trimestre (simulado).
  // Nulo quando a loja não está entre as que mais venderam.
  final int? salesRank;

  // Pedidos no trimestre (simulado)
  final String? quarterlyOrders;

  const Store({
    required this.id,
    required this.name,
    required this.segment,
    required this.address,
    required this.slogan,
    required this.imageUrl,
    required this.color,
    this.salesRank,
    this.quarterlyOrders,
  });

  bool get isTopSeller => salesRank != null;

  // Texto do avatar (ex.: "C&A" -> "C&A", "Renner" -> "R", "O Boticário" -> "OB")
  String get initials {
    if (name.length <= 3) {
      return name;
    }

    final words = name.split(' ');
    if (words.length == 1) {
      return name[0].toUpperCase();
    }
    return (words[0][0] + words[1][0]).toUpperCase();
  }
}
