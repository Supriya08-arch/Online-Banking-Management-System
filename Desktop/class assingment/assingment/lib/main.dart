import 'package:assingment/screen/register.dart';
import 'package:assingment/screen/result.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const Student_Details(),
      '/view': (context) => const ResultScreen(),
    },
  ));
}
