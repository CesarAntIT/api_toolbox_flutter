import 'package:api_toolbox_t6/models/gender_prediction.dart';
import 'package:api_toolbox_t6/services/http_service.dart';
import 'package:api_toolbox_t6/widgets/single_field_form.dart';
import 'package:flutter/material.dart';

class PredictGender extends StatefulWidget {
  const PredictGender({super.key});

  @override
  State<PredictGender> createState() => _PredictGenderState();
}

class _PredictGenderState extends State<PredictGender> {
  late GenderPrediction prediction;
  final inputController = TextEditingController();
  var viewResults = false;

  void showResults(String inName) async {
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

    var res = await HttpService().getGenderByAge(inName);
    if (res.runtimeType == GenderPrediction) {
      setState(() {
        prediction = res;
        viewResults = true;
      });
    }
  }

  void resetPage() {
    setState(() {
      viewResults = false;
      inputController.clear();
    });
  }

  @override
  void dispose() {
    resetPage();
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Predictor de Genero"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SingleFieldForm(
            label: "Insertar el Nombre",
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
                    padding: EdgeInsetsGeometry.all(20.0),
                    child: Column(
                      children: [
                        Text("El Nombre"),
                        Text(
                          prediction.name!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight(700),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text("Es del genero"),
                        Text(
                          prediction.gender!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight(700),
                            color: prediction.gender == "male"
                                ? Colors.lightBlue
                                : Colors.pink,
                          ),
                        ),
                        Text(
                          "Con una probabilidad del ${prediction.probability! * 100} %",
                        ),
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
