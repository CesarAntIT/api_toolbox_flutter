class GenderPrediction {
  String? name;
  String? gender;
  int? count;
  double? probability;

  GenderPrediction({
    required this.name,
    required this.gender,
    required this.count,
    required this.probability,
  });

  factory GenderPrediction.fromJson(Map<String,dynamic> json){
    return GenderPrediction(
      name: json['name'],
      gender: json['gender'],
      probability: json['probability'],
      count: json['count']
    );
  }

}
