import 'package:api_toolbox_t6/models/weather.dart';
import 'package:api_toolbox_t6/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherDr extends StatefulWidget {
  const WeatherDr({super.key});

  @override
  State<WeatherDr> createState() => _WeatherDrState();
}

class _WeatherDrState extends State<WeatherDr> {
  var currentWeather = Weather(
    humidity: 0,
    temperature: 0,
    weatherCode: 0,
    windDirection: 0,
    windSpeed: 0,
  );

  IconData getWeatherIcon(int code) {
    switch (code) {
      case 0:
        return Icons.wb_sunny; // Soleado
      case 1:
      case 2:
        return Icons.wb_cloudy_outlined; // Parcialmente nublado
      case 3:
        return Icons.cloud; // Nublado
      case 45:
      case 48:
        return Icons.foggy; // Niebla
      case 51:
      case 53:
      case 55:
      case 61:
      case 63:
      case 65:
      case 80:
      case 81:
      case 82:
        return Icons.umbrella; // Lluvia (varios niveles)
      case 71:
      case 73:
      case 75:
      case 85:
      case 86:
        return Icons.ac_unit; // Nieve
      case 95:
      case 96:
      case 99:
        return Icons.thunderstorm; // Tormenta
      default:
        return Icons.help_outline; // Desconocido
    }
  }

  void getCurrentWeather() async {
    var res = await HttpService().getCurrentWeather();

    if (res.runtimeType == ErrorDescription) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            res.toString(),
            style: TextStyle(fontWeight: FontWeight(700)),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          showCloseIcon: true,
        ),
      );
    } else {
      setState(() {
        currentWeather = res;
      });
    }
  }

  @override
  void initState() {
    getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "El Clima en República Dóminicana",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Clima Actual de Rep. Dom. \n en el ${DateFormat('dd/MM/y').format(DateTime.now())}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight(800),
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    border: BoxBorder.symmetric(
                      horizontal: BorderSide(width: 0.5),
                    ),
                  ),
                ),
                Icon(getWeatherIcon(currentWeather.weatherCode), size: 200),
                Row(
                  children: [
                    Text("Temperatura:  ", style: TextStyle(fontSize: 20)),
                    Text(
                      "${currentWeather.temperature}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight(800),
                      ),
                    ),
                    Text("°C", style: TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Velocidad del Viento: \nDirección del Viento: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "${currentWeather.windSpeed}\n${currentWeather.windDirection} ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight(800),
                      ),
                    ),
                    Text(" km/h\n°Grados", style: TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  children: [
                    Text("Nivel de Humedad: ", style: TextStyle(fontSize: 20)),
                    Text(
                      "${currentWeather.humidity}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight(800),
                      ),
                    ),
                    Text(" %", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
