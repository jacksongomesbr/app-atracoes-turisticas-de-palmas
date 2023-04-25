class Foto {
  final String thumbnail;
  final String small;
  Foto({required this.thumbnail, required this.small});
  factory Foto.fromJson(Map<String, dynamic> json) {
    return Foto(
      thumbnail: json['data']['attributes']['formats']['thumbnail']['url'],
      small: json['data']['attributes']['formats']['small']['url']
    );
  }
}

class Avaliacao {
  final double media;
  final int quantidade;

  Avaliacao({required this.media, required this.quantidade});

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    String strMedia = json['media'].toString();
    if (!strMedia.toString().contains('.')) {
      strMedia += '.0';
    }
    return Avaliacao(
      media: double.parse(strMedia),
      quantidade: json['quantidade'],
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
      valor: json['valor']
    );
  }
}

class AtracaoTuristica {
  final int id;
  final String nome;
  final int ranking;
  final String categoria;
  final Avaliacao avaliacao;
  final String localizacao;
  final String descricao;
  final List<Horario> horarios;
  final List<Destaque> destaques;
  final Custo custo;
  final Foto foto;

  AtracaoTuristica({required this.id, required this.nome,
    required this.ranking, required this.categoria,
    required this.avaliacao, required this.localizacao,
    required this.descricao, required this.horarios,
    required this.custo,
    required this.destaques,
    required this.foto
  });

  factory AtracaoTuristica.fromJson(Map<String, dynamic> json) {
    return AtracaoTuristica(id: json['id'],
        nome: json['attributes']['nome'],
        ranking: json['attributes']['ranking'],
        categoria: json['attributes']['categoria'],
        avaliacao: Avaliacao.fromJson(json['attributes']['avaliacao']),
        localizacao: json['attributes']['localizacao'],
        descricao: json['attributes']['descricao'].toString().replaceAll('\\n', '\n'),
        horarios: json['attributes']['horarios'].map<Horario>((j) => Horario.fromJson(j)).toList(),
        destaques: json['attributes']['destaques'].map<Destaque>((j) => Destaque.fromJson(j)).toList(),
        custo: Custo.fromJson(json['attributes']['custo']),
        foto: Foto.fromJson(json['attributes']['foto'])
    );
  }
}
