import 'package:flutter/material.dart';

class AvaliacaoDaAtracao extends StatelessWidget {
  const AvaliacaoDaAtracao(
      {Key? key, required this.media, required this.quantidade})
      : super(key: key);

  final int quantidade;
  final double media;

  @override
  Widget build(BuildContext context) {
    List<Widget> estrelas = <Widget>[];
    for (int i = 0; i < media.round(); i++) {
      estrelas.add(
        Icon(
          Icons.star_rounded,
          size: 16,
          color: Colors.deepOrange,
        ),
      );
    }
    for (int i = 0; i < 5 - media.round(); i++) {
      estrelas.add(
        Icon(
          Icons.star_border_rounded,
          size: 16,
          color: Colors.deepOrange,
        ),
      );
    }
    String strQuantidade = '(nenhuma avaliação até o momento)';
    if (quantidade == 1) {
      strQuantidade = '(1 avaliação)';
    } else if (quantidade > 1) {
      strQuantidade = '(${quantidade} avaliações)';
    }
    return Row(
      children: [
        Row(
          children: estrelas,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          media.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          strQuantidade,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
