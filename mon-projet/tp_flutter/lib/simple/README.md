# Application Flutter - Gestion de Produits (Ateliers 1 & 2)

## 📝 Description

Application Flutter simple de gestion de produits créée selon les spécifications des Ateliers 1 et 2.

### Fonctionnalités implémentées

**Atelier 1 :**
- ✅ Affichage d'une liste de produits
- ✅ Ajout de produits via AlertDialog avec formulaire complet
- ✅ Sélection de produits avec Checkbox
- ✅ Suppression simple (swipe avec flutter_slidable)
- ✅ Suppression multiple des produits sélectionnés
- ✅ Thème global avec `primarySwatch: Colors.blue`

**Atelier 2 :**
- ✅ Modèle Produit complet (libelle, description, prix, photo)
- ✅ Affichage des images (NetworkImage)
- ✅ Formulaire d'ajout avec validation de tous les champs
- ✅ Page de détails du produit
- ✅ Navigation vers les détails au clic 
- ✅ Utilisation de l'opérateur cascade (..)

## 📂 Structure du projet

```
lib/
├── main.dart                      # Point d'entrée principal
└── simple/                        # Version simplifiée (Ateliers 1 & 2)
    ├── produit_model.dart        # Modèle de données Produit
    ├── produits_list.dart        # Liste principale (StatefulWidget)
    ├── produit_box.dart          # Widget d'affichage d'un produit
    ├── add_produit.dart          # Dialog pour ajouter un produit
    └── produit_details.dart      # Page de détails d'un produit
```

## 🚀 Comment lancer l'application

### Option 1 : Depuis VS Code (Recommandé)

1. Ouvrez le projet dans VS Code
2. Sélectionnez un appareil (en bas à droite) :
   - Chrome/Edge (web)
   - Émulateur Android
   - Windows Desktop
3. Appuyez sur **F5** ou cliquez sur le bouton Run

### Option 2 : En ligne de commande

```bash
# Depuis le terminal VS Code (avec Flutter configuré)
flutter run
```

### Option 3 : Lancer sur un appareil spécifique

```bash
# Lister les appareils disponibles
flutter devices

# Lancer sur Chrome
flutter run -d chrome

# Lancer sur Windows
flutter run -d windows

# Lancer sur un émulateur Android
flutter run -d <device-id>
```

## 📱 Utilisation de l'application

### Ajouter un produit
1. Cliquez sur le bouton **+** (FloatingActionButton)
2. Remplissez le formulaire :
   - Libellé (obligatoire)
   - Description (optionnel)
   - Prix (obligatoire, numérique)
   - URL de la photo (optionnel, doit commencer par http)
3. Cliquez sur **Ajouter**

### Sélectionner des produits
- Cochez la checkbox à gauche de chaque produit

### Supprimer un produit
- **Suppression simple** : Swipez le produit vers la gauche et cliquez sur "Supprimer"
- **Suppression multiple** : 
  1. Sélectionnez plusieurs produits avec les checkboxes
  2. Cliquez sur l'icône 🗑️ dans l'AppBar

### Voir les détails
- Cliquez sur un produit dans la liste pour voir ses détails complets

## 🛠️ Technologies utilisées

- **Flutter SDK** : Framework de développement mobile
- **Material Design** : Design system de Google
- **flutter_slidable** : Package pour les actions de swipe

## 📋 Produits d'exemple

L'application démarre avec 3 produits :
- Adidas Superstar (450 MAD)
- Nike Air Max (1200 MAD)  
- Converse Chuck Taylor (800 MAD)

## 🎓 Concepts Flutter utilisés

- StatefulWidget et setState()
- ListView.builder
- Navigation avec Navigator.push
- AlertDialog et Form
- Validation de formulaire
- Opérateur cascade (..)
- Checkbox et gestion d'état
- GestureDetector et onTap
- flutter_slidable pour swipe actions

## 📝 Notes

Cette version utilise une **liste en mémoire** (les données sont perdues au redémarrage). Pour une version avec persistance, voir les fichiers dans le répertoire racine `lib/` qui utilisent Drift/SQLite.
