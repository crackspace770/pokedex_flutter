
import 'dart:convert';

import 'package:pokedex/core/model/pokemon_detail.dart';

class PokemonDetailResponse {
  PokemonDetail pokemonDetail;

  PokemonDetailResponse({required this.pokemonDetail});

  factory PokemonDetailResponse.fromJson(Map<String, dynamic> json) {
    return PokemonDetailResponse(
      pokemonDetail: PokemonDetail.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() => {
    "pokemonDetail": pokemonDetail.toJson(),
  };
}

