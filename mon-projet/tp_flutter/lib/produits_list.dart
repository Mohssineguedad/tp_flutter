import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dao/produit_dao.dart';
import 'data/base.dart';
import 'produit_box.dart';
import 'add_produit_form.dart';
import 'produit_details.dart';
import 'user_profile.dart';
import 'services/favorites_service.dart';
import 'package:drift/drift.dart' as drift;

class ProduitsList extends StatefulWidget {
  final ProduitDao dao;

  const ProduitsList({super.key, required this.dao});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  final user = FirebaseAuth.instance.currentUser;
  late bool isAdmin;
  final FavoritesService _favService = FavoritesService();
  bool _isLoadingFavs = true;

  @override
  void initState() {
    super.initState();
    isAdmin = user?.email == 'admin@gmail.com';
    if (!isAdmin && user != null) {
      _favService.init().then((_) {
        if (mounted) {
          setState(() {
            _isLoadingFavs = false;
          });
        }
      });
    } else {
      _isLoadingFavs = false;
    }
  }

  void _addProduit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProduitForm(dao: widget.dao),
      ),
    );
  }

  void _delProduit(Produit produit) {
    widget.dao.deleteProduit(produit);
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
      await widget.dao.insertProduit(p);
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
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.cloud_download, color: Colors.black),
              onPressed: () => _seedData(context),
              tooltip: 'Charger des exemples',
            ),
          if (!isAdmin)
             IconButton(
               icon: const Icon(Icons.person, color: Colors.blue),
               onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfile(dao: widget.dao)));
               },
             ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            tooltip: 'Déconnexion',
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () => FirebaseAuth.instance.signOut(),
            tooltip: 'Se déconnecter',
          ),
        ],
      ),
      body: StreamBuilder<List<Produit>>(
        stream: widget.dao.getAllProduits(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || _isLoadingFavs) {
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
              final isFav = !isAdmin && user != null && _favService.isFavorite(user!.uid, produit.id);
              
              return ProduitBox(
                produit: produit,
                onChanged: null,
                delProduit: (context) => _delProduit(produit),
                onTap: () => _showDetails(context, produit),
                canDelete: isAdmin,
                showFavorite: !isAdmin,
                isFavorite: isFav,
                onToggleFavorite: !isAdmin && user != null 
                    ? () async {
                        await _favService.toggleFavorite(user!.uid, produit.id);
                        setState(() {});
                      } 
                    : null,
              );
            },
          );
        },
      ),
      floatingActionButton: isAdmin ? Container(
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
      ) : null,
    );
  }
}
