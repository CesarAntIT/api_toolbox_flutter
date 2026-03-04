import 'package:api_toolbox_t6/models/university.dart';
import 'package:flutter/material.dart';

class UniResultList extends StatelessWidget {
  const UniResultList({super.key, required this.uniList});

  final List<University> uniList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: uniList.isEmpty
          ? Center(
              child: Text(
                "No se encontraron\n resultados",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight(700),
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: uniList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,

                  child: ListTile(
                    leading: Icon(Icons.school, color: Colors.lightBlue),
                    title: Text(uniList[index].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          uniList[index].domains.isNotEmpty
                              ? uniList[index].domains.first
                              : "Sin dominio",
                        ),
                        Text(
                          uniList[index].webPages.first,
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight(700),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
