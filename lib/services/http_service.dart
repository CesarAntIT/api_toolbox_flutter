import 'dart:convert';

import 'package:api_toolbox_t6/models/gender_prediction.dart';
import 'package:http/http.dart';

class HttpService {
  //Predecir Genero por Edad
  Future<dynamic> getGenderByAge(String name) async {
    var url = Uri.parse("https://api.genderize.io/?name=$name");

    var res = await get(url);
    if (res.statusCode == 200) {
      var classRes = GenderPrediction.fromJson(jsonDecode(res.body));

      if (classRes.gender == null) {
        classRes.gender == "null";
      }

      return classRes;
    } else {
      return print("No se encontro la data");
    }
  }
}
