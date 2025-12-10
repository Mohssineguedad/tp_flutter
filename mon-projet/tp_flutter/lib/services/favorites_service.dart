
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FavoritesService {
  static final FavoritesService _instance = FavoritesService._internal();

  factory FavoritesService() {
    return _instance;
  }

  FavoritesService._internal();

  // Map: UserId -> list of favorite product IDs
  final Map<String, Set<int>> _cache = {};
  bool _initialized = false;

  Future<File> get _file async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/favorites.json');
  }

  Future<void> init() async {
    if (_initialized) return;
    try {
      final file = await _file;
      if (await file.exists()) {
        final content = await file.readAsString();
        final Map<String, dynamic> json = jsonDecode(content);
        json.forEach((key, value) {
          final List<dynamic> ids = value;
          _cache[key] = ids.map((e) => e as int).toSet();
        });
      }
    } catch (e) {
      print('Error loading favorites: $e');
    }
    _initialized = true;
  }

  Future<void> _save() async {
    try {
      final file = await _file;
      final Map<String, List<int>> data = {};
      _cache.forEach((key, value) {
        data[key] = value.toList();
      });
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  bool isFavorite(String userId, int productId) {
    return _cache[userId]?.contains(productId) ?? false;
  }

  Future<void> toggleFavorite(String userId, int productId) async {
    if (!_cache.containsKey(userId)) {
      _cache[userId] = {};
    }

    if (_cache[userId]!.contains(productId)) {
      _cache[userId]!.remove(productId);
    } else {
      _cache[userId]!.add(productId);
    }

    await _save();
  }

  Set<int> getFavorites(String userId) {
    return _cache[userId] ?? {};
  }
}
