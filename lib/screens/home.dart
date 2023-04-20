import 'dart:convert';

import 'package:aula_3_turismo_palmas/screens/sobre.dart';
import 'package:flutter/material.dart';

import '../models/AtracaoTuristica.dart';
import '../services/AtracaoTuristicaService.dart';
import 'detalhes.dart';

class PaginaHome extends StatefulWidget {
  const PaginaHome({super.key});

  @override
  State<PaginaHome> createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  late Future<List<AtracaoTuristica>> _atracoes;

  Future<List<AtracaoTuristica>> carregarDados() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/data/atracoes.json');
    final json = jsonDecode(data);
    List<AtracaoTuristica> atracoes = AtracaoTuristicaService.fromJson(json);
    return atracoes;
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
                          backgroundImage: AssetImage(
                              'assets/images/${atracao.id}_thumb.jpg'),
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
