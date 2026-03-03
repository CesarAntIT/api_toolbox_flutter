import 'package:api_toolbox_t6/models/age_prediction.dart';
import 'package:api_toolbox_t6/services/http_service.dart';
import 'package:api_toolbox_t6/widgets/single_field_form.dart';
import 'package:flutter/material.dart';

class PredictAge extends StatefulWidget {
  const PredictAge({super.key});

  @override
  State<PredictAge> createState() => _PredictAgeState();
}

class _PredictAgeState extends State<PredictAge> {
  late AgePrediction prediction = AgePrediction(
    count: 5000,
    name: "Cesar",
    age: 20,
  );

  final inputController = TextEditingController();
  var viewResults = true;

  void showResults(String inName) async {
    //Revisa el campo antes de mandar la solicitud.
    if (inName.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "ERROR: El Campo de Texto no puede estar vacio",
            style: TextStyle(fontWeight: FontWeight(700)),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          showCloseIcon: true,
        ),
      );
      resetPage();
      return;
    }

    if (RegExp(r'^\p{L}+$', unicode: true).hasMatch(inName.trim()) == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "ERROR: El Campo de Texto solo admite Letras",
            style: TextStyle(fontWeight: FontWeight(700)),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          showCloseIcon: true,
        ),
      );
      resetPage();
      return;
    }

    //Revisa la respuesta dada por el servidor.
    var res = await HttpService().getAgeByName(inName);

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
    } else if (res.runtimeType == AgePrediction) {
      prediction = res;

      if (prediction.age == 0) {
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
          prediction = res;
          viewResults = true;
        });
      }
    }
  }

  void resetPage() {
    setState(() {
      viewResults = false;
      inputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Predictor de Edad"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SingleFieldForm(
            label: "Introduzca el Nombre",
            inputController: inputController,
            b1Text: "Predecir",
            b2Text: "Limpiar",
            onBtn1Press: showResults,
            onBtn2Press: resetPage,
          ),

          viewResults
              ? Card(
                  margin: EdgeInsets.all(6),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: Column(
                      children: [
                        Text("El nombre:"),
                        Text(
                          prediction.name,
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight(700),
                          ),
                        ),
                        Text("Es de la Edad: "),
                        Text(
                          prediction.age.toString(),
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight(700),
                          ),
                        ),
                        Text("En ${prediction.count} Casos"),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
