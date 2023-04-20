import 'package:flutter/material.dart';

class PaginaSobre extends StatelessWidget {
  const PaginaSobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o App'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(18),
          child:
              const Text('O app Atrações Turísticas de Palmas tem o objetivo '
                  'de divulgar e promover o conhecimento de atrações '
                  'turísticas da Capital do Tocantins.\n\n'
                  'Aqui são apresentadas informações sobre as atrações '
                  'turísticas, como: localização, avaliações e destaques.'
                  '\n\n'
                  'Além disso, o app permite realizar a reserva '
                  'para que você possa visitar a atração turística.'
                  '\n\n'
                  'As informações apresentadas aqui são obtidas de fontes '
                  'públicas de informações:\n\n'
                  '🌐 TripAdvisor (https://tripadvisor.com)\n'
                  '🌐 EncontraPalmas (https://encontrapalmas.com.br)'),
        ),
      ),
    );
  }
}
