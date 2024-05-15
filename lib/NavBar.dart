import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

import 'ListaProiecte.dart';
import 'Theme/colors.dart';

class NavBar extends StatelessWidget {
  void _showHowItWorksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.crimson,
          title: Text(
            'How does it work?',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'blabla',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Exit',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.crimson,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.skin, // Set the background color of the row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          UserAccountsDrawerHeader(
            accountName: null,
            accountEmail: firebase_auth.FirebaseAuth.instance.currentUser != null
                ? Text(firebase_auth.FirebaseAuth.instance.currentUser!.email ?? 'example@gmail.com')
                : Text('example@gmail.com'),

            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/avatargirl.png'),
                    ),
                  ),
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/menu.png'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            title: Text(
              'Saved projects',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListaProiecte()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.build,
              color: Colors.white,
            ),
            title: Text(
              'How does it work',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => _showHowItWorksDialog(context), // Show the dialog
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text(
              'Edit profile',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
