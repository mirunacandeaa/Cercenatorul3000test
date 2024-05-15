import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Theme/colors.dart';

class GenereazaCampul extends StatelessWidget {
  final String projectId;

  GenereazaCampul({required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Genereaza Campul"),
        backgroundColor: AppColors.skin,
      ),
      body: Container(
        color: AppColors.skin,
        padding: EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.crimson,
            padding: EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('Proiecte').doc(projectId).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String nume = snapshot.data!['nume'];
                      return Text(
                        nume,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      );
                    }
                  },
                ),
                SizedBox(height: 16),

                Text(
                  "Number of Persons:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('Proiecte').doc(projectId).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String nrPersoane = snapshot.data!['nrPersoane'];
                      return Text(
                        nrPersoane,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      );
                    }
                  },
                ),
                SizedBox(height: 16),

                Text(
                  "Number of Days:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('Proiecte').doc(projectId).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String nrZile = snapshot.data!['nrZile'];
                      return Text(
                        nrZile,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      );
                    }
                  },
                ),
                SizedBox(height: 16),

                Text(
                  "Judete:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('Proiecte').doc(projectId).collection('Judete').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          String judet = snapshot.data!.docs[index]['judet'];
                          return Text(
                            judet,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: 16),

                Text(
                  "Relief:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('Proiecte').doc(projectId).collection('Relief').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          String relief = snapshot.data!.docs[index]['relief'];
                          return Text(
                            relief,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: 16),

                Text(
                  "Recomandari:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('Proiecte').doc(projectId).collection('Recomandari').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> recomandareData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Difficulty: ${recomandareData['difficulty']}",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                "Duration: ${recomandareData['duration']}",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                "Kilometers: ${recomandareData['kilometers']}",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                "Place: ${recomandareData['place']}",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                "Region: ${recomandareData['region']}",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              SizedBox(height: 16),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: 16),

                Text(
                  "Trasee:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('Proiecte').doc(projectId).collection('Trasee').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> traseuData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Difficulty: ${traseuData['difficulty']}",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                "Duration: ${traseuData['duration']}",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                "Kilometers: ${traseuData['kilometers']}",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                "Place: ${traseuData['place']}",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                "Region: ${traseuData['region']}",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              SizedBox(height: 16),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: 16),

                Text(
                  "Orase:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('Proiecte').doc(projectId).collection('Orase').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          String oras = snapshot.data!.docs[index]['oras'];
                          return Text(
                            oras,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
