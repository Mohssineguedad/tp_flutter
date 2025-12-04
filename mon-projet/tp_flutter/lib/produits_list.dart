import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dao/produit_dao.dart';
import 'data/base.dart';
import 'produit_box.dart';
import 'add_produit_form.dart';
import 'produit_details.dart';
import 'package:drift/drift.dart' as drift;

class ProduitsList extends StatelessWidget {
  final ProduitDao dao;

  const ProduitsList({super.key, required this.dao});

  void _addProduit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProduitForm(dao: dao),
      ),
    );
  }

  void _delProduit(Produit produit) {
    dao.deleteProduit(produit);
  }

  void _showDetails(BuildContext context, Produit produit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProduitDetails(produit: produit),
      ),
    );
  }

  void _seedData(BuildContext context) async {
    final samples = [
      ProduitsCompanion(
        libelle: drift.Value('Adidas Toddler'),
        description: drift.Value('Chaussures confortables pour enfants'),
        prix: drift.Value(450.0),
        photo: drift.Value('https://assets.adidas.com/images/w_600,f_auto,q_auto/4e894c2b76dd4c8e9013aafc016047af_9366/Superstar_Shoes_White_FV3139_01_standard.jpg'),
      ),
      ProduitsCompanion(
        libelle: drift.Value('Nike Air Max'),
        description: drift.Value('Sneakers tendance'),
        prix: drift.Value(1200.0),
        photo: drift.Value('https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/99486859-0ff3-46b4-949b-2d16af2ad421/custom-nike-dunk-high-by-you-shoes.png'),
      ),
      ProduitsCompanion(
        libelle: drift.Value('Converse Chuck Taylor'),
        description: drift.Value('Classique indémodable'),
        prix: drift.Value(800.0),
        photo: drift.Value('https://media.converse.com/is/image/converse/M9160_A_107X1'),
      ),
    ];

    for (var p in samples) {
      await dao.insertProduit(p);
    }
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exemples ajoutés !')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liste des Produits',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_download, color: Colors.black),
            onPressed: () => _seedData(context),
            tooltip: 'Charger des exemples',
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () => FirebaseAuth.instance.signOut(),
            tooltip: 'Se déconnecter',
          ),
        ],
      ),
      body: StreamBuilder<List<Produit>>(
        stream: dao.getAllProduits(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final produits = snapshot.data!;
          if (produits.isEmpty) {
            return const Center(child: Text('Aucun produit'));
          }

          return ListView.builder(
            itemCount: produits.length,
            itemBuilder: (context, index) {
              final produit = produits[index];
              return ProduitBox(
                produit: produit,
                onChanged: (value) {},
                delProduit: (context) => _delProduit(produit),
                onTap: () => _showDetails(context, produit),
              );
            },
          );
        },
      ),
      floatingActionButton: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          color: const Color(0xFFEADDFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: FloatingActionButton(
          onPressed: () => _addProduit(context),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.add, color: Colors.black, size: 30),
        ),
      ),
    );
  }
}
