import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubit/characters_cubit.dart';
import 'data/models/characters.dart';
import 'data/web_services/character_web_servics.dart';
import 'presentation/screens/characters_screen.dart';
import 'constants/strings.dart';
import 'data/repository/character_repository.dart';
import 'presentation/screens/characters_detalies_Screen.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CharacterScreens:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CharactersCubit(characterRepository),
                  child: CharacterScreen(),
                ));

      case CharacterDetaliesScreens:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    CharactersCubit(characterRepository),
                child: CharacterDetaliesScreen(
                  character: character,
                )));
    }
  }
}
