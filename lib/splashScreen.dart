// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:tictac/HomePage.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "lib/images/black tictac.jpg",
              scale: 1,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  height: 60,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Start Playing',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
