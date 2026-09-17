import 'package:flutter/material.dart';

import 'more_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Carrinho',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 58,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Seu carrinho está vazio',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Adicione produtos ao seu carrinho para vê-los aqui.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 28),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continuar comprando',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          if (index == 0) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          }

          if (index == 3) {
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => const MoreScreen(),
          ),
        );
      }
    },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            activeIcon: Icon(Icons.menu),
            label: 'Mais',
          ),
        ],
      ),
    );
  }
}