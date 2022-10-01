import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/characters.dart';
import '../../data/models/quotes.dart';
import '../../data/repository/character_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  List<Character> Mycharacter = [];

  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  List<Character> getmyCharacter() {
    characterRepository.getAllCharacters().then((Character) {
      emit(CharactersLoaded(Character));
      Mycharacter = Character;
    });
    return Mycharacter;
  }

  void getmyQuote(String charName) {
    characterRepository.getAllQuote(charName).then((quotes) {
      emit(QuoteLoaded(quotes));
    });
  }
}
