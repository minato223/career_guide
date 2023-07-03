import 'dart:ui';

import 'package:flutter/material.dart';

class Mino extends StatelessWidget {
  const Mino({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          SafeArea(child: Text("data", style: TextStyle(fontSize: 30))),
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Transform.translate(
                  offset: Offset(0.0, 150),
                  child: Stack(
                    children: [
                      Container(
                        height: 300,
                        width: 200,
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            "data",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: 200,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          "data",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
