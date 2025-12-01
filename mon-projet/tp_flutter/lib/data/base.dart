import 'package:drift/drift.dart';
import 'opener.dart'
    if (dart.library.io) 'native_db.dart'
    if (dart.library.html) 'web_db.dart';

part 'base.g.dart';

class Produits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get libelle => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  RealColumn get prix => real()();
  TextColumn get photo => text().withDefault(const Constant(''))();
}

@DriftDatabase(tables: [Produits])
class ProduitsDatabase extends _$ProduitsDatabase {
  ProduitsDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;
}
