import 'package:aula_3_turismo_palmas/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/* tipo de viajante: romântica, família, amigos, negócios, sozinho */


void main() {
  Intl.defaultLocale = 'pt_BR';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turismo em Palmas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const PaginaHome(),
    );
  }
}
