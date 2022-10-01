import 'package:dio/dio.dart';
import '../../constants/strings.dart';
import '../models/characters.dart';

class CharacterWebServices {
  late Dio dio;

  CharacterWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseurl,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000, //30 seconds
      receiveTimeout: 60 * 1000, //60 seconds
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharactersAtweb() async {
    try {
      Response response = await dio.get("characters");
      print(response.data.toString());
      return response.data;
    } catch (e) {
      e.toString();
      return [];
    }
  }

  Future<List<dynamic>> getCharactersQuotesAtweb(String charName) async {
    try {
      Response response =
          await dio.get("quote", queryParameters: {'author': charName});
      print(response.data.toString());
      return response.data;
    } catch (e) {
      e.toString();
      return [];
    }
  }
}
