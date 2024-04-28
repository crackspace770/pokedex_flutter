import 'dart:convert';
import 'package:http/http.dart';
import '../response/pokemon_detail_response.dart';
import '../response/pokemon_response.dart';

class ApiService{
  final Client client;
  ApiService(this.client);


  Future <PokemonResponse> getPokemonList() async {
    try{
      final response = await client.get(Uri.parse("https://pokeapi.co/api/v2/pokemon"));

      if (response.statusCode == 200) {
        return PokemonResponse.fromJson(json.decode(response.body));

      }else{
        throw Exception('Failed to load pokemon: ${response.body}' );

      }
    }catch(e) {
      print('Error fetching news list: $e');
      throw Exception('Failed to load pokemon list: $e');
    }
  }

  Future<PokemonDetailResponse> getDetailPokemon(String name) async {
    try {
      final response = await client.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$name"));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse); // Add this line to print the JSON response
        return PokemonDetailResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load top headlines');
      }
    } on Error catch (e) {
      print('Error: $e');
      throw Exception('Something went wrong ');
    }
  }


}