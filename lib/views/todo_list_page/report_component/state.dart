import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/lista_compras.dart';

class ReportState implements Cloneable<ReportState> {

  int total;
  int done;
  double valorTotal;
  double valorEstimado;
  ListaCompra listaCompra;

  ReportState(
      {this.total = 0,
      this.done = 0,
      this.valorTotal,
      this.valorEstimado = 0,
      this.listaCompra});

  @override
  ReportState clone() {
    return ReportState()
      ..total = total
      ..done = done
      ..valorTotal = valorTotal
      ..listaCompra = listaCompra;
  }

  @override
  String toString() {
    return 'ReportState{total: $total, done: $done}';
  }
}
