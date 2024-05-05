import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Theme/colors.dart';

class GenereazaCampul extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Genereaza Campul"),
        backgroundColor: AppColors.skin,
      ),
      body: Container(
        color: AppColors.skin,
        child: Center(
          child: Text(
            "vlabla",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}