import 'package:flutter/material.dart';

class AppColors {
  static const Color yellow = Color(0xffFFCD19);
  static const Color dark = Color(0xff202023);
  static const Color white = Color(0xffF7F7F7);
  static Color darkenColor(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);

    // Obtention des valeurs RVB de la couleur d'origine
    int red = color.red;
    int green = color.green;
    int blue = color.blue;

    // Calcul des nouvelles valeurs RVB en fonction de la quantité de foncé
    red = (red * (1 - amount)).round();
    green = (green * (1 - amount)).round();
    blue = (blue * (1 - amount)).round();

    // Création et retour de la nouvelle couleur foncée
    return Color.fromARGB(color.alpha, red, green, blue);
  }
}
