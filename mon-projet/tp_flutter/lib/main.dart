import 'package:flutter/material.dart';
import 'data/base.dart';
import 'dao/produit_dao.dart';
import 'produits_list.dart';

void main() {
  final database = ProduitsDatabase();
  final dao = ProduitDao(database);
  runApp(MainApp(dao: dao));
}

class MainApp extends StatelessWidget {
  final ProduitDao dao;

  const MainApp({super.key, required this.dao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFEF7FF), // Light background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFEF7FF),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: ProduitsList(dao: dao),
    );
  }
}
