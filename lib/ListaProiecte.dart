import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'GenereazaCampul.dart';
import 'Theme/colors.dart'; // Asigură-te că importi corect fișierul în care ai definit culorile

class ListaProiecte extends StatelessWidget {
  final List<Color> colors = [
    AppColors.pink,
    AppColors.darkorange,
    AppColors.magenta,
    AppColors.visiniu,
    AppColors.peach,
    AppColors.oorange
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista Proiecte"),
        backgroundColor: AppColors.skin, // Setăm culoarea AppBar-ului la AppColors.skin
      ),
      body: Stack(
        children: [
          Container(
            color: AppColors.skin, // Fundalul din spatele listei de elemente
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Proiecte').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No projects found'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var proiect = snapshot.data!.docs[index];
                    var color = colors[index % colors.length];
                    if (index > 0 && color == colors[(index - 1) % colors.length]) {
                      color = colors[(index + 1) % colors.length];
                    }
                    return Container(
                      color: color,
                      child: ListTile(
                        title: Text(proiect['nume'], style: TextStyle(color: Colors.white)),
                        subtitle: Text(
                          'Number of persons: ${proiect['nrPersoane']}\nNumber of days: ${proiect['nrZile']}',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () {
                                _showUpdateDialog(context, proiect.id, proiect['nume'], proiect['nrPersoane'], proiect['nrZile']);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _showDeleteConfirmationDialog(context, proiect.id);
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GenereazaCampul(projectId: proiect.id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String projectId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this project?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteProject(projectId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteProject(String projectId) {
    FirebaseFirestore.instance.collection('Proiecte').doc(projectId).delete();
  }

  void _showUpdateDialog(BuildContext context, String projectId, String currentName, String currentNrPersoane, String currentNrZile) {
    TextEditingController nameController = TextEditingController(text: currentName);
    TextEditingController nrPersoaneController = TextEditingController(text: currentNrPersoane);
    TextEditingController nrZileController = TextEditingController(text: currentNrZile);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: nrPersoaneController,
                decoration: InputDecoration(labelText: 'Number of Persons'),
              ),
              TextField(
                controller: nrZileController,
                decoration: InputDecoration(labelText: 'Number of Days'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                _updateProject(projectId, nameController.text, nrPersoaneController.text, nrZileController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateProject(String projectId, String newName, String newNrPersoane, String newNrZile) {
    FirebaseFirestore.instance.collection('Proiecte').doc(projectId).update({
      'nume': newName,
      'nrPersoane': newNrPersoane,
      'nrZile': newNrZile,
    });
  }
}
