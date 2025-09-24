import 'package:demo/screens/home.dart';
import 'package:flutter/material.dart';

int count = 0;
void main() {
  runApp(
    const MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false),
  );
}
