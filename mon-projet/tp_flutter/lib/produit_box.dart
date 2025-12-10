import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'data/base.dart';

class ProduitBox extends StatelessWidget {
  final Produit produit;
  final Function(bool?)? onChanged;
  final Function(BuildContext) delProduit;
  final VoidCallback onTap;
  
  // New parameters for Atelier 5
  final bool canDelete;
  final bool showFavorite;
  final bool isFavorite;
  final VoidCallback? onToggleFavorite;

  const ProduitBox({
    super.key,
    required this.produit,
    this.onChanged,
    required this.delProduit,
    required this.onTap,
    this.canDelete = false,
    this.showFavorite = false,
    this.isFavorite = false,
    this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    // Only wrap in Slidable if delete is allowed
    Widget content = GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF540), // Yellow color from image
          borderRadius: BorderRadius.circular(50), // Pill shape
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            if (produit.photo.isNotEmpty)
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: kIsWeb
                      ? Image.network(
                          produit.photo,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 40),
                        )
                      : Image.file(
                          File(produit.photo),
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 40),
                        ),
                ),
              )
            else
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image, size: 40, color: Colors.grey),
              ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                produit.libelle.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Favorite Button
            if (showFavorite && onToggleFavorite != null)
              IconButton(
                 icon: Icon(
                   isFavorite ? Icons.favorite : Icons.favorite_border,
                   color: isFavorite ? Colors.red : Colors.grey,
                 ),
                 onPressed: onToggleFavorite,
              ),

            const SizedBox(width: 20),
          ],
        ),
      ),
    );

    if (canDelete) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: delProduit,
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(12),
              ),
            ],
          ),
          child: content,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: content,
    );
  }
}
