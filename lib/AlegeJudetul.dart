import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cercenatorul3000/Theme/colors.dart';
import 'package:cercenatorul3000/Widgets/custom_button.dart';
import 'package:cercenatorul3000/romaniamap.dart';

class AlegeJudetul extends StatefulWidget {
  final String projectId;
  AlegeJudetul({required this.projectId});

  @override
  _AlegeJudetulState createState() => _AlegeJudetulState();
}

class _AlegeJudetulState extends State<AlegeJudetul> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> oraseSelectate = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.skin,
        child: Column(
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
            SizedBox(height: 20,), // Adaugă o virgulă aici
            CustomButton(
              onPressed: () => _AlegeJudetulState._salveazaJudetele(context, widget.projectId, oraseSelectate), // Corectează apelul funcției onPressed
              text: "Save",
            ),
          ],
        ),
      ),
    );
  }

  static void _salveazaJudetele(BuildContext context, String projectId, List<String> oraseSelectate) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    for (String oras in oraseSelectate) {
      _firestore.collection('Proiecte').doc(projectId).collection('Judete').add({
        'judet': oras,
      });
    }
  }
}
