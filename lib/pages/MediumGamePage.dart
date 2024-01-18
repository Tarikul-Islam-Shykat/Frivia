import 'package:flutter/material.dart';
import 'package:frivia/provider/medium_page_provider.dart';
import 'package:provider/provider.dart';

class MediumGamePage extends StatelessWidget {

  double? _deviceHeight, _deviceWidth;


   //MediumGamePage({required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
    create: (_context) => MediumPageProvider(context : context, difficultyLevel:  'medium'),
      child: _buildUI(),
    );
  }

  Widget _buildUI(){
    return Scaffold(

    );
  }
}
