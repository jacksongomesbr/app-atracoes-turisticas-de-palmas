import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/AtracaoTuristica.dart';

class AtracaoTuristicaService {
  static List<AtracaoTuristica> fromJson(dynamic json) {
    List<AtracaoTuristica> atracoes = json
        .map<AtracaoTuristica>((j) => AtracaoTuristica.fromJson(j))
        .toList();
    return atracoes;
  }
}
