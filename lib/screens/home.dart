import 'dart:convert';

import 'package:app_turismo_palmas/screens/sobre.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../models/AtracaoTuristica.dart';
import '../services/AtracaoTuristicaService.dart';
import '../constants.dart';
import 'detalhes.dart';

class PaginaHome extends StatefulWidget {
  const PaginaHome({super.key});

  @override
  State<PaginaHome> createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  late Future<List<AtracaoTuristica>> _atracoes;

  Future<List<AtracaoTuristica>> carregarDados() async {
    final response = await http.get(Uri.parse('${Constants.API_HOST}/atracoes-turisticas?populate=*'));
    if (response.statusCode == 200) {
      return AtracaoTuristicaService.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar a lista de atrações turísticas.');
    }
  }

  @override
  void initState() {
    super.initState();
    _atracoes = carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atrações turísticas de Palmas'),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline_rounded),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaginaSobre(),
                ),
              )
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<AtracaoTuristica>>(
          future: _atracoes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!
                    .map(
                      (atracao) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage('${Constants.MEDIA_HOST}${atracao.foto.thumbnail}'),
                        ),
                        title: Text(atracao.nome),
                        subtitle: Text(atracao.localizacao),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PaginaDetalhesDaAtracao(atracao: atracao),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
