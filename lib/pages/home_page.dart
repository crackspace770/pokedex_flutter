
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/core/provider/pokemon_provider.dart';
import '../core/provider/result_state.dart';
import '../widget/poke_card.dart';

class HomePage extends StatefulWidget{

  static const routeName = '/home_page';

  const HomePage({super.key,});

  @override
  State<HomePage>createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pokedex",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<PokemonProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of items per row
              crossAxisSpacing: 4, // Spacing between items horizontally
              mainAxisSpacing: 4, // Spacing between items vertically
            ),
            itemCount: state.result.results.length,
            itemBuilder: (context, index) {
              var pokemon = state.result.results[index];
              return PokeCard(pokemon: pokemon);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

}



