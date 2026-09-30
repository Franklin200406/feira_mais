import 'package:flutter/material.dart';

class CategoryCarousel extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryCarousel({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const List<String> categories = [
    'Tudo',
    'Mercado',
    'Moda',
    'Celulares',
    'Eletrônicos',
    'Casa',
    'Beleza',
    'Esportes',
    'Informática',
    'Acessórios',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 18);
        },
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Center(
            child: TextButton(
              onPressed: () {
                onCategorySelected(category);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                foregroundColor: Colors.white,
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}