import 'package:flutter/material.dart';
import 'simple/produits_list.dart';

// Point d'entrée principal - Version simplifiée Atelier 1 & 2
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Thème avec primarySwatch: Colors.blue - Atelier 1
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Page d'accueil = ProduitsList - Atelier 1
      home: const ProduitsList(),
    );
  }
}
