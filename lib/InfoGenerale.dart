/// InfoGenerale.dart
import 'package:flutter/material.dart';
import 'Theme/colors.dart';
import 'Theme/textsize.dart';
import 'Widgets/bottom_navigation.dart';
import 'Widgets/custom_button.dart';
import 'locatii1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InfoGenerale extends StatefulWidget {
  final String projectId; // Adăugăm un nou membru de clasă pentru a stoca id-ul proiectului

  InfoGenerale({required this.projectId}); // Constructor pentru a primi id-ul proiectului

  @override
  _InfoGeneraleState createState() => _InfoGeneraleState();
}

class _InfoGeneraleState extends State<InfoGenerale> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> initialTexts = ['Nume proiect', 'Numar de persoane', 'Numar de zile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skin,
      appBar: AppBar(
        backgroundColor: AppColors.skin,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _navigateBack(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Informatii Generale',
                style: TextStyle(
                  color: AppColors.oorange,
                  fontSize: TextSizes.subtitle,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: initialTexts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                      labelText: initialTexts[index],
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        initialTexts[index] = newValue;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 150),
          child: CustomButton(
            onPressed: () {
              _saveProject(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => locatii1(projectId: widget.projectId),
                ),
              );
            },
            text: 'save',
          ),
        ),
      ),
        bottomNavigationBar: BottomNavBar()
    );

  }

  void _saveProject(BuildContext context) {
    // Collect information from the text fields
    String nume = initialTexts[0];
    String nrPersoane = initialTexts[1];
    String nrZile = initialTexts[2];

    // Update project information in Firestore
    _firestore.collection('Proiecte').doc(widget.projectId).update({
      'nume': nume,
      'nrPersoane': nrPersoane,
      'nrZile': nrZile,
    }).then((_) {
      // If the project was successfully updated
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Proiectul a fost actualizat cu succes!')),
      );
    }).catchError((error) {
      // If an error occurred while updating the project
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Eroare la actualizarea proiectului: $error')),
      );
    });
  }

  void _navigateBack(BuildContext context) {
    Navigator.pop(context); // Merge înapoi la HomePage
  }
}
