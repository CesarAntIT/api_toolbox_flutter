import 'package:flutter/material.dart';
import 'package:api_toolbox_t6/services/http_service.dart';
import 'package:api_toolbox_t6/widgets/single_field_form.dart';

import '../models/pokemon.dart';
import '../widgets/pokemon_card.dart';

class Pokedex extends StatefulWidget {
  const Pokedex({super.key});

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  Pokemon? pokemon;
  final inputController = TextEditingController();
  bool viewResults = false;
  bool isLoading = false;

  void showResults(String inName) async {
    if (inName.trim().isEmpty) {
      _showError("El campo no puede estar vacío");
      return;
    }

    setState(() => isLoading = true);

    try {
      // Nota: Debes implementar getPokemon en tu HttpService
      var res = await HttpService().getPokemon(inName.trim().toLowerCase());

      setState(() {
        pokemon = res;
        viewResults = true;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      _showError("ERROR: Pokémon no encontrado");
      resetPage();
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void resetPage() {
    setState(() {
      viewResults = false;
      pokemon = null;
      inputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokédex API"),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleFieldForm(
              label: "Nombre o ID del Pokémon",
              inputController: inputController,
              b1Text: "Buscar",
              b2Text: "Limpiar",
              onBtn1Press: showResults,
              onBtn2Press: resetPage,
            ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(color: Colors.red),
              ),
            if (viewResults && pokemon != null)
              BuildPokemonCard(pokemon: pokemon!),
          ],
        ),
      ),
    );
  }
}
