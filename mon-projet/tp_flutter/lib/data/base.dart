import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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
  ProduitsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
