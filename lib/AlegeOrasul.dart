import 'package:flutter/material.dart';
import 'Theme/colors.dart';

class AlegeOrasul extends StatefulWidget {
  @override
  _AlegeOrasulState createState() => _AlegeOrasulState();
}

class _AlegeOrasulState extends State<AlegeOrasul> {
  final List<String> orase = ['Sibiu', 'Medias', 'Cisnadie', 'Nocrich'];
  List<String> oraseSelectate = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 10), // Spațiu vertical în jurul textului
          child: Center(
            child: Text(
              oraseSelectate.join(', '), // Afișează orasele selectate separate prin virgulă
              style: TextStyle(fontSize: 18),
            ),
          ),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.pink, width: 2.0)), // Linia roșie sub text
          ),
        ),
        SizedBox(height: 30), // Spațiu între Container și Wrap
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: orase.map((oras) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: AppColors.pink,
              ),
              onPressed: () {
                setState(() {
                  if (oraseSelectate.contains(oras)) {
                    oraseSelectate.remove(oras); // Dacă orasul este deja selectat, îl eliminăm
                  } else {
                    oraseSelectate.add(oras); // Altfel, îl adăugăm
                  }
                });
              },
              child: Text(
                oras,
                style: TextStyle(fontSize: 18),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}