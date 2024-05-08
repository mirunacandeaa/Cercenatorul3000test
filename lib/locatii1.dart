import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AlegeJudetul.dart';
import 'AlegeOrasul.dart';
import 'AlegeRelieful.dart';
import 'AlegeTraseul.dart';
import 'GenereazaCampul.dart';
import 'Theme/colors.dart';
import 'Widgets/bottom_navigation.dart';
import 'Widgets/bottomn_navigation_pink.dart';
import 'Widgets/custom_button.dart';

class locatii1 extends StatefulWidget {
  final String projectId; // Adăugăm un membru pentru a stoca projectId

  locatii1({required this.projectId}); // Constructor pentru a primi projectId

  @override
  _locatii1State createState() => _locatii1State();
}

class _locatii1State extends State<locatii1> {
  String _text = 'Alege judetul';

  void _changeTextAndColor(bool forward) {
    setState(() {
      switch (_text) {
        case 'Alege judetul':
          _text = forward ? 'Alege relief' : 'Alege orasul';
          break;
        case 'Alege relief':
          _text = forward ? 'Alege traseul' : 'Alege judetul';
          break;
        case 'Alege traseul':
          _text = forward ? 'Alege orasul' : 'Alege relief';
          break;
        case 'Alege orasul':
          _text = forward ? 'Alege judetul' : 'Alege traseul';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skin,
      appBar: AppBar(
        backgroundColor: AppColors.skin,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              // Navighează către pagina "GenereazaCampul" și trimite projectId
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GenereazaCampul(projectId: widget.projectId),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 10,
            right: 10,
            bottom: 100,
            child: _text == 'Alege judetul'
                ? AlegeJudetul(projectId: widget.projectId)
                : _text == 'Alege orasul'
                ? AlegeOrasul()
                : _text == 'Alege relief'
                ? AlegeRelieful(projectId: widget.projectId)
                : AlegeTraseul(projectId: widget.projectId),
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _changeTextAndColor(false);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    _text,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    _changeTextAndColor(true);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBarPink(),
    );
  }
}
