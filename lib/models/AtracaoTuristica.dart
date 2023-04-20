class Avaliacao {
  final double media;
  final int quantidade;

  Avaliacao({required this.media, required this.quantidade});

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      media: json['media'] as double,
      quantidade: json['quantidade'] as int,
    );
  }
}

class Horario {
  final String dia;
  final String inicio;
  final String fim;

  Horario({required this.dia, required this.inicio, required this.fim});

  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      dia: json['dia'],
      inicio: json['inicio'],
      fim: json['fim']
    );
  }
}

class Destaque {
  final String valor;
  final String titulo;

  Destaque({required this.valor, required this.titulo});

  factory Destaque.fromJson(Map<String, dynamic> json) {
    return Destaque(
      valor: json['valor'],
      titulo: json['titulo']
    );
  }
}

class Custo {
  final String tipo;
  final double valor;
  Custo({required this.tipo, required this.valor});
  factory Custo.fromJson(Map<String, dynamic> json) {
    return Custo(
      tipo: json['tipo'],
      valor: json['valor'] as double
    );
  }
}

class AtracaoTuristica {
  final String id;
  final String nome;
  final int ranking;
  final String categoria;
  final Avaliacao avaliacao;
  final String localizacao;
  final String descricao;
  final List<Horario> horarios;
  final List<Destaque> destaques;
  final Custo custo;

  AtracaoTuristica({required this.id, required this.nome,
    required this.ranking, required this.categoria,
    required this.avaliacao, required this.localizacao,
    required this.descricao, required this.horarios,
    required this.custo,
    required this.destaques
  });

  factory AtracaoTuristica.fromJson(Map<String, dynamic> json) {
    return AtracaoTuristica(id: json['id'],
        nome: json['nome'],
        ranking: json['ranking'] as int,
        categoria: json['categoria'],
        avaliacao: Avaliacao.fromJson(json['avaliacao']),
        localizacao: json['localizacao'],
        descricao: json['descricao'],
        horarios: json['horarios'].map<Horario>((j) => Horario.fromJson(j)).toList(),
        destaques: json['destaques'].map<Destaque>((j) => Destaque.fromJson(j)).toList(),
        custo: Custo.fromJson(json['custo'])
    );
  }
}
