class Character{
 late int charId;
  late String name;
  late String nickname;
  late String image;
  late List<dynamic>jobs;
  late String stateusifDeadorAlive;
  late List<dynamic>apperaranceOfseasons;
  late String actorName;
  late String categoryForTwoSeasons;
  late List<dynamic>betterCallSaulAppearance;

  Character.fromJson(Map<String,dynamic>json){
    charId=json["char_id"];
    name=json["name"];
    nickname=json[ "nickname"];
    image=json["img"];
    jobs=json["occupation"];
    stateusifDeadorAlive=json["status"];
    apperaranceOfseasons=json["appearance"];
    actorName=json["portrayed"];
    categoryForTwoSeasons=json["category"];
    betterCallSaulAppearance=json["better_call_saul_appearance"];
  }
}