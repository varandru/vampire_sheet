import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vampire_sheet/character_info.dart';

Future<VampireDatabase> createVampireDatabase() async {
  // FIXME добавь поддержку десктопа
  // https://pub.dev/packages/sqflite_common_ffi/install
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
      characters.add(CharacterInfo(character['name'].toString(),
          clan: character['clan'].toString(),
          generation: character['generation'] as int));

      characters[characters.length - 1].databaseId = character['id'] as int;
    }

    return characters;
  }

  Future<int> addCharacterToDatabase(CharacterInfo character) {
    return db.insert('characters', {
      'name': character.characterName,
      'nature': character.nature,
      'demeanor': character.demeanor,
      'clan': character.clan,
      'generation': character.generation,
      'concept': character.concept,
      'chronicle': character.chronicle,
      'sire': character.sire,
    });
  }
}
