import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'Splash_Screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print(await Firebase.initializeApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash:"Asset/logo.jpeg",
        nextScreen: SplashScreen(),
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: Colors.amber,
      ),
    );
  }
}

