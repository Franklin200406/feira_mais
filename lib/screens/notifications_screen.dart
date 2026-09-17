import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notificações',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _NotificationItem(
            icon: Icons.local_offer_outlined,
            title: 'Novas ofertas disponíveis',
            description:
                'Confira as ofertas disponíveis nas lojas próximas a você.',
          ),
          SizedBox(height: 12),
          _NotificationItem(
            icon: Icons.storefront_outlined,
            title: 'Novas lojas no Feira +',
            description:
                'Novos estabelecimentos foram adicionados à plataforma.',
          ),
          SizedBox(height: 12),
          _NotificationItem(
            icon: Icons.shopping_bag_outlined,
            title: 'Acompanhe seus pedidos',
            description:
                'Quando você realizar uma compra, poderá acompanhar suas atualizações aqui.',
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _NotificationItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
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
    );
  }
}