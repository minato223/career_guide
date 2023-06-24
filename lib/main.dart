<<<<<<< HEAD
import 'package:career_guide/views/background/animated_home_background.dart';
=======
import 'package:career_guide/views/animation_view.dart';
>>>>>>> deuxieme-animation-des-card-superposés
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: "Urbanist"),
<<<<<<< HEAD
      home: const Text("data"),
=======
      home: const AnimationView(),
>>>>>>> deuxieme-animation-des-card-superposés
    );
  }
}
