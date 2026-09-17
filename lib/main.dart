import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const FeiraMaisApp());
}

class FeiraMaisApp extends StatelessWidget {
  const FeiraMaisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Feira +',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}