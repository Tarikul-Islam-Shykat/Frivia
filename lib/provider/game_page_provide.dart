import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider extends ChangeNotifier{

  final Dio _dio = Dio();
  final int _maxQuestions = 10;
  List? questions ;
  int _currentQuestionCount = 0;
  int correctAns = 0;
  final String difficultyLevel;

  BuildContext context;
  GamePageProvider({required this.context, required this.difficultyLevel}){
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getSQuestionFromApi();
  }


  Future<void> _getSQuestionFromApi() async {
      var _response = await _dio.get(
        '',
        queryParameters: {
          'amount' : _maxQuestions,
          'type' : 'boolean',
          'difficulty': difficultyLevel
        }
      );
      var _data = jsonDecode(
          _response.toString()
      );


    questions = _data["results"];
    notifyListeners(); // this is important, because it lets the other cass know that changes have occurred


    //print(_data.toString());  prints the response data
    //print(questions); // questions response
    //print(questions?[_currentQuestionCount]["question"]); //  acccess each question
  }

  String getCurrentQuestionText(){
    return questions![_currentQuestionCount]["question"];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == _answer;
    _currentQuestionCount++;

    if(isCorrect){
      correctAns++;
    }

    showDialog(context: context, builder: (BuildContext _context){
      return AlertDialog(
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        title: Icon(
          isCorrect ? Icons.check_circle : Icons.cancel_sharp,
          color:  Colors.white,
        ),
      );
    });
    // for auto removing the alert dialog.
    await Future.delayed(const Duration(seconds:  1));
    Navigator.pop(context);

    if(_currentQuestionCount == _maxQuestions){
      endGame();
    }
    else{
      notifyListeners();
    }
    
    //print(isCorrect ? "Correct" : "Failed");
  }

  Future<void> endGame() async{
    showDialog(context: context,
        builder: (BuildContext _context){
      return  AlertDialog(
        backgroundColor: Colors.blue,
        title: Text(
          "End Game",
          style: TextStyle(fontSize: 25, color:  Colors.white),
        ),
        content: Text("Socre: $correctAns / $_maxQuestions"),
      );
        });

    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);

    //_currentQuestionCount = 0;
  }






}