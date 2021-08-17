import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  String idLista;
  String id;
  final String produtoNome;
  final String medida;
  final double ultimoValor;

  Produto({
    this.idLista,
    this.id,
    this.produtoNome,
    this.medida = "",
    this.ultimoValor,
  });
}
