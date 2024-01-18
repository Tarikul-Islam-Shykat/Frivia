import 'package:flutter/material.dart';
import 'package:frivia/provider/game_page_provide.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {

  double? _deviceHeight, _deviceWidth;
  GamePageProvider? _pageProvider;
  final String difficultyLevel;

   GamePage({required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
        create: (_context) => GamePageProvider(context: context, difficultyLevel:  difficultyLevel),
      child: _buildUi(), /*what ever widget we want our change notifier to wrap.*/
    );

  }



  Widget _buildUi(){
   return Builder(
     builder: (_context) {
       _pageProvider = _context.watch<GamePageProvider>(); // context is important because it lets us know where the provider exist.

       if(_pageProvider!.questions != null){
         return Scaffold(
           body: SafeArea(
             child:  Container(
               padding: EdgeInsets.symmetric(horizontal:  _deviceWidth! * 0.05),
               child: _gameUi() ,
             ),
           ),
         );
       }

       else{
         return const Center(child: CircularProgressIndicator(color:  Colors.white,),);
       }

     }
   );
  }

  Widget _gameUi()  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(height: _deviceHeight! * 0.01,),
            _falseButton(),
          ],
        )
      ],
    );
  }

  Widget _questionText(){
    return  Text(
        _pageProvider!.getCurrentQuestionText(), // from game_page_provider
      style: const TextStyle(
        color:  Colors.white, fontSize: 25, fontWeight: FontWeight.w400
      ),
    );
  }

  Widget _trueButton(){
    return MaterialButton(
      onPressed: (){
        _pageProvider?.answerQuestion("True");
      },

      color:  Colors.green,
      minWidth:  _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
          "True",
        style: TextStyle(color:  Colors.white, fontSize: 25),
      ),

    );
  }

  Widget _falseButton(){
    return MaterialButton(
      onPressed: (){
        _pageProvider?.answerQuestion("False");
      },

      color:  Colors.red,
      minWidth:  _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "False",
        style: TextStyle(color:  Colors.white, fontSize: 25),
      ),
    );
  }
}
