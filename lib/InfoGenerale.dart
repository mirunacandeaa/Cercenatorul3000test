
import 'package:flutter/material.dart';

import 'Theme/colors.dart';
import 'Theme/textsize.dart';
import 'Widgets/bottom_navigation.dart';
import 'Widgets/custom_button.dart';
import 'locatii1.dart';

class InfoGenerale extends StatefulWidget {
  @override
  _InfoGeneraleState createState() => _InfoGeneraleState();
}

class _InfoGeneraleState extends State<InfoGenerale> {
  List<String> initialTexts = ['Nume proiect', 'Numar de persoane', 'Numar de zile']; // Initial texts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skin,
      appBar: AppBar(
        backgroundColor: AppColors.skin,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
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
              itemCount: initialTexts.length + 1, // Adăugăm unul pentru textul cu Sibiu
              itemBuilder: (context, index) {
                if(index < initialTexts.length) {
                  return ListTile(
                    title: TextFormField(
                      initialValue: initialTexts[index],
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
                }




              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 150),
          child: CustomButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => locatii1()));
            },
            text: 'save',
          ),
        ),
      ),
    );
  }
}
