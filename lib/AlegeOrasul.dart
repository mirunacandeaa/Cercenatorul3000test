import 'package:cercenatorul3000/Theme/colors.dart';
import 'package:cercenatorul3000/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlegeOrasul extends StatefulWidget {
  final String projectId;

  AlegeOrasul({required this.projectId});

  @override
  _AlegeOrasulState createState() => _AlegeOrasulState();
}

class _AlegeOrasulState extends State<AlegeOrasul> {
  List<String> oraseSelectate = [];
  List<String> orase = [];

  @override
  void initState() {
    super.initState();
    _getOrase();
  }

  Future<void> _getOrase() async {
    QuerySnapshot oraseSnapshot = await FirebaseFirestore.instance
        .collection('Judete')
        .get();

    for (QueryDocumentSnapshot judetDoc in oraseSnapshot.docs) {
      QuerySnapshot oraseJudetSnapshot = await FirebaseFirestore.instance
          .collection('Judete')
          .doc(judetDoc.id)
          .collection('Orase')
          .get();

      for (QueryDocumentSnapshot orasDoc in oraseJudetSnapshot.docs) {
        setState(() {
          orase.add(orasDoc.id);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              oraseSelectate.join(', '),
              style: TextStyle(fontSize: 18),
            ),
          ),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.crimson, width: 2.0)),
          ),
        ),
        SizedBox(height: 30),
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
                    oraseSelectate.remove(oras);
                  } else {
                    oraseSelectate.add(oras);
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
        SizedBox(height: 50),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 150, // Setăm lățimea containerului la o valoare fixă
            child: CustomButton(
              onPressed: () => _salveazaOrasele(widget.projectId, oraseSelectate),
              text: 'save',
            ),
          ),
        ),
      ],
    );
  }

  void _salveazaOrasele(String projectId, List<String> selectedCities) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    selectedCities.forEach((oras) {
      _firestore.collection('Proiecte').doc(projectId).collection('Orase').add(
        {'oras': oras},
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Orașele au fost salvate cu succes!')),
    );

    // Poți adăuga aici orice altă acțiune după salvarea orașelor, cum ar fi navigarea la o altă pagină sau actualizarea stării widget-ului.
  }
}
