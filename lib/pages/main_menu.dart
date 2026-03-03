import 'package:api_toolbox_t6/pages/gender_predict_page.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image(
            image: AssetImage("assets/images/tool_box.png"),
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),

          Expanded(
            child: GridView.count(
              childAspectRatio: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              padding: EdgeInsets.all(20),

              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepOrange,
                  ),
                  label: Text("Edad según tu nombre"),
                  icon: Icon(Icons.date_range),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PredictGender()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purple,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.male),
                      Icon(Icons.female),
                      Flexible(child: Text("Genero según tu nombre")),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  label: Text("Universidades por País"),
                  icon: Icon(Icons.school),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.amber,
                  ),
                  label: Text("El Clima de Rep.Dom"),
                  icon: Icon(Icons.thunderstorm),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  label: Text("La Pokedex!!"),
                  icon: Icon(Icons.book_sharp),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  label: Text("Noticia de WordPress"),
                  icon: Icon(Icons.newspaper),
                ),
              ],
            ),
          ),

          Container(
            width: 200,
            margin: EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.grey[800],
              ),
              onPressed: () {},
              child: Row(children: [Icon(Icons.info), Text("Acerca De")]),
            ),
          ),
        ],
      ),
    );
  }
}
