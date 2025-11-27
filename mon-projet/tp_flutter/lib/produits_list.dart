import 'package:flutter/material.dart';
import 'model/produit.dart';
import 'produit_box.dart';
import 'add_produit_form.dart';
import 'produit_details.dart';

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  final List<Produit> produits = [];

  void _saveProduit(Produit produit) {
    setState(() {
      produits.add(produit);
    });
  }

  void _addProduit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProduitForm(onAdd: _saveProduit),
      ),
    );
  }

  void _delProduit(int index) {
    setState(() {
      produits.removeAt(index);
    });
  }

  void _deleteSelected() {
    setState(() {
      produits.removeWhere((element) => element.isSelected);
    });
  }

  void _showDetails(Produit produit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProduitDetails(produit: produit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteSelected,
            tooltip: 'Supprimer la sélection',
          ),
        ],
      ),
      body: produits.isEmpty
          ? const Center(child: Text('Aucun produit'))
          : ListView.builder(
              itemCount: produits.length,
              itemBuilder: (context, index) {
                return ProduitBox(
                  produit: produits[index],
                  onChanged: (bool? value) {
                    setState(() {
                      produits[index].isSelected = value!;
                    });
                  },
                  delProduit: (context) => _delProduit(index),
                  onTap: () => _showDetails(produits[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
