import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'produit_model.dart';

// Widget ProduitBox avec Checkbox et Slidable - Atelier 1 & 2
class ProduitBox extends StatelessWidget {
  final Produit produit;
  final Function(bool?) onChanged;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const ProduitBox({
    super.key,
    required this.produit,
    required this.onChanged,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Slidable(
        // Suppression par swipe - Atelier 1
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => onDelete(),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Supprimer',
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Checkbox pour sélection - Atelier 1
                Checkbox(
                  value: produit.isSelected,
                  onChanged: onChanged,
                ),
                
                // Image - Atelier 2
                if (produit.photo.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      produit.photo,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        );
                      },
                    ),
                  )
                else
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image, color: Colors.grey),
                  ),
                
                const SizedBox(width: 12),
                
                // Libellé du produit
                Expanded(
                  child: Text(
                    produit.libelle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
