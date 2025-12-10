import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'data/base.dart';
import 'dao/produit_dao.dart';
import 'produits_list.dart';
import 'login_ecran.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Attempt to initialize firebase. If options are missing, this might fail or need fallback.
  // Assuming default instance if config exists.
  try {
     await Firebase.initializeApp(
       // options: DefaultFirebaseOptions.currentPlatform, // If flutterfire configured
     );
  } catch (e) {
    print('Firebase initialization failed: $e');
  }
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisation de la base de données Drift
    final database = ProduitsDatabase();
    final dao = ProduitDao(database);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Thème avec primarySwatch: Colors.blue
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Atelier 5 : Authentification via login_ecran
      home: LoginEcran(dao: dao),
    );
  }
}
