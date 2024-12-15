import 'package:mymovies_app/model/movel_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// for database operatoons

class DatabaseHelper {
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'movies.db');
    return openDatabase(
      path,
      version: 2,
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute(
            'ALTER TABLE Movies ADD COLUMN isFavorite INTEGER DEFAULT 0',
          );
        }
      },
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE Movies(
          id INTEGER PRIMARY KEY,
          title TEXT,
          posterURL TEXT,
          imdbId TEXT,
          isFavorite INTEGER DEFAULT 0
        )
      ''');
      },
    );
  }

  Future<void> insertMovies(List<Movie> movies) async {
    final db = await database;
    for (final movie in movies) {
      await db.insert(
        'Movies',
        movie.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Movie>> getMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Movies');
    return List.generate(maps.length, (i) {
      return Movie.fromJson(maps[i]);
    });
  }

  Future<void> updateFavoriteStatus(int movieId, {bool? isFavorite}) async {
    final db = await database;
    await db.update(
      'Movies',
      {'isFavorite': isFavorite ?? false ? 1 : 0},
      where: 'id = ?',
      whereArgs: [movieId],
    );
  }

  Future<List<Movie>> getFevoriteMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('Movies', where: 'isFavorite = ?', whereArgs: [1]);
    return maps.map(Movie.fromJson).toList();
  }
}
