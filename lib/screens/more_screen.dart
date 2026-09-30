import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'categories_screen.dart';
import 'seller_central_screen.dart';
import 'store_form_screen.dart';


class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

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
    return Scaffold(
      backgroundColor: Colors.white,

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
            backgroundColor: Colors.deepPurple,
            elevation: 0,
            automaticallyImplyLeading: false,
            expandedHeight: 96,
            toolbarHeight: 96,

            titleSpacing: 16,

            title: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                    size: 32,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Usuário Feira +',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 2),

                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Meu Perfil >',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  _MoreMenuItem(
                    icon: Icons.home_outlined,
                    title: 'Início',
                    onTap: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),

                  _MoreMenuItem(
                    icon: Icons.notifications_none,
                    title: 'Notificações',
                    onTap: () {},
                  ),

                  _MoreMenuItem(
                    icon: Icons.favorite_border,
                    title: 'Favoritos',
                    onTap: () {},
                  ),

                  _MoreMenuItem(
                    icon: Icons.history,
                    title: 'Histórico',
                    onTap: () {},
                  ),

                  _MoreMenuItem(
                    icon: Icons.storefront_outlined,
                    title: 'Lojas que sigo',
                    onTap: () {},
                  ),

                  const _SectionDivider(),

                  ...categories.map(
                    (category) {
                      return _MoreMenuItem(
                        icon: Icons.category_outlined,
                        title: category,
                        onTap: () {},
                      );
                    },
                  ),

                  const _SectionDivider(),

                  _MoreMenuItem(
                    icon: Icons.sell_outlined,
                    title: 'Vender',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StoreFormScreen(),
                        ),
                      );
                    },
                  ),

                  _MoreMenuItem(
                    icon: Icons.store_outlined,
                    title: 'Central de Vendedores',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SellerCentralScreen(),
                        ),
                      );
                    },
                  ),

                  _MoreMenuItem(
                    icon: Icons.receipt_long_outlined,
                    title: 'Faturamento',
                    onTap: () {},
                  ),

                  const _SectionDivider(),

                  _MoreMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Configurações',
                    onTap: () {},
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoriesScreen(),
              ),
            );
          }

          if (index == 2) {
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => const CartScreen(),
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

class _MoreMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MoreMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 25,
                color: Colors.black,
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: Divider(
        height: 1,
        color: Colors.grey.shade300,
      ),
    );
  }
}
