class CharacterInfo {
  CharacterInfo(
    this.databaseId,
    this.characterName, {
    this.nature = "",
    this.demeanor = "",
    required this.clan,
    required this.generation,
    this.concept = "",
    this.chronicle,
    this.sire,
  });

  int databaseId;
  String characterName;
  String nature;
  String demeanor;
  String clan;
  int generation;
  String concept;
  String? chronicle;
  String? sire;
}
