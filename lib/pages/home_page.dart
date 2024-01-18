import 'package:flutter/material.dart';
import 'package:frivia/pages/GamePage.dart';
import 'package:frivia/pages/MediumGamePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double? _deviceHeight, _deviceWidth;
  double _currentDifficultyLevel = 0;
  final List<String> _difficltText = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          //padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                _appTitle(),
                _difficultSlider(),
                _startGameButton(),
                _mediumButton()
              ],

            ),
          ),
        ),
      ),
    );
  }

  Widget _appTitle(){
    return Column(
      children: [
         const Text(
          "Frivia",
          style: TextStyle(
            color:  Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500
          ),
        ),

        Text(
         _difficltText[_currentDifficultyLevel.toInt()],
          style: TextStyle(
              color:  Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),
        ),



      ],
    );
  }

  Widget _difficultSlider(){
    return Slider(
        min: 0,
        max: 2,
        divisions: 2,
        label: "Dfficulty",
        activeColor: Colors.blue,
        value: _currentDifficultyLevel,
        onChanged: (_value){
          setState(() {
            _currentDifficultyLevel = _value;
          });
        }
    );
  }

  Widget _startGameButton(){
    return MaterialButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext _context){
          return GamePage(difficultyLevel: _difficltText[_currentDifficultyLevel.toInt()].toLowerCase() ,);
        }),);
      },
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.40,
      height: _deviceHeight! * 0.10,

      child: const Text(
        "Start",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  Widget _mediumButton(){
    return MaterialButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext _context){
            return MediumGamePage();
          }));
        },

      color:  Colors.amber,
      height: _deviceHeight! * 0.05,
      child: Text(
        "Medium",
      ),

    );
  }








}
