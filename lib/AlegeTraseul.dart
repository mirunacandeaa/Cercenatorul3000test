import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Theme/colors.dart';

class AlegeTraseul extends StatefulWidget {
  final String projectId;
  AlegeTraseul({required this.projectId});

  @override
  _AlegeTraseulState createState() => _AlegeTraseulState();
}

class _AlegeTraseulState extends State<AlegeTraseul> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> dificultate = ['Easy', 'Easy-Medium', 'Medium', 'Medium-Hard', 'Hard'];
  String selectedDificultate = '';

  final List<String> durata = ['1H', '2H', '3H', '4H', '5H', '6H', '7H', '8H', '9H', '10+H'];
  String durataSelectata = '';

  List<String> regiuni = [];

  String selectedRegiune = '';
  List<String> toateUnite = [];

  @override
  void initState() {
    super.initState();
    _verificaSiSelecteazaRegiunile();
  }

  Future<void> _verificaSiSelecteazaRegiunile() async {
    // Obținem lista de judete din colecția proiectului curent
    QuerySnapshot judeteSnapshot = await _firestore
        .collection('Proiecte')
        .doc(widget.projectId)
        .collection('Judete')
        .get();

    // Colectăm lista de judete selectate
    List<String> judeteSelectate = [];
    for (QueryDocumentSnapshot judetDoc in judeteSnapshot.docs) {
      Map<String, dynamic>? data = judetDoc.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('judet')) {
        judeteSelectate.add(data['judet']);
      }
    }

    // Colectăm regiunile disponibile pentru judetele selectate
    Set<String> regiuniDisponibile = {};
    for (String judet in judeteSelectate) {
      QuerySnapshot regiuniSnapshot = await _firestore
          .collection('Judete')
          .doc(judet)
          .collection('Regiune')
          .get();

      for (QueryDocumentSnapshot regiuneDoc in regiuniSnapshot.docs) {
        regiuniDisponibile.add(regiuneDoc.id);
      }
    }

    // Actualizăm lista de regiuni disponibile
    setState(() {
      regiuni = regiuniDisponibile.toList();
    });
  }

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
                  _salveazaTraseul(context, widget.projectId, durataSelectata, selectedDificultate, selectedRegiune);

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


void _salveazaTraseul(BuildContext context, String projectId, String durata, String dificultate, String regiune) {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _firestore.collection('Proiecte').doc(projectId).collection('Trasee').add({
    'durata': durata,
    'dificultate': dificultate,
    'regiune': regiune,
  })
      .then((_) {
    // Afișăm un mesaj de succes
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Traseul a fost salvat cu succes!'),
      ),
    );
  })
      .catchError((error) {
    // Afișăm un mesaj de eroare în caz de eșec
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Eroare la salvarea traseului: $error'),
      ),
    );
  });
}
