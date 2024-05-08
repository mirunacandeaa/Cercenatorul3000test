import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Theme/colors.dart';
import 'Widgets/custom_button.dart';

class AlegeRelieful extends StatefulWidget {
  final String projectId;
  AlegeRelieful({required this.projectId});

  @override
  _AlegeReliefulState createState() => _AlegeReliefulState();
}

class _AlegeReliefulState extends State<AlegeRelieful> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> images = [
    'assets/butonlac.png',
    'assets/munte.png',
    'assets/campie.png',
    'assets/rau.png',
    'assets/delta.png',
    'assets/oras.png',
    'assets/padure.png',
    'assets/mare.png',
    'assets/sat.png',
  ];

  final List<String> labels = [
    'lac',
    'munte',
    'campie',
    'rau',
    'delta',
    'oras',
    'padure',
    'mare',
    'sat',
  ];

  List<String> selectedLabels = [];
  List<String> availableLabels = [];

  @override
  void initState() {
    super.initState();
    _verificaSiSelecteazaRelieful();
  }

  Future<void> _verificaSiSelecteazaRelieful() async {
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

    // Colectăm tipurile de relief disponibile pentru judetele selectate
    Set<String> reliefuriDisponibile = {};
    for (String judet in judeteSelectate) {
      QuerySnapshot reliefSnapshot = await _firestore
          .collection('Judete')
          .doc(judet)
          .collection('Relief')
          .get();

      for (QueryDocumentSnapshot reliefDoc in reliefSnapshot.docs) {
        reliefuriDisponibile.add(reliefDoc.id);
      }
    }

    // Actualizăm lista de butoane disponibile
    setState(() {
      availableLabels = reliefuriDisponibile.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skin,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppColors.pink, width: 2.0)),
              ),
              child: Center(
                child: Text(
                  selectedLabels.join(', '),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            CustomScrollView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        final String label = labels[index];
                        final bool isAvailable = availableLabels.contains(
                            label);
                        final bool isSelected = selectedLabels.contains(label);
                        return AspectRatio(
                          aspectRatio: 1.0,
                          child: InkWell(
                            onTap: isAvailable ? () {
                              setState(() {
                                if (isSelected) {
                                  selectedLabels.remove(label);
                                } else {
                                  selectedLabels.add(label);
                                }
                              });
                            } : null,
                            borderRadius: BorderRadius.circular(25.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100.0,
                                  child: Ink.image(
                                    image: AssetImage(images[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  label,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: isAvailable ? Colors.black : Colors
                                        .grey.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: images.length,
                    ),
                  ),
                ),
              ],
            ),
            CustomButton(
              onPressed: () =>
                  _AlegeReliefulState._salveazaRelieful(
                      context, widget.projectId, selectedLabels),

              text: 'Save',
            ),
          ],
        ),
      ),
    );
  }


  static void _salveazaRelieful(BuildContext context, String projectId,
      List<String> selectedLabels) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    for (String relief in selectedLabels) {
      _firestore.collection('Proiecte').doc(projectId).collection('Relief').add(
          {
            'relief': relief,
          });
    }
  }
}
