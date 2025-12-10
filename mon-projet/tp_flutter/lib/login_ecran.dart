import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'produits_list.dart';
import 'dao/produit_dao.dart';

class LoginEcran extends StatelessWidget {
  final ProduitDao dao;

  const LoginEcran({super.key, required this.dao});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
          );
        }

        return ProduitsList(dao: dao);
      },
    );
  }
}
