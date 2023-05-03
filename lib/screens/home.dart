import 'package:app_turismo_palmas/screens/sobre.dart';
import 'package:app_turismo_palmas/utils.dart';
import 'package:flutter/material.dart';
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
  final _atracoes = supabase
      .from('atracoes_turisticas')
      .select<List<Map<String, dynamic>>>(
          'id, nome, localizacao, foto_thumbnail_url');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atrações turísticas de Palmas'),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline_rounded),
            onPressed: () {
              Navigator.pushNamed(context, '/sobre');
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _atracoes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.map(
                  (atracao) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            getPublicUrl(atracao['foto_thumbnail_url'])),
                      ),
                      title: Text(atracao['nome']),
                      subtitle: Text(atracao['localizacao']),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detalhes',
                          arguments: PaginaDetalhesArguments(atracao['id']),
                        );
                      },
                    );
                  },
                ).toList(),
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
