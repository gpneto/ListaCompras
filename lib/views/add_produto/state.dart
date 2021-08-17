import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:lista_compras/models/produto.dart';
import 'package:lista_compras/views/todo_list_page/state.dart';
import 'package:lista_compras/views/todo_list_page/todo_component/component.dart';

class AddProdutoState implements Cloneable<AddProdutoState> {

  String idLista;
  TextEditingController autoCompleteController ;
  ToDoState produto;

  List<Produto> produtosCadastrados;


  @override
  AddProdutoState clone() {
    return AddProdutoState()..produto = produto
    ..autoCompleteController = autoCompleteController
    ..produtosCadastrados = produtosCadastrados
    ..idLista = idLista;
  }
}

AddProdutoState initState(Map<String, dynamic> args) {
  return AddProdutoState()..produto = ToDoState()
    ..idLista = args["idLista"]
  ..autoCompleteController = TextEditingController();
}
