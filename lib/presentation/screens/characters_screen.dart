import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../widgets/character_items.dart';
class CharacterScreen extends StatefulWidget {
  const CharacterScreen({ Key? key }) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
 
  late List<Character>AllCharacter;
  late List<Character>SearchedforCharacters;
  bool isSearching =false;
  final SearchTextController=TextEditingController();

  Widget buildSearchField(){
    return TextFormField(
      controller: SearchTextController,
      cursorColor: MyColos.myGrey,
      decoration: const InputDecoration(
        hintText: "Find a Characters.....",
        border: InputBorder.none,
        hintStyle: const TextStyle(color: MyColos.myGrey,fontSize: 18,)
      ),
      style:const TextStyle(color: MyColos.myGrey,fontSize: 18,) ,
      onChanged: (searchCharacter){
        AddSearchedIteamForListIteams(searchCharacter);
      },
    );
  }
  void AddSearchedIteamForListIteams(String searchCharacter){
    SearchedforCharacters = AllCharacter.where(
      (Character) => Character.name.toLowerCase().startsWith(searchCharacter)).toList();
      setState(() {
        
      });
  }
  List<Widget>_bulidAppbarAction(){
    if(isSearching){
      return [
        IconButton(onPressed: (){
          _ClearSearch();
          Navigator.pop(context);
        }, icon:const Icon(Icons.clear,color: MyColos.myGrey,))
      ];
    }else{
        return  [
           IconButton(onPressed: _startSearch, icon: const Icon(Icons.search,color: MyColos.myGrey,))
        ];
    }
  }
  void _startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      isSearching=true;
    });
  }
  void _stopSearch(){
    _ClearSearch();
    setState(() {
      isSearching=false;
    });
  }
  void _ClearSearch(){
    setState(() {
      SearchTextController.clear();
    });
  }

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getmyCharacter();
    super.initState();
  }

  Widget buildBlocWidget(){
    return BlocBuilder<CharactersCubit,CharactersState>(builder: (context,State){
      if(State is CharactersLoaded){
        AllCharacter =(State).characters;
        return buildLoadedListWidget();
      }else{
        return ShowloadingIndicator();
      }
    });
  }
  Widget ShowloadingIndicator(){
    return const Center(child: const CircularProgressIndicator(color: MyColos.myYellow),);
  }
  Widget buildLoadedListWidget(){
    return SingleChildScrollView(child: Container(
      child: Column(children: [
        bulidCharacterList(),
      ]),
      color: MyColos.myGrey),
    
    );
  }

  Widget bulidCharacterList(){
    return GridView.builder(
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 2/3,
      crossAxisSpacing: 1,
      mainAxisSpacing: 1,
      ),
      itemCount:SearchTextController.text.isEmpty? AllCharacter.length:SearchedforCharacters.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(0.8),
      physics:const ClampingScrollPhysics(),
     itemBuilder: (context,index){
      return  CharacterIteams(
        character:SearchTextController.text.isEmpty? AllCharacter[index]:SearchedforCharacters[index],);
     });
  }

  Widget _bulidAppBarTitle(){
    return const Text('Character',style: const TextStyle( color: MyColos.myGrey),);
  }

Widget buildNoInternetConnected(){
  return Center(
    child: Container(
      padding: const EdgeInsets.all(8),
      color: MyColos.myGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          Image.asset("assets/images/undraw_Outer_space_re_u9vd.png"),
          const SizedBox(height: 20,),
          DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: MyColos.myWhite, shadows: [
            Shadow(blurRadius: 7, color: MyColos.myYellow, offset: Offset(0, 3))
          ]),
          child: AnimatedTextKit(
            animatedTexts: [
              FlickerAnimatedText("Can't Connect...plaese Check The Internet"),
            ],
            repeatForever: true,
          ),
        ),
        ],)
        ),
        );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColos.myYellow,
        title: isSearching?buildSearchField():_bulidAppBarTitle(),
        actions: _bulidAppbarAction(),
        leading: isSearching?const BackButton(color: MyColos.myGrey,):Container(),
        ),
      body: 
      OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ){
          final bool connected = connectivity != ConnectivityResult.none;
          if(connected){return buildBlocWidget();}else{
            return buildNoInternetConnected();
          }

        },
        child: ShowloadingIndicator(),
        ),
      
    
    );
      
    
  }
}

