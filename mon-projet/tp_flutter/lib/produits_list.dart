import 'package:flutter/material.dart';
import 'produit_box.dart';
import 'add_produit.dart';

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  final List<List<dynamic>> produits = [
    ['Produit 1', false],
    ['Produit 2', false],
    ['Produit 3', false],
  ];

  final TextEditingController _nomController = TextEditingController();

  void _addProduit() {
    showDialog(
      context: context,
      builder: (context) {
        return AddProduit(
          nomController: _nomController,
          onAdd: () {
            if (_nomController.text.isNotEmpty) {
              setState(() {
                produits.add([_nomController.text, false]);
              });
              _nomController.clear();
              Navigator.pop(context);
            }
          },
          onCancel: () {
            _nomController.clear();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _delProduit(int index) {
    setState(() {
      produits.removeAt(index);
    });
  }

  void _deleteSelected() {
    setState(() {
      produits.removeWhere((element) => element[1] == true);
    });
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
      body: ListView.builder(
        itemCount: produits.length,
        itemBuilder: (context, index) {
          return ProduitBox(
            nomProduit: produits[index][0],
            selProduit: produits[index][1],
            onChanged: (bool? value) {
              setState(() {
                produits[index][1] = value!;
              });
            },
            delProduit: (context) => _delProduit(index),
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
