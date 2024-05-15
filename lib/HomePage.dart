// HomePage.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'InfoGenerale.dart';
import 'NavBar.dart';
import 'Theme/colors.dart';
import 'Theme/textsize.dart';
import 'Widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _addNewProject(BuildContext context) {
    _firestore.collection('Proiecte').get().then((QuerySnapshot snapshot) {
      int projectCount = snapshot.size; // Numărul de proiecte existente
      String projectName = 'P$projectCount'; // Numele proiectului nou

      _firestore.collection('Proiecte').doc(projectName).set({
        // Aici puteți adăuga orice alte atribute ale proiectului
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Proiectul a fost creat cu succes!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfoGenerale(projectId: projectName)),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Eroare la crearea proiectului: $error')),
        );
      });
    });
  }

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
            image: AssetImage('assets/background2.png'),
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
                    _addNewProject(context);
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
