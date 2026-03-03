import 'dart:convert';

import 'package:api_toolbox_t6/models/age_prediction.dart';
import 'package:api_toolbox_t6/models/gender_prediction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HttpService {
  //Predecir Genero por Edad
  Future<dynamic> getGenderByName(String name) async {
    var url = Uri.parse("https://api.genderize.io/?name=$name");

    var res = await get(url);
    if (res.statusCode == 200) {
      var classRes = GenderPrediction.fromJson(jsonDecode(res.body));

      if (classRes.gender == null) {
        classRes.gender == "null";
      }

      return classRes;
    } else if (res.statusCode == 429) {
      return ErrorDescription(
        "ERROR: Se llegó al limite de solicitudes para la API",
      );
    }
  }

  Future<dynamic> getAgeByName(String name) async {
    var url = Uri.parse("https://api.agify.io/?name=$name");

    var res = await get(url);
    if (res.statusCode == 200) {
      var classRes = AgePrediction.fromJson(jsonDecode(res.body));
      return classRes;
    } else if (res.statusCode == 429) {
      return ErrorDescription(
        "ERROR: Se llegó al limite de solicitudes para la API",
      );
    }
  }
}
