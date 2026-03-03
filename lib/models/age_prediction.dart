class AgePrediction {
  int count;
  String name;
  int age;

  AgePrediction({required this.count, required this.name, required this.age});

  factory AgePrediction.fromJson(Map<String, dynamic> json) {
    return AgePrediction(
      count: json['count'],
      name: json['name'],
      age: json['age'],
    );
  }
}
