import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MediumPageProvider extends ChangeNotifier{

  final Dio _dio  = Dio();
  final int _maxQuestion = 5;

  final String difficultyLevel;
  BuildContext context;

  MediumPageProvider({required this.context, required this.difficultyLevel}){
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getMediupQuestion();
  }

  Future<void> _getMediupQuestion() async{
    var response = await _dio.get(
      '',
      queryParameters: {
        'amount' : _maxQuestion,
        'type' : 'boolean',
        'difficulty' : difficultyLevel
      }
    );

    var _data = jsonDecode(response.toString());

    print(_data.toString());
    notifyListeners();
  }

}