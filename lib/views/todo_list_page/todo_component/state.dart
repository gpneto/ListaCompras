import 'package:fish_redux/fish_redux.dart';
// import 'package:uuid/uuid.dart';

class ToDoState implements Cloneable<ToDoState> {


  String idLista;
  String uniqueId;
  bool isDone;

  String produtoNome;
  int quantidade;
  String medida;
  double ultimoValor;
  double valorComprado;
  int quantidadeComprada;


  ToDoState({this.idLista, this.uniqueId,this.isDone = false, this
      .produtoNome, this.quantidade=0,  this.medida = "", this.ultimoValor,
    this.valorComprado, this.quantidadeComprada}) ;


  @override
  ToDoState clone() {
    return ToDoState()
      ..idLista = idLista
      ..uniqueId = uniqueId
      ..produtoNome = produtoNome
      ..quantidade = quantidade
      ..medida = medida
      ..valorComprado = valorComprado
      ..ultimoValor = ultimoValor
      ..quantidadeComprada = quantidadeComprada
      ..isDone = isDone;
  }

  @override
  String toString() {
    return 'ToDoState{uniqueId: $uniqueId, isDone: $isDone, quantidade: $quantidade}';
  }
}
