import 'package:flutter/cupertino.dart';
import '../models/characters.dart';
import '../models/quotes.dart';
import '../web_services/character_web_servics.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await characterWebServices.getAllCharactersAtweb();
    return characters.map((e) => Character.fromJson(e)).toList();
  }

  Future<List<Quote>> getAllQuote(String charName) async {
    final quotes =
        await characterWebServices.getCharactersQuotesAtweb(charName);
    return quotes.map((e) => Quote.fromJson(e)).toList();
  }
}
