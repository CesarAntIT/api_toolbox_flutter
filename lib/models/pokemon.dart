class Pokemon {
  final String name;
  final String imageUrl;
  final int baseExperience;
  final List<String> abilities;
  final String cryUrl;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.baseExperience,
    required this.abilities,
    required this.cryUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    // Extraer nombres de habilidades
    var abilitiesList = (json['abilities'] as List)
        .map((a) => a['ability']['name'].toString())
        .toList();

    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'] ?? 
                json['sprites']['front_default'],
      baseExperience: json['base_experience'],
      abilities: abilitiesList,
      cryUrl: json['cries']['latest'],
    );
  }
}