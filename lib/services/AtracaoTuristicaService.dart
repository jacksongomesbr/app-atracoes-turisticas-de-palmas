import '../models/AtracaoTuristica.dart';

class AtracaoTuristicaService {
  static List<AtracaoTuristica> fromJson(dynamic json) {
    List<AtracaoTuristica> atracoes = json['data']
        .map<AtracaoTuristica>((j) => AtracaoTuristica.fromJson(j))
        .toList();
    return atracoes;
  }
}
