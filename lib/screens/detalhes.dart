import 'package:app_turismo_palmas/widgets/avaliacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/AtracaoTuristica.dart';
import '../utils.dart';

double str2double(dynamic s) {
  String str = s.toString();
  if (!str.contains('.')) {
    str += '.0';
  }
  return double.parse(str);
}

final Map<String, IconData> iconesDeDetalhes = {
  'familia': Icons.family_restroom_rounded,
  'praia': Icons.beach_access_rounded,
  'financeiro': Icons.attach_money_rounded,
  'estacionamento': Icons.garage_rounded,
  'natureza': Icons.eco_rounded,
  'nao-acessivel': Icons.not_accessible_rounded,
  'alimentacao': Icons.restaurant_rounded
};

abstract class ItemDeDetalhe {}

class PaginaDetalhesArguments {
  final int id;

  PaginaDetalhesArguments(this.id);
}

class PaginaDetalhesDaAtracao extends StatefulWidget {
  const PaginaDetalhesDaAtracao({Key? key}) : super(key: key);

  @override
  State<PaginaDetalhesDaAtracao> createState() =>
      _PaginaDetalhesDaAtracaoState();
}

class _PaginaDetalhesDaAtracaoState extends State<PaginaDetalhesDaAtracao> {
  Future _carregarDados(id) {
    return supabase.from('atracoes_turisticas').select('''
        *,
        destaques:destaques_de_atracoes_turisticas (
          valor,
          titulo
        ),
        horarios:horarios_de_atracoes_turisticas (
          dia,
          inicio,
          fim
        ),
        tipos_de_custos (
          nome
        )
        ''').eq('id', id).single();
  }



  List<Column> _buildDestaques(atracao) {
    List<Column> lista = [];
    for (Map<String, dynamic> d in atracao['destaques']) {
      lista.add(
        Column(
          children: [
            Icon(iconesDeDetalhes[d['valor']], color: Colors.black38),
            Text(
              d['titulo'],
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.black54,
                  ),
            ),
          ],
        ),
      );
    }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PaginaDetalhesArguments;
    return FutureBuilder(
      future: _carregarDados(args.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final atracao = snapshot.data;
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  foregroundColor: Colors.white70,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image(
                      image:
                          NetworkImage(getPublicUrl(atracao['foto_big_url'])),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                atracao['nome'],
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: -1,
                                        height: 1),
                              ),
                            ),
                            Text(
                              'Atração #${atracao['ranking']}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          atracao['localizacao'],
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AvaliacaoDaAtracao(
                          media: str2double(atracao['media_de_avaliacoes']),
                          quantidade: atracao['quantidade_de_avaliacoes'],
                        ),
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _buildDestaques(atracao),
                        ),
                        const Divider(height: 20),
                        Text(atracao['descricao']),
                      ],
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                boxShadow: const [
                  BoxShadow(color: Colors.black54, blurRadius: 10),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Reserva confirmada!'),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                              // Code to execute.
                            },
                          ),
                        ),
                      );
                    },
                    child: const Text('Agendar'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        NumberFormat.currency(symbol: 'R\$')
                            .format(atracao['valor_do_custo']),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        '/${atracao['tipos_de_custos']['nome']}',
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
            ),
            child: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
