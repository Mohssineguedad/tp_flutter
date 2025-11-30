import 'package:flutter/material.dart';
import 'produit_model.dart';
import 'produit_box.dart';
import 'add_produit.dart';
import 'produit_details.dart';

// Liste des produits - Atelier 1 & 2
// StatefulWidget pour gérer l'état local
class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  // Liste de produits en mémoire - Atelier 1
  List<Produit> produits = [
    Produit(
      libelle: 'Adidas Superstar',
      description: 'Chaussures confortables pour enfants',
      prix: 450.0,
      photo: 'https://assets.adidas.com/images/w_600,f_auto,q_auto/4e894c2b76dd4c8e9013aafc016047af_9366/Superstar_Shoes_White_FV3139_01_standard.jpg',
    ),
    Produit(
      libelle: 'Nike Air Max',
      description: 'Sneakers tendance avec amorti Air',
      prix: 1200.0,
      photo: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/99486859-0ff3-46b4-949b-2d16af2ad421/custom-nike-dunk-high-by-you-shoes.png',
    ),
    Produit(
      libelle: 'Converse Chuck Taylor',
      description: 'Classique indémodable',
      prix: 800.0,
      photo: 'https://media.converse.com/is/image/converse/M9160_A_107X1',
    ),
  ];

  // Fonction pour mettre à jour la sélection - Atelier 1
  void updateSelection(int index, bool? value) {
    setState(() {
      produits[index].isSelected = value ?? false;
    });
  }

  // Fonction pour ajouter un produit - Atelier 1 & 2
  void addProduit() {
    showDialog(
      context: context,
      builder: (context) => AddProduit(
        onAdd: (Produit nouveauProduit) {
          setState(() {
            produits.add(nouveauProduit);
          });
        },
      ),
    );
  }

  // Fonction pour supprimer un produit - Atelier 1
  void delProduit(int index) {
    setState(() {
      produits.removeAt(index);
    });
  }

  // Fonction pour supprimer les produits sélectionnés - Atelier 1
  void deleteSelectedProducts() {
    setState(() {
      produits.removeWhere((produit) => produit.isSelected);
    });
  }

  // Naviguer vers les détails - Atelier 2
  void showDetails(Produit produit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProduitDetails(produit: produit),
      ),
    );
  }

  // Vérifier s'il y a des produits sélectionnés
  bool get hasSelectedProducts {
    return produits.any((produit) => produit.isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Produits'),
        actions: [
          // Bouton "Supprimer la sélection" visible uniquement s'il y a des produits sélectionnés
          if (hasSelectedProducts)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: deleteSelectedProducts,
              tooltip: 'Supprimer la sélection',
            ),
        ],
      ),
      body: produits.isEmpty
          ? const Center(
              child: Text(
                'Aucun produit\nAppuyez sur + pour en ajouter',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: produits.length,
              itemBuilder: (context, index) {
                final produit = produits[index];
                return ProduitBox(
                  produit: produit,
                  onChanged: (value) => updateSelection(index, value),
                  onDelete: () => delProduit(index),
                  onTap: () => showDetails(produit),
                );
              },
            ),
      // FloatingActionButton pour ajouter un produit - Atelier 1
      floatingActionButton: FloatingActionButton(
        onPressed: addProduit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
