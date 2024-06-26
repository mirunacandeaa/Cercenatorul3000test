import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'HomePage.dart';
import 'NavBar.dart';
import 'SignUpPage.dart';
import 'Theme/colors.dart';
import 'Theme/textsize.dart';
import 'Widgets/custom_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("Initializing Firebase...");
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDR1ieoRmpl7TaMikOSemC-t9Xnzgi7ads',
      appId: '1:422720968169:web:bcd2e596cb2fc01042a778',
      messagingSenderId: '422720968169',
      projectId: 'cercenatorul3000-5c8d6',
      authDomain: 'cercenatorul3000-5c8d6.firebaseapp.com',
      storageBucket: 'cercenatorul3000-5c8d6.appspot.com',
    ),
  );
  print("Firebase initialized");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(), // Use MainPage as the initial route
    );
  }
}


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void login(BuildContext context) async {
    try {
      print("Attempting to login...");
      await firebaseAuth.signInWithEmailAndPassword(
          email: _usernameController.text, password: _passwordController.text);
      print("Login successful");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print("Login error: $e");
      // Afisarea mesajului de eroare pe ecran folosind SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login error: $e"),
          backgroundColor: Colors.red, // Culorea de fundal a SnackBar-ului
        ),
      );
    }
  }

  void goToSignUpPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/menu.png'), // Example image
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.5), // Adjust opacity here
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: AppColors.skin.withOpacity(0.8), // Adjust opacity here
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                filled: true,
                                fillColor: Colors.transparent,
                                border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Stack(
                          children: [
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                filled: true,
                                fillColor: Colors.transparent,
                                border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  CustomButton(
                    onPressed: () {
                      login(context);
                    },
                    text: 'Login',
                  ),
                  SizedBox(height: 10), // Add some space
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nu ai cont? ',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      InkWell(
                        onTap: () {
                          goToSignUpPage(context);
                        },
                        child: Text(
                          'Sign up!',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
