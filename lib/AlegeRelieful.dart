import 'package:flutter/material.dart';
import 'Theme/colors.dart';
import 'Widgets/custom_button.dart';

class AlegeRelieful extends StatefulWidget {
  @override
  _AlegeReliefulState createState() => _AlegeReliefulState();
}

class _AlegeReliefulState extends State<AlegeRelieful> {
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
                border: Border(bottom: BorderSide(color: AppColors.pink, width: 2.0)),
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
                        return AspectRatio(
                          aspectRatio: 1.0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (selectedLabels.contains(labels[index])) {
                                  selectedLabels.remove(labels[index]);
                                } else {
                                  selectedLabels.add(labels[index]);
                                }
                              });
                            },
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
                                  labels[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
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
              onPressed: () {
                // Aici poți adăuga acțiunea pentru butonul "Save"
                // de exemplu, poți salva datele selectate
                print('Butonul "Save" a fost apăsat');
              },
              text: 'Save',
            ),
          ],
        ),
      ),
    );
  }
}
