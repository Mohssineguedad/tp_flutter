import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'data/base.dart';

class ProduitDetails extends StatelessWidget {
  final Produit produit;

  const ProduitDetails({super.key, required this.produit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(produit.libelle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (produit.photo.isNotEmpty)
              Center(
                child: kIsWeb
                    ? Image.network(
                        produit.photo,
                        height: 250,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 100);
                        },
                      )
                    : Image.file(
                        File(produit.photo),
                        height: 250,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 100);
                        },
                      ),
              )
            else
              const Center(child: Icon(Icons.image_not_supported, size: 100)),
            const SizedBox(height: 20),
            Text(
              produit.libelle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              '${produit.prix} MAD',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              produit.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
