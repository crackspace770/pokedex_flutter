import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart';
import 'package:pokedex/pages/detail_page.dart';
import 'package:pokedex/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'core/api/api_service.dart';
import 'core/provider/pokemon_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PokemonProvider>(
          create: (_) => PokemonProvider(apiService: ApiService(Client())),
        ),
      ],
      child: GetMaterialApp(
        title: 'Pokedex',
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => DetailPage(
            pokemon:
            ModalRoute.of(context)?.settings.arguments as String,
          ),
        },
      ),
    );
  }
}



