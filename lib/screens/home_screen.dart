import 'dart:ui';

import 'package:flutter/material.dart';

import '../screens/notifications_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/more_screen.dart';
import '../widgets/category_carousel.dart';
import '../widgets/outdoor_carousel.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Tudo';

  final List<Map<String, String>> products = [
    {
      'category': 'Eletrônicos',
      'name': 'Fone de Ouvido Bluetooth',
      'originalPrice': 'R\$ 119,90',
      'promotionalPrice': 'R\$ 89,90',
    },
    {
      'category': 'Moda',
      'name': 'Tênis Esportivo',
      'originalPrice': 'R\$ 199,90',
      'promotionalPrice': 'R\$ 149,90',
    },
    {
      'category': 'Eletrônicos',
      'name': 'Smartwatch Digital',
      'originalPrice': 'R\$ 249,90',
      'promotionalPrice': 'R\$ 199,90',
    },
    {
      'category': 'Acessórios',
      'name': 'Mochila Escolar',
      'originalPrice': 'R\$ 99,90',
      'promotionalPrice': 'R\$ 79,90',
    },
    {
      'category': 'Casa',
      'name': 'Cafeteira Elétrica',
      'originalPrice': 'R\$ 169,90',
      'promotionalPrice': 'R\$ 129,90',
    },
    {
      'category': 'Eletrônicos',
      'name': 'Caixa de Som Bluetooth',
      'originalPrice': 'R\$ 199,90',
      'promotionalPrice': 'R\$ 159,90',
    },
    {
      'category': 'Celulares',
      'name': 'Smartphone',
      'originalPrice': 'R\$ 1.499,90',
      'promotionalPrice': 'R\$ 1.299,90',
    },
    {
      'category': 'Informática',
      'name': 'Teclado Mecânico',
      'originalPrice': 'R\$ 299,90',
      'promotionalPrice': 'R\$ 229,90',
    },
  ];

  List<Map<String, String>> get filteredProducts {
    if (selectedCategory == 'Tudo') {
      return products;
    }

    return products
        .where((product) => product['category'] == selectedCategory)
        .toList();
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _showProfilePopup(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Fechar perfil',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) {
      return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Container(
                    color: Colors.black.withValues(
                      alpha: 0.30,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    28,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.deepPurple,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 34,
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Usuário Feira +',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Nenhuma conta conectada',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.person_add_outlined,
                            color: Colors.black,
                          ),
                          title: Text(
                            'Adicionar conta',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.switch_account_outlined,
                            color: Colors.black,
                          ),
                          title: Text(
                            'Trocar de conta',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );

      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
return Scaffold(
  backgroundColor: Colors.white,

  body: CustomScrollView(
    slivers: [
      // Cabeçalho superior fixo
      SliverAppBar(
        pinned: true,
        floating: false,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        toolbarHeight: 76,
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Row(
          children: [
            // Foto de perfil
            GestureDetector(
              onTap: () {
              _showProfilePopup(context);
             },
               child: const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                child: Icon(
                Icons.person,
                color: Colors.deepPurple,
                size: 26,
              ),
            ),
          ),

            const SizedBox(width: 10),

            // Barra de pesquisa
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquisar produtos ou lojas',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Notificações
           IconButton(
            onPressed: () {
             Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => const NotificationsScreen(),
            ),
          );
        },
        icon: const Icon(
        Icons.notifications_none,
        color: Colors.white,
        size: 30,
         ),
        ),
          ],
        ),
      ),

      // Carrossel de categorias
      SliverPersistentHeader(
        floating: true,
        pinned: false,
        delegate: _CategoryHeaderDelegate(
          selectedCategory: selectedCategory,
          onCategorySelected: selectCategory,
        ),
      ),

      // Conteúdo da Home
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              if (selectedCategory == 'Tudo') ...[
                const OutdoorCarousel(),

                const SizedBox(height: 24),
              ],
              const Text(
                'Ofertas',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.68,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];

                  return ProductCard(
                    productName: product['name']!,
                    imageUrl: '',
                    originalPrice: product['originalPrice']!,
                    promotionalPrice: product['promotionalPrice']!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ],
  ),

  // Barra de navegação inferior fixa
bottomNavigationBar: BottomNavigationBar(
  currentIndex: 0,
  type: BottomNavigationBarType.fixed,
  backgroundColor: Colors.white,
  selectedItemColor: Colors.orange,
  unselectedItemColor: Colors.black,
  onTap: (index) {
  if (index == 2) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CartScreen(),
      ),
    );
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

class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  _CategoryHeaderDelegate({
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  double get minExtent => 52;

  @override
  double get maxExtent => 52;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return CategoryCarousel(
      selectedCategory: selectedCategory,
      onCategorySelected: onCategorySelected,
    );
  }

  @override
  bool shouldRebuild(covariant _CategoryHeaderDelegate oldDelegate) {
    return selectedCategory != oldDelegate.selectedCategory;
  }
}