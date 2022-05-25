import 'package:flutter/material.dart';
import 'package:vampire_sheet/character_create_view.dart';
import 'package:vampire_sheet/character_info.dart';
import 'package:vampire_sheet/database.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({Key? key}) : super(key: key);

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Character Selection')),
        body: FutureBuilder(
          future: createVampireDatabase().then((db) => db.getCharacters()),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: (snapshot.data as List<CharacterInfo>).length,
                itemBuilder: (context, index) => TextButton(
                  child: Text((snapshot.data as List<CharacterInfo>)[index]
                      .characterName),
                  onPressed: () {},
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error!"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        maintainState: false,
                        builder: (context) => const CharacterCreateView()))
                .then((value) => setState(() {}));
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
