import 'package:flutter/material.dart';

class AddProduit extends StatelessWidget {
  final TextEditingController nomController;
  final VoidCallback onAdd;
  final VoidCallback onCancel;

  const AddProduit({
    super.key,
    required this.nomController,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajout d\'un produit'),
      content: TextField(
        controller: nomController,
        decoration: const InputDecoration(hintText: 'Nom du produit'),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: onAdd,
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}
