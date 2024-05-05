
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'InfoGenerale.dart';
import 'NavBar.dart';
import 'Theme/colors.dart';
import 'Theme/textsize.dart';
import 'Widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: AppColors.skin,
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background2.png'), // Example image
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Cercenatorul3000',
                  style: TextStyle(
                    fontSize: TextSizes.title,
                    color: AppColors.oorange,
                    decoration: TextDecoration.none,
                    fontFamily: 'Inknut Antiqua',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Gata oricand!',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: TextSizes.subtitle,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 120),
                CustomButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => InfoGenerale() ),);
                  },
                  text: 'New Project',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}