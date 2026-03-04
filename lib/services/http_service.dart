import 'dart:convert';

import 'package:api_toolbox_t6/models/age_prediction.dart';
import 'package:api_toolbox_t6/models/gender_prediction.dart';
import 'package:api_toolbox_t6/models/pokemon.dart';
import 'package:api_toolbox_t6/models/university.dart';
import 'package:api_toolbox_t6/models/weather.dart';
import 'package:api_toolbox_t6/models/wordpress_post.dart';
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
    } else {
      return ErrorDescription("ERROR: Ocurrió un error al solicitar los datos");
    }
  }

  Future<dynamic> getUniByCountry(String country) async {
    var url = Uri.parse("https://adamix.net/proxy.php?country=$country");

    final res = await get(url);

    if (res.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(res.body);

      if (decodedData.isEmpty) {
        return ErrorDescription(
          "ERROR: El país insertado no tiene universidades",
        );
      }

      return decodedData.map((item) => University.fromJson(item)).toList();
    } else {
      return ErrorDescription("ERROR: Ocurrió un error al solicitar los datos");
    }
  }

  Future<dynamic> getCurrentWeather() async {
    var url = Uri.parse(
      "https://api.open-meteo.com/v1/forecast?latitude=18.4719&longitude=-69.8923&current=relative_humidity_2m,temperature_2m,wind_speed_10m,wind_direction_10m,weather_code&timezone=auto",
    );

    final res = await get(url);
    if (res.statusCode == 200) {
      var returnValue = Weather.fromJson(json.decode(res.body));

      return returnValue;
    } else {
      return ErrorDescription("ERROR: No se pudo obtener los datos de la API");
    }
  }

  Future<Pokemon> getPokemon(String name) async {
    var url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$name');

    final res = await get(url);
    if (res.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("No se encontró el Pokémon");
    }
  }

  Future<List<WordpressPost>> getLatestsPosts(String domain) async {
    var url = Uri.parse("https://$domain/wp-json/wp/v2/posts?per_page=3");

    final res = await get(url);
    if (res.statusCode == 200) {
      final List<dynamic> jsonPosts = json.decode(res.body);
      var returnValue = jsonPosts
          .map((post) => WordpressPost.fromJson(post))
          .toList();
      return returnValue;
    } else {
      throw Exception("ERROR: Error al conectar con WordPress");
    }
  }
}
