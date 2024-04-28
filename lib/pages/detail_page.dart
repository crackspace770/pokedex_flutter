
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pokedex/core/provider/pokemon_detail_provider.dart';
import 'package:provider/provider.dart';

import '../color/stat_color.dart';
import '../color/type_color.dart';
import '../core/api/api_service.dart';
import '../core/api/endpoint.dart';
import '../core/provider/result_state.dart';

class DetailPage extends StatelessWidget{

  static const routeName ='/detail_page';
  final String pokemon;

  const DetailPage({
    super.key,
    required this.pokemon});


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<PokemonDetailProvider>(
      create: (_) =>
      PokemonDetailProvider(apiService: ApiService(Client()), name: pokemon),
      child: Scaffold(
        body: Consumer<PokemonDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              var pokemon = state.result.pokemonDetail;

              return Scaffold(

                body:  SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Container(
                          width: 400,
                          decoration: BoxDecoration(
                            color: typeColors[pokemon.types.first.type.name.toLowerCase()] ?? Colors.grey, // Use the color of the first type
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                          ),
                          child: Image.network(
                            "${pokemon.sprites.other?.officialArtwork.frontDefault}",
                            height: 300,
                            width: 300,
                          ),
                        ),


                        SizedBox(height: 10),

                        Text(pokemon.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        SizedBox(height: 20),
                        
                        Text("Types:"),
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: List.generate(
                                pokemon.types.length,
                                    (index) {
                                  // Get the color for the current type from the map
                                  Color typeColor = typeColors[pokemon.types[index].type.name.toLowerCase()] ?? Colors.grey;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add some spacing between items
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: typeColor, // Use the mapped color for the container background
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          pokemon.types[index].type.name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),

                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                          Column(

                            children: [
                            Text("Height"),
                            Text("${(pokemon.height/10).toString()} m",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                            )
                          ],
                          ),

                          SizedBox(width: 50),

                          Column(
                            children: [
                            Text("Weight:"),
                            Text("${(pokemon.weight/10).toString()} kg",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                            )
                          ],
                          ),

                        ],

                        ),

                        const SizedBox(height: 25),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: List.generate(
                                pokemon.stats.length,
                                    (index) {
                                  // Map each stat name to its corresponding color
                                      Color barColor = statColors[pokemon.stats[index].stat.name.toLowerCase()] ?? Colors.grey;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15), // Add some spacing between items
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(pokemon.stats[index].stat.name),
                                            SizedBox(width: 10),
                                            Text("${pokemon.stats[index].baseStat.toString()}/300"),
                                          ],
                                        ),
                                        ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                          child: LinearProgressIndicator(
                                            value: pokemon.stats[index].baseStat / 300, // Assuming the max stat value is 100
                                            backgroundColor: Colors.grey,
                                            minHeight: 10,
                                            valueColor: AlwaysStoppedAnimation<Color>(barColor), // Use the mapped color for the bar
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),

                        SizedBox(height: 20)

                      ],
                    ),
                  ),
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );

  }

}