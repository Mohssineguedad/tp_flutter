// Modèle Produit - Atelier 2
class Produit {
  String libelle;
  String description;
  double prix;
  String photo;
  bool isSelected;

  // Constructeur
  Produit({
    required this.libelle,
    this.description = '',
    this.prix = 0.0,
    this.photo = '',
    this.isSelected = false,
  });

  // Méthode toString
  @override
  String toString() {
    return 'Produit{libelle: $libelle, description: $description, prix: $prix, photo: $photo, isSelected: $isSelected}';
  }
}
