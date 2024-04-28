import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:pokedex/core/api/api_service.dart';
import 'package:pokedex/core/model/pokemon.dart';
import 'package:pokedex/core/provider/result_state.dart';
import 'package:pokedex/core/response/pokemon_response.dart';

class PokemonProvider extends ChangeNotifier{

  final ApiService apiService;

  PokemonProvider({required this.apiService}) {
    _fetchPokemon();
  }

  bool isLoading = false;

  late PokemonResponse _pokemonResponse;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  PokemonResponse get result => _pokemonResponse;
  ResultState get state => _state;

  final List<Pokemon> _listPokemon = [];
  List<Pokemon> get listPokemon => _listPokemon;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  Future<void> _fetchPokemon() async {
    try{
      _state = ResultState.loading;
      notifyListeners();
      final news = await apiService.getPokemonList();
      if (news.results.isEmpty) {
        _state = ResultState.noData;
        _message = 'Data Empty';
      }else{
        _state = ResultState.hasData;
        _pokemonResponse = news;
      }
    } on SocketException {
      _state = ResultState.error;
      _message = 'Connection Error';
    } catch(e) {
      _state = ResultState.error;
      _message = 'Failed to load data: $e';
    } finally{
      notifyListeners();
    }

  }



}