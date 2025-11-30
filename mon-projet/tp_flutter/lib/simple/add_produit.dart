import 'package:flutter/material.dart';
import 'produit_model.dart';

// Widget AddProduit avec AlertDialog - Atelier 1 & 2
class AddProduit extends StatefulWidget {
  final Function(Produit) onAdd;

  const AddProduit({super.key, required this.onAdd});

  @override
  State<AddProduit> createState() => _AddProduitState();
}

class _AddProduitState extends State<AddProduit> {
  final _formKey = GlobalKey<FormState>();
  final _libelleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prixController = TextEditingController();
  final _photoController = TextEditingController();

  @override
  void dispose() {
    _libelleController.dispose();
    _descriptionController.dispose();
    _prixController.dispose();
    _photoController.dispose();
    super.dispose();
  }

  void _handleAdd() {
    if (_formKey.currentState!.validate()) {
      // Utilisation de l'opérateur cascade (..) - Atelier 2
      final produit = Produit(
        libelle: '',
        description: '',
        prix: 0.0,
        photo: '',
      )
        ..libelle = _libelleController.text
        ..description = _descriptionController.text
        ..prix = double.parse(_prixController.text)
        ..photo = _photoController.text;

      widget.onAdd(produit);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter un produit'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Libellé
              TextFormField(
                controller: _libelleController,
                decoration: const InputDecoration(
                  labelText: 'Libellé',
                  hintText: 'Nom du produit',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un libellé';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              
              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Description du produit',
                ),
              ),
              const SizedBox(height: 10),
              
              // Prix
              TextFormField(
                controller: _prixController,
                decoration: const InputDecoration(
                  labelText: 'Prix',
                  hintText: 'Prix en MAD',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prix';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              
              // Photo URL
              TextFormField(
                controller: _photoController,
                decoration: const InputDecoration(
                  labelText: 'Photo (URL)',
                  hintText: 'URL de l\'image',
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!value.startsWith('http')) {
                      return 'L\'URL doit commencer par http';
                    }
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _handleAdd,
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}
