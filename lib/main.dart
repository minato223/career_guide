import 'package:career_guide/themes/theme_provider.dart';
import 'package:career_guide/views/job_detail/job_detail.dart';
import 'package:career_guide/views/menu/menu.dart';
import 'package:career_guide/widgets/animated_text.dart';
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
      theme: ThemeProvider.light,
      home: const Menu(),
    );
  }
}
