import 'package:flutter/material.dart';
import 'package:pokedex/core/model/pokemon.dart';

import '../pages/detail_page.dart';

class PokeCard extends StatelessWidget{
  final Pokemon pokemon;

  const PokeCard({super.key,
    required this.pokemon,

  });

  @override
  Widget build( BuildContext context) {

    final RegExp regex = RegExp(r'/(\d+)/$');
    final Match? match = regex.firstMatch(pokemon.url);
    final String? id = match?.group(1);

    // Constructing image URL
    final String imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

      return Padding(
        padding: const EdgeInsets.only(top: 25, right: 8, left: 8, bottom: 8),
        child: GestureDetector(
          onTap: () {
              Navigator.pushNamed(context, DetailPage.routeName,
                  arguments: pokemon.name.toString());
          },
          child: SizedBox(
            width: 200, // Set width and height to desired size
            height: 300,
            child: Container(
              padding: const EdgeInsets.only(top: 16, right: 8, left: 8, bottom:8 ),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black26, width: 3),
              ),
              child: Column(
                children: [
                  Image.network(imageUrl, width: 100, height: 100),
                  const SizedBox(height: 10,),
                  Text(pokemon.name),
                ],
              ),

            ),

          ),
        ),
      );
  }

}