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

        return Scaffold(
          appBar: AppBar(
            title: const Text('Mon Compte'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              )
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blue[50],
                child: Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 10),
                    Text('Connecté en tant que : ${snapshot.data!.email}'),
                  ],
                ),
              ),
              Expanded(
                child: ProduitsList(dao: dao),
              ),
            ],
          ),
        );
      },
    );
  }
}
