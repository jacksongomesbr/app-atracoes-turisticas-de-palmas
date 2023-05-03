import 'package:app_turismo_palmas/screens/detalhes.dart';
import 'package:app_turismo_palmas/screens/home.dart';
import 'package:app_turismo_palmas/screens/login.dart';
import 'package:app_turismo_palmas/screens/sobre.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants.dart';

/* tipo de viajante: romântica, família, amigos, negócios, sozinho */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: Constants.SUPABASE_URL, anonKey: Constants.SUPABASE_ANON_KEY);
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
      initialRoute: '/',
      routes: {
        '/': (context) => const PaginaLogin(),
        '/home': (context) => const PaginaHome(),
        '/sobre': (context) => const PaginaSobre(),
        '/detalhes': (context) => const PaginaDetalhesDaAtracao(),
      },
    );
  }
}
