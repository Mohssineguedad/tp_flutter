import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/material.dart';

import 'data/base.dart';
import 'dao/produit_dao.dart';
import 'produits_list.dart';

class LoginEcran extends StatelessWidget {
  const LoginEcran({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialise la base locale et le DAO
    final database = ProduitsDatabase();
    final dao = ProduitDao(database);

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Si connecté, affiche directement la liste/écran principal
          return ProduitsList(dao: dao);
        }

        // Sinon affiche l'écran de connexion
        return fui.SignInScreen(
          providers: [
            fui.EmailAuthProvider(),
          ],
        );
      },
    );
  }
}
