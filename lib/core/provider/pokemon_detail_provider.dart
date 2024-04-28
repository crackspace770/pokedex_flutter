import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:pokedex/core/provider/result_state.dart';

import '../api/api_service.dart';
import '../response/pokemon_detail_response.dart';

class PokemonDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String name;

  PokemonDetailProvider({required this.apiService, required this.name}) {
    fetchDetailPokemon(name);
    }

  late PokemonDetailResponse _detailPokemon;
  String _message = '';
  late ResultState _state;

  String get message => _message;
  PokemonDetailResponse get result => _detailPokemon;
  ResultState get state => _state;

  Future<void> fetchDetailPokemon(String name) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final pokemon = await apiService.getDetailPokemon(name);
      _state = ResultState.hasData;
      _detailPokemon = pokemon;
        } on SocketException {
      _state = ResultState.error;
      _message = 'Connection Error';
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error -> $e';
    } finally {
      notifyListeners();
    }
  }
}