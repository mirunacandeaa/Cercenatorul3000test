import 'package:cercenatorul3000/romaniamap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Theme/colors.dart';

class AlegeJudetul extends StatefulWidget {
  @override
  _AlegeJudetulState createState() => _AlegeJudetulState();
}

class _AlegeJudetulState extends State<AlegeJudetul> {
  List<String> oraseSelectate = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: AppColors.skin,
            child: Center(
              child: Text(
                oraseSelectate.join(', '), // Afișează județele selectate separate prin virgulă
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Container(
            height: 2,
            color: AppColors.pink,
          ),
          Expanded(
            child: Container(
              color: AppColors.skin,
              child: SimpleMapExample(
                onSelectionChanged: (selectedJudete) {
                  setState(() {
                    oraseSelectate = selectedJudete;
                  });
                },
              ),
            ),
          ),


        ],
      ),
    );
  }
}
