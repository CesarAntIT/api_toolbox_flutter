class University {
  final String country;
  final List<String> webPages;
  final String alphaTwoCode;
  final String? stateProvince; // Puede ser nulo según tu JSON
  final String name;
  final List<String> domains;

  University({
    required this.country,
    required this.webPages,
    required this.alphaTwoCode,
    this.stateProvince,
    required this.name,
    required this.domains,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      country: json['country'] ?? '',
      webPages: List<String>.from(json['web_pages'] ?? []),
      alphaTwoCode: json['alpha_two_code'] ?? '',
      name: json['name'] ?? '',
      stateProvince: json['state-province'],
      domains: List<String>.from(json['domains'] ?? []),
    );
  }
}
