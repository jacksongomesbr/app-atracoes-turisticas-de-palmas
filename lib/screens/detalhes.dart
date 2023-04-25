import 'package:app_turismo_palmas/widgets/avaliacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/AtracaoTuristica.dart';

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

class PaginaDetalhesDaAtracao extends StatefulWidget {
  const PaginaDetalhesDaAtracao({Key? key, required this.atracao})
      : super(key: key);
  final AtracaoTuristica atracao;

  @override
  State<PaginaDetalhesDaAtracao> createState() =>
      _PaginaDetalhesDaAtracaoState();
}

class _PaginaDetalhesDaAtracaoState extends State<PaginaDetalhesDaAtracao> {
  @override
  Widget build(BuildContext context) {
    final List<Column> destaques = widget.atracao.destaques
        .map(
          (d) => Column(
            children: [
              Icon(iconesDeDetalhes[d.valor]!, color: Colors.black38),
              Text(
                d.titulo,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black54,
                    ),
              ),
            ],
          ),
        )
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            foregroundColor: Colors.white70,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: NetworkImage('${Constants.MEDIA_HOST}${widget.atracao.foto.small}'),
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
                          widget.atracao.nome,
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
                        'Atração #${widget.atracao.ranking}',
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
                    widget.atracao.localizacao,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AvaliacaoDaAtracao(
                    media: widget.atracao.avaliacao.media,
                    quantidade: widget.atracao.avaliacao.quantidade,
                  ),
                  const Divider(height: 20),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: destaques,
),
                  const Divider(height: 20),
                  Text(widget.atracao.descricao),
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
                      .format(widget.atracao.custo.valor),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  '/${widget.atracao.custo.tipo}',
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
  }
}
