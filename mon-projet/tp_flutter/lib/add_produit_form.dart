import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' as drift;
import 'data/base.dart';
import 'dao/produit_dao.dart';

class AddProduitForm extends StatefulWidget {
  final ProduitDao dao;

  const AddProduitForm({super.key, required this.dao});

  @override
  State<AddProduitForm> createState() => _AddProduitFormState();
}

class _AddProduitFormState extends State<AddProduitForm> {
  final _formKey = GlobalKey<FormState>();
  String _libelle = '';
  String _description = '';
  double _prix = 0.0;
  String _photo = '';
  String? _pickedImagePath;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImagePath = image.path;
        _photo = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un produit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: _pickedImagePath == null
                      ? const Icon(Icons.add_a_photo, size: 50)
                      : (kIsWeb
                          ? Image.network(_pickedImagePath!, fit: BoxFit.cover)
                          : Image.file(File(_pickedImagePath!),
                              fit: BoxFit.cover)),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Libellé'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un libellé';
                  }
                  return null;
                },
                onSaved: (value) => _libelle = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prix'),
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
                onSaved: (value) => _prix = double.parse(value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final produit = ProduitsCompanion(
                      libelle: drift.Value(_libelle),
                      description: drift.Value(_description),
                      prix: drift.Value(_prix),
                      photo: drift.Value(_photo),
                    );
                    widget.dao.insertProduit(produit);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
