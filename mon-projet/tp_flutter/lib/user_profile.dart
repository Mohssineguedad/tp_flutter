
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dao/produit_dao.dart';
import 'data/base.dart';
import 'services/favorites_service.dart';
import 'produit_box.dart';

class UserProfile extends StatefulWidget {
  final ProduitDao dao;

  const UserProfile({super.key, required this.dao});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final user = FirebaseAuth.instance.currentUser;
  final favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    if (user == null) return const Center(child: Text('Non connecté'));

    final favIds = favoritesService.getFavorites(user!.uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blue[50],
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Text(user!.email![0].toUpperCase()),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user!.email ?? 'Email inconnu',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text('ID: ${user!.uid.substring(0, 5)}...'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mes Favoris',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Produit>>(
              stream: widget.dao.getAllProduits(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final allProduits = snapshot.data!;
                final favorites = allProduits.where((p) => favIds.contains(p.id)).toList();

                if (favorites.isEmpty) {
                  return const Center(child: Text('Aucun favori pour le moment.'));
                }

                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final produit = favorites[index];
                    return ProduitBox(
                      produit: produit,
                      onChanged: null,
                      delProduit: (_) {}, // No delete from here for now
                      onTap: () {},
                      showFavorite: true,
                      isFavorite: true,
                      onToggleFavorite: () async {
                        await favoritesService.toggleFavorite(user!.uid, produit.id);
                        setState(() {});
                      }, 
                      canDelete: false,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
