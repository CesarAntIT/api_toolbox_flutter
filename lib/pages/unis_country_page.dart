import 'package:api_toolbox_t6/models/university.dart';
import 'package:api_toolbox_t6/services/http_service.dart';
import 'package:api_toolbox_t6/widgets/single_field_form.dart';
import 'package:api_toolbox_t6/widgets/uni_result_list.dart';
import 'package:flutter/material.dart';

class CountryUnis extends StatefulWidget {
  const CountryUnis({super.key});

  @override
  State<CountryUnis> createState() => _CountryUnisState();
}

class _CountryUnisState extends State<CountryUnis> {
  late String inCountry = "RD";
  late List<University> uniList = [];
  final inputController = TextEditingController();
  var viewResults = false;

  void showResults(String input) async {
    var res = await HttpService().getUniByCountry(input);

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
      setState(() {
        uniList = [];
        viewResults = true;
        inCountry = input;
      });
      return;
    }

    setState(() {
      uniList = res;
      inCountry = input;
      viewResults = true;
    });
  }

  void resetForm() {
    setState(() {
      uniList = [];
      inCountry = "";
      viewResults = false;
      inputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Universidades por País"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SingleFieldForm(
            label: "Nombre de país (en Inglés)",
            inputController: inputController,
            b1Text: "Buscar",
            b2Text: "Reset",
            onBtn1Press: showResults,
            onBtn2Press: resetForm,
          ),
          SizedBox(height: 20),
          if (viewResults) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Universidades en: \n$inCountry",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            UniResultList(uniList: uniList),
          ] else
            Expanded(child: Center(child: Text("Ingresa un país para buscar"))),
        ],
      ),
    );
  }
}
