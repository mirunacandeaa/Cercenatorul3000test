import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Theme/colors.dart';
import 'package:http/http.dart' as http;
import 'API.dart';

class AlegeTraseul extends StatefulWidget {
  final String projectId;
  AlegeTraseul({required this.projectId});

  @override
  _AlegeTraseulState createState() => _AlegeTraseulState();
}

class _AlegeTraseulState extends State<AlegeTraseul> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> dificultate = [
    'easy',
    'easy-medium',
    'medium',
    'medium-hard',
    'hard'
  ];
  String selectedDificultate = '';

  final List<String> durata = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
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
    QuerySnapshot judeteSnapshot = await _firestore
        .collection('Proiecte')
        .doc(widget.projectId)
        .collection('Judete')
        .get();

    List<String> judeteSelectate = [];
    for (QueryDocumentSnapshot judetDoc in judeteSnapshot.docs) {
      Map<String, dynamic>? data = judetDoc.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('judet')) {
        judeteSelectate.add(data['judet']);
      }
    }

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
              border: Border(
                  bottom: BorderSide(color: AppColors.pink, width: 2.0)),
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
                    foregroundColor: Colors.white,
                    backgroundColor: selectedDificultate == dif
                        ? AppColors.pink
                        : AppColors.pink.withOpacity(0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedDificultate = dif;
                      toateUnite =
                      [selectedDificultate, durataSelectata, selectedRegiune];
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
                  foregroundColor: Colors.white,
                  backgroundColor: durataSelectata == odurata
                      ? AppColors.pink
                      : AppColors.pink.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    durataSelectata = odurata;
                    toateUnite =
                    [selectedDificultate, durataSelectata, selectedRegiune];
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
                  foregroundColor: Colors.white,
                  backgroundColor: selectedRegiune == regiune
                      ? AppColors.pink
                      : AppColors.pink.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    selectedRegiune = regiune;
                    toateUnite =
                    [selectedDificultate, durataSelectata, selectedRegiune];
                  });
                },
                child: Text(
                  regiune,
                  style: TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 30),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.crimson,
                    ),
                    onPressed: () {
                      saveDataToServer(
                          durataSelectata, selectedDificultate, selectedRegiune);
                    },
                    child: Text('Save', style: TextStyle(fontSize: 18)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.crimson,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedDificultate = '';
                        durataSelectata = '';
                        selectedRegiune = '';
                        toateUnite =
                        [selectedDificultate, durataSelectata, selectedRegiune];
                      });
                    },
                    child: Text('Alege alt traseu', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.crimson,
                ),
                onPressed: () {
                  getRecommendations();
                },
                child: Text('Get Recommendations', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void saveDataToServer(String durata, String dificultate, String regiune) async {
    try {
      String url = 'http://127.0.0.1:5000/api?Durata=$durata&Dificultate=$dificultate&Regiune=$regiune';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> decodedData = jsonDecode(response.body);
        for (var item in decodedData) {
          String difficulty = item['Difficulty'];
          String hours = item['Hours'];
          String kilometers = item['Kilometers'];
          String place = item['Place'];
          String region = item['Region'];

          _salveazaTraseul(context, widget.projectId, hours, difficulty, kilometers, place, region);
        }
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _salveazaTraseul(BuildContext context, String projectId, String durata,
      String dificultate, String kilometers, String place, String region) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    _firestore.collection('Proiecte').doc(projectId).collection('Trasee').doc(place).set({
      'durata': durata,
      'dificultate': dificultate,
      'kilometers': kilometers,
      'place': place,
      'region': region,
    })
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Traseul a fost salvat cu succes!'),
        ),
      );
    })
        .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Eroare la salvarea traseului: $error'),
        ),
      );
    });
  }



  void getRecommendations() async {
    try {
      // Definim URL-ul pentru cererea POST către serverul Flask
      String url = 'http://127.0.0.1:5001/generate_recommendations';

      // Trimiterea cererii POST către serverul Flask
      var response = await http.post(Uri.parse(url));

      // Verificăm dacă cererea a fost executată cu succes
      if (response.statusCode == 200) {
        print('Recommendations received!');
      } else {
        print('Error fetching recommendations: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}
