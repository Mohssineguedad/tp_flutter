import 'package:drift/drift.dart';
import '../data/base.dart';

part 'produit_dao.g.dart';

@DriftAccessor(tables: [Produits])
class ProduitDao extends DatabaseAccessor<ProduitsDatabase>
    with _$ProduitDaoMixin {
  ProduitDao(super.db);

  Stream<List<Produit>> getAllProduits() => select(produits).watch();

  Future insertProduit(ProduitsCompanion produit) =>
      into(produits).insert(produit);

  Future deleteProduit(Produit produit) => delete(produits).delete(produit);

  Future updateProduit(Produit produit) => update(produits).replace(produit);
}
