import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters.dart';
import '../../data/models/quotes.dart';

class CharacterDetaliesScreen extends StatelessWidget {
  final Character character;
  const CharacterDetaliesScreen({Key? key, required this.character})
      : super(key: key);

  Widget bulidSliverAppbar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColos.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          character.nickname,
          style: TextStyle(color: MyColos.myWhite),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: TextStyle(
                  color: MyColos.myWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          TextSpan(
              text: value,
              style: TextStyle(color: MyColos.myWhite, fontSize: 16)),
        ]));
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      thickness: 2,
      endIndent: endIndent,
      color: MyColos.myYellow,
      height: 30,
    );
  }

  Widget checkIfQuoteAreloaded(CharactersState state) {
    if (state is QuoteLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return ShowprogressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    List<Quote> Getquote = (state).quote;
    if (Getquote.isNotEmpty) {
      int randomQuoteIndex = Random().nextInt(Getquote.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: MyColos.myWhite, shadows: [
            Shadow(blurRadius: 7, color: MyColos.myYellow, offset: Offset(0, 0))
          ]),
          child: AnimatedTextKit(
            animatedTexts: [
              FlickerAnimatedText(Getquote[randomQuoteIndex].quote),
            ],
            repeatForever: true,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget ShowprogressIndicator() {
    return Center(
      child: CircularProgressIndicator(color: MyColos.myYellow),
    );
  }

  @override
  Widget build(BuildContext context) {
        BlocProvider.of<CharactersCubit>(context).getmyQuote(character.name);
    return Scaffold(
      backgroundColor: MyColos.myGrey,
      body: CustomScrollView(
        slivers: [
          bulidSliverAppbar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    characterInfo('Job : ', character.jobs.join(' / ')),
                    buildDivider(280.0),
                    characterInfo(
                        'Apperard in : ', character.categoryForTwoSeasons),
                    buildDivider(250),
                    characterInfo('Seasones : ',
                        character.apperaranceOfseasons.join(' / ')),
                    buildDivider(220),
                    characterInfo('status : ', character.stateusifDeadorAlive),
                    buildDivider(260),
                    character.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : characterInfo('Better call Saul Seasons',
                            character.betterCallSaulAppearance.join(' / ')),
                    character.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : buildDivider(150),
                    characterInfo('Actor/Actress : ', character.actorName),
                    buildDivider(200),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CharactersCubit, CharactersState>(
                      builder: (context, state) {
                        return checkIfQuoteAreloaded(state);
                      },
                    )
                  ]),
            ),
            SizedBox(
              height: 500,
            ),
          ])),
        ],
      ),
    );
  }
}
