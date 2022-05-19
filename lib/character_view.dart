import 'package:flutter/material.dart';
import 'package:vampire_sheet/character_info.dart';
import 'package:vampire_sheet/database.dart';

Future<VampireDatabase> database = createVampireDatabase();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(
        title: 'Vampire Character Sheet',
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          onPressed: () {},
          backgroundColor: Colors.red,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
