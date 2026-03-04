class WordpressPost {
  final String title;
  final String resumen;
  final String link;
  final String fecha;

  WordpressPost({
    required this.title,
    required this.resumen,
    required this.link,
    required this.fecha,
  });

  factory WordpressPost.fromJson(Map<String, dynamic> json) {
    return WordpressPost(
      title: json['title']['rendered'] ?? '',
      resumen: json['excerpt']['rendered'] ?? '',
      link: json['link'] ?? '',
      fecha: json['date'] ?? '',
    );
  }
}
