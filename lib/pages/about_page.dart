import 'package:api_toolbox_t6/widgets/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        title: Text("Acerca de la App..."),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sobre la App",
                  style: GoogleFonts.arimo(
                    fontSize: 30,
                    fontWeight: FontWeight(700),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  "API Toolbox",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight(700)),
                ),
                Text(
                  "Esta es una aplicación creada para la Tarea 6 de la materia TDS-011.\n"
                  "Tiene 6 funciones que consumen APIs, todas accesibles con el menú principal de la aplicación.\n\n"
                  "Las funciones son:\n* Predecir el Genero basado en el Nombre\n* Predecir la edad basada en el Nombre\n* Mostrar las universidades según el país.\n* Mostrar datos de un Pokemón según su Nombre o ID.\n* Mostrar el clima actual en República Dominicana* Mostrar 3 Noticias/Posts en una página de WordPress",
                ),
                SizedBox(height: 50),
                Card(color: Colors.amber[400], child: PersonalInfo()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
