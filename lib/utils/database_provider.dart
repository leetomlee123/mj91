import 'dart:io';

import 'package:mj91/pages/movie_player/movie_player_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider {
  DataBaseProvider._();

  static final String dbName = "movie_record";

  static final DataBaseProvider dbProvider = DataBaseProvider._();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "$dbName.db";
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE movie_record ("
          "id TEXT primary key,"
          "name TEXT,"
          "cover TEXT,"
          "position INTEGER"
          ")");
    });
  }

  addMovieRecord(MovieRecord movieRecord) async {
    final db = await database;
    var raw = await db!.insert(
      dbName,
      movieRecord.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateMovieRecord(MovieRecord movieRecord) async {
    final db = await database;
    var response = await db!.update(dbName, movieRecord.toMap(),
        where: "id = ?", whereArgs: [movieRecord.id]);
    return response;
  }

  Future<List<MovieRecord>> getAllRecords() async {
    final db = await database;
    List response = await db!.query(dbName);
    List<MovieRecord> list =
        response.map((c) => MovieRecord.fromMap(c)).toList();
    return list;
  }

//return single person with id
  Future<MovieRecord?> getMovieRecordWithId(var id) async {
    final db = await database;
    List response = await db!.query(dbName, where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? MovieRecord.fromMap(response.first) : null;
  }
}
