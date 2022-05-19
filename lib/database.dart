import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vampire_sheet/character_info.dart';

Future<VampireDatabase> createVampireDatabase() async {
  Database db = await openDatabase('vampires.db', version: 1,
      onCreate: (Database db, int version) async {
    if (version > 0) {
      await db.execute(await rootBundle.loadString('sql/character_table.sql'));
    }
  });
  return VampireDatabase(db);
}

class VampireDatabase {
  VampireDatabase(this.db);
  Database db;

  Future<List<CharacterInfo>> getCharacters() async {
    var rawDatabaseData = await db.query('characters', columns: [
      'id',
      'name',
      'nature',
      'demeanor',
      'clan',
      'generation',
      'concept',
      'chronicle',
      'sire'
    ]);

    List<CharacterInfo> characters = [];
    for (var character in rawDatabaseData) {
      characters.add(CharacterInfo(
          int.parse(character['id']!.toString()), character['name'].toString(),
          clan: character['clan'].toString(),
          generation: int.parse(character['name'].toString())));
    }

    return characters;
  }
}
