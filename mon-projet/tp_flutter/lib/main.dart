import 'package:flutter/material.dart';
import 'data/base.dart';
import 'dao/produit_dao.dart';
import 'produits_list.dart';

// Point d'entrée principal - Version Drift (Atelier 3)
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisation de la base de données Drift
    final database = ProduitsDatabase();
    final dao = ProduitDao(database);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Thème avec primarySwatch: Colors.blue
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Page d'accueil = ProduitsList avec DAO Drift
      home: ProduitsList(dao: dao),
    );
  }
}
