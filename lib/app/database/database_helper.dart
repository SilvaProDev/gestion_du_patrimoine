import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../modules/marche/models/image_marche.dart';
import '../modules/marche/models/marche_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  static const String _dbName = 'app_database.db';
  static const String _tableUsers = 'users';
  static const String _tableActivities = 'activities';
  static const String _tableMarches = 'marches';
  static const String _tableImagesMarche = 'images_marche';

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: 4, // Augmenter la version pour migrations
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
      await _createImagesMarcheTable(db);
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await _createUsersTable(db);
    await _createActivitiesTable(db);
    await _createMarchesTable(db);
    await _createImagesMarcheTable(db);
  }

  Future<void> _createUsersTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableUsers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        token TEXT
      )
    ''');
  }

  Future<void> _createActivitiesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableActivities (
        activiteId INTEGER PRIMARY KEY,
        libelleActivite TEXT,
        serviceId INTEGER,
        nbreMarche INTEGER,
        exercice INTEGER,
        sig INTEGER
      )
    ''');
  }

  Future<void> _createMarchesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableMarches (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        montant_marche INTEGER,
        libelle_activite TEXT,
        libelle_procedure TEXT,
        activite_id INTEGER,
        objet TEXT,
        exo_id INTEGER
      )
    ''');
  }

  Future<void> _createImagesMarcheTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableImagesMarche (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        longitude TEXT,
        latitude TEXT,
        fichier TEXT,
        observation TEXT,
        marche_id INTEGER,
        is_synced INTEGER DEFAULT 0
      )
    ''');
  }

  // GESTION DES IMAGES MARCHE
  Future<int> insertImageMarche(ImageMarcheModel image) async {
    final db = await database;
    return await db.insert(
      _tableImagesMarche,
      image.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ImageMarcheModel>> getImagesByMarcheId(int marcheId) async {
    final db = await database;
    print("load marché");
    final List<Map<String, dynamic>> maps = await db.query(
      _tableImagesMarche,
      where: 'marche_id = ?', // Filtrer par marche_id
      whereArgs: [marcheId], // Passer le marcheId comme argument
    );

    return List.generate(maps.length, (i) {
      return ImageMarcheModel.fromJson(maps[i]);
    });
  }

  Future<List<ImageMarcheModel>> getUnsyncedImages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query(_tableImagesMarche, where: 'is_synced = ?', whereArgs: [0]);
    return maps.map((map) => ImageMarcheModel.fromJson(map)).toList();
  }

  Future<void> markImageAsSynced(int id) async {
    final db = await database;
    await db.update(
      _tableImagesMarche,
      {'is_synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteImage(int marcheId) async {
    final db = await database;
    return await db.delete(
      _tableImagesMarche,
      where: 'marche_id = ?',
      whereArgs: [marcheId],
    );
  }

  // GESTION DES UTILISATEURS
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(_tableUsers, user);
  }

  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    List<Map<String, dynamic>> users = await db.query(_tableUsers, limit: 1);
    return users.isNotEmpty ? users.first : null;
  }

  Future<int> deleteUser() async {
    final db = await database;
    return await db.delete(_tableUsers);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> users = await db.query(
      _tableUsers,
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return users.isNotEmpty ? users.first : null;
  }

  // GESTION DES ACTIVITÉS
  Future<void> insertActivity(Map<String, dynamic> row) async {
    final db = await database;
    await db.insert(_tableActivities, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, Object?>>> getAllActivitiesHorsLigne() async {
    final db = await database;
    return await db.query(_tableActivities);
  }

  // GESTION DES MARCHÉS
  Future<int> insertMarche(MarcheModel marche) async {
    final db = await database;
    return await db.insert(_tableMarches, marche.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<MarcheModel>> getMarchesByActiviteId(int activiteId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableMarches,
      where: 'activite_id = ?',
      whereArgs: [activiteId],
    );
    return maps.map((map) => MarcheModel.fromJson(map)).toList();
  }
}
