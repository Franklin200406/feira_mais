import 'package:flutter/material.dart';

import '../models/store.dart';

// Círculo com as iniciais da loja na cor da marca
class StoreAvatar extends StatelessWidget {
  final Store store;
  final double radius;

  const StoreAvatar({super.key, required this.store, this.radius = 24});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: store.color,
      child: Text(
        store.initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.6,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
