import 'dart:convert';
import '../model/pokemon.dart';

PokemonResponse pokemonResponseFromJson(String str) => PokemonResponse.fromJson(json.decode(str));

String pokemonResponseToJson(PokemonResponse data) => json.encode(data.toJson());

class PokemonResponse {
  int count;
  String next;
  dynamic previous;
  List<Pokemon> results;

  PokemonResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokemonResponse.fromJson(Map<String, dynamic> json) => PokemonResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Pokemon>.from(json["results"].map((x) => Pokemon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "pokemon": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

