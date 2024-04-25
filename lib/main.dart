import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("Initializing Firebase...");
  await Firebase.initializeApp();
  print("Firebase initialized");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  void signup() async {
    try {
      print("Attempting to sign up...");
      await firebaseAuth.createUserWithEmailAndPassword(
          email: 'candeamirunagabriela@gmail.com', password: 'Cosinus10!');
      print("Signup successful");
    } catch (e) {
      print("Signup error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("test"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              signup();
            },
            child: Text("SignUp"),
          ),
        ),
      ),
    );
  }
}

