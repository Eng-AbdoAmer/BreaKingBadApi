import 'package:flutter/material.dart';
import '../../constants/my_colors.dart';

import '../../constants/strings.dart';
import '../../data/models/characters.dart';

class CharacterIteams extends StatelessWidget {
  final Character character;
  const CharacterIteams({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: MyColos.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: (() => Navigator.pushNamed(context, CharacterDetaliesScreens,arguments: character)),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
                color: Color.fromRGBO(52, 58, 64, 1),
                child: character.image.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: "assets/images/loading-animation-blue.gif",
                        image: character.image)
                    : const Center(
                        child: Text(
                        "Empty picture !",
                        style: TextStyle(color: MyColos.myWhite),
                      ))),
          ),
          footer: Container(
            width: double.infinity,
            padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              "${character.name}",
              style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColos.myWhite,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
