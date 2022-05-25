import 'package:flutter/material.dart';
import 'package:vampire_sheet/character_info.dart';
import 'package:vampire_sheet/database.dart';

String? validateIfNotEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

class CharacterCreateView extends StatefulWidget {
  const CharacterCreateView({Key? key}) : super(key: key);

  @override
  State<CharacterCreateView> createState() => _CharacterCreateState();
}

class _CharacterCreateState extends State<CharacterCreateView> {
  final _formKey = GlobalKey<FormState>();

  String characterName = "";
  String nature = "";
  String demeanor = "";
  String clan = "";
  int generation = 0;
  String concept = "";
  String? chronicle;
  String? sire;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create a character'),
          actions: [
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }

                  createVampireDatabase().then((db) async {
                    CharacterInfo character = CharacterInfo(
                      characterName,
                      clan: clan,
                      generation: generation,
                      nature: nature,
                      demeanor: demeanor,
                      concept: concept,
                      chronicle: chronicle,
                      sire: sire,
                    );

                    character.databaseId =
                        await db.addCharacterToDatabase(character);

                    Navigator.pop(context);
                  });
                },
                child: const Text('ADD'))
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(helperText: 'Name'),
                validator: validateIfNotEmpty,
                onChanged: (value) {
                  characterName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(helperText: 'Clan'),
                validator: validateIfNotEmpty,
                onChanged: (value) {
                  clan = value;
                },
              ),
              Row(
                children: [
                  const Text('Generation'),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                        items: <int>[8, 9, 10, 11, 12, 13, 14]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              " " + value.toString(),
                              textAlign: TextAlign.right,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          generation = value ?? 0;
                        }),
                  ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(helperText: 'Nature'),
                validator: validateIfNotEmpty,
                onChanged: (value) {
                  nature = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(helperText: 'Demeanor'),
                validator: validateIfNotEmpty,
                onChanged: (value) {
                  demeanor = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(helperText: 'Concept'),
                validator: validateIfNotEmpty,
                onChanged: (value) {
                  concept = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(helperText: 'Chronicle'),
                onChanged: (value) {
                  chronicle = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(helperText: 'Sire'),
                onChanged: (value) {
                  sire = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
