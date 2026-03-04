import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../models/pokemon.dart';

class BuildPokemonCard extends StatefulWidget {
  const BuildPokemonCard({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  State<BuildPokemonCard> createState() => _BuildPokemonCardState();
}

class _BuildPokemonCardState extends State<BuildPokemonCard> {
  final cryPlayer = AudioPlayer();

  @override
  void dispose() {
    cryPlayer.dispose();
    super.dispose();
  }

  void playCry(String url) async {
    try {
      await cryPlayer.play(UrlSource(url));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ERROR: No se pudo reproducir el audio")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              widget.pokemon.name.toUpperCase(),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Image.network(
              widget.pokemon.imageUrl,
              height: 200,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, size: 50),
            ),
            const Divider(height: 30),

            ListTile(
              leading: const Icon(Icons.star, color: Colors.amber),
              title: const Text("Experiencia Base"),
              trailing: Text(
                widget.pokemon.baseExperience.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Text(
              "Habilidades:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: widget.pokemon.abilities
                  .map(
                    (a) => Chip(
                      label: Text(a),
                      backgroundColor: Colors.red.shade50,
                    ),
                  )
                  .toList(),
            ),
            const Divider(),

            const Text("Grito Actual:"),
            IconButton(
              icon: const Icon(
                Icons.volume_up,
                size: 40,
                color: Colors.redAccent,
              ),
              onPressed: () {
                playCry(widget.pokemon.cryUrl);
                debugPrint("Reproduciendo: ${widget.pokemon.cryUrl}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
