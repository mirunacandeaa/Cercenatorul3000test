import 'package:flutter/material.dart';
import 'Theme/colors.dart';

class AlegeTraseul extends StatefulWidget {
  @override
  _AlegeTraseulState createState() => _AlegeTraseulState();
}

class _AlegeTraseulState extends State<AlegeTraseul> {
  final List<String> dificultate = ['Easy', 'Easy-Medium', 'Medium', 'Medium-Hard', 'Hard'];
  String selectedDificultate = '';

  final List<String> durata = ['1H', '2H', '3H', '4H', '5H', '6H', '7H', '8H', '9H', '10+H'];
  String durataSelectata = '';

  final List<String> regiuni = ['Bucegi', 'Piatra Craiului', 'Fagaras', 'Retezat', 'Apuseni'];
  String selectedRegiune = '';

  List<String> toateUnite = [];

  @override
  Widget build(BuildContext context) {
    toateUnite = [selectedDificultate, durataSelectata, selectedRegiune];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.pink, width: 2.0)),
            ),
            child: Center(
              child: Text(
                toateUnite.join(', '),
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Dificultate:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: dificultate.map((dif) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: selectedDificultate == dif ? AppColors.pink : AppColors.pink.withOpacity(0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedDificultate = dif;
                      toateUnite = [selectedDificultate, durataSelectata, selectedRegiune];
                    });
                  },
                  child: Text(
                    dif,
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Durata:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: durata.map((odurata) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: durataSelectata == odurata ? AppColors.pink : AppColors.pink.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    durataSelectata = odurata;
                    toateUnite = [selectedDificultate, durataSelectata, selectedRegiune];
                  });
                },
                child: Text(
                  odurata,
                  style: TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text(
            'Regiune:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: regiuni.map((regiune) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: selectedRegiune == regiune ? AppColors.pink : AppColors.pink.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    selectedRegiune = regiune;
                    toateUnite = [selectedDificultate, durataSelectata, selectedRegiune];
                  });
                },
                child: Text(
                  regiune,
                  style: TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
          ),
          // Rând cu butoanele "Save" și "Alege alt traseu"
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: AppColors.crimson,
                ),
                onPressed: () {
                  // Aici puteți adăuga logica de salvare dacă este necesar
                },
                child: Text('Save', style: TextStyle(fontSize: 18)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: AppColors.crimson,
                ),
                onPressed: () {
                  setState(() {
                    selectedDificultate = '';
                    durataSelectata = '';
                    selectedRegiune = '';
                    toateUnite = [selectedDificultate, durataSelectata, selectedRegiune];
                  });
                },
                child: Text('Alege alt traseu', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
