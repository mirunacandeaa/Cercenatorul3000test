import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'HomePage.dart';
import 'Theme/colors.dart';
import 'Theme/textsize.dart';
import 'Widgets/custom_button.dart';
import 'main.dart'; // Importați pagina de autentificare

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void signUp(BuildContext context) async {
    try {
      print("Attempting to sign up...");
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _usernameController.text, password: _passwordController.text);
      print("Signup successful");
      // Navigați înapoi la pagina de autentificare după înregistrare
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print("Signup error: $e");
      // Afisarea mesajului de eroare pe ecran folosind SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Signup error: $e"),
          backgroundColor: Colors.red, // Culorea de fundal a SnackBar-ului
        ),
      );
    }
  }

  void goToLoginPage(BuildContext context) {
    // Navigați înapoi la pagina de autentificare
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/menu.png'), // Imaginea de fundal
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.5), // Opacitatea fundalului
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: AppColors.skin.withOpacity(0.8), // Culorea containerului și opacitatea
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
                      signUp(context);
                    },
                    text: 'Sign Up', // Textul butonului de înregistrare
                  ),
                  SizedBox(height: 10), // Spațiu suplimentar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ai deja cont? ', // Textul înainte de butonul de login
                        style: TextStyle(fontSize: 16.0),
                      ),
                      InkWell(
                        onTap: () {
                          goToLoginPage(context); // Navigați la pagina de autentificare
                        },
                        child: Text(
                          'Log in!', // Textul butonului de login
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
