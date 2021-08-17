import 'package:cloud_firestore/cloud_firestore.dart';

class ItemListaCompra {
  String id;
  final String produtoNome;
  final int quantidade;
  final String medida;
  bool finalizado;

  final double ultimoValor;
  double valorAtual;
  int quantidadeComprada;

  ItemListaCompra(
      {this.id,
        this.produtoNome,
      this.quantidade = 0,
      this.finalizado = false,
      this.medida = "",
      this.ultimoValor,
      this.valorAtual,
      this.quantidadeComprada});
}
