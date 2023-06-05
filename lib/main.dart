import 'package:flutter/material.dart';
// Base Page import
import 'package:my4/expenses_tracker.dart';

var colorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 117, 9, 241)); 

var darkcolortheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255,5,99,125));


void main() {
  runApp(MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: darkcolortheme
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme:colorScheme,
        cardTheme: const CardTheme().copyWith(
          color: colorScheme.onSecondary,
          margin: const EdgeInsets.all(20)
        ),
        
      ),
      themeMode: ThemeMode.system,
      home: const Expenses()));
}
