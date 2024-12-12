import '../models/item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'transport_management.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            text TEXT,
            filename TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertItem(Item item) async {
    try {
      final db = await database;
      await db.insert('items', {
        'category': item.category,
        'text': item.text,
        'filename': item.fileName,
      });
    } catch (e) {

      print('Error inserting item: $e');
    }
  }

  Future<List<Item>> fetchItems() async {
    try {
      final db = await database;
      final data = await db.query('items');
      return data.map((e) => Item(id: e['id'] as int?, category: e['category'] as String, text: e['text'] as String)).toList();
    } catch (e) {

      print('Error fetching items: $e');
      return [];
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      final db = await database;
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    } catch (e) {

      print('Error deleting item: $e');
    }
  }
}
