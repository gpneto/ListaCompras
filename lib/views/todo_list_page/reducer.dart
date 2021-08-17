import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/item_lista_compra.dart';
import 'package:lista_compras/models/lista_compras.dart';

import 'action.dart';
import 'state.dart';
import 'todo_component/component.dart';

Reducer<PageState> buildReducer() {
  return asReducer(
    <Object, Reducer<PageState>>{PageAction.initToDos: _initToDosReducer},
  );
}

PageState _initToDosReducer(PageState state, Action action) {
  final ListaCompra lista = action.payload ?? ListaCompra();


  List<ToDoState> initToDos = [];

  for( ItemListaCompra item in lista.listaProdutos){
    initToDos.add( ToDoState(
        idLista: lista.id,
        uniqueId: item.id,
        produtoNome: item.produtoNome,
        quantidadeComprada: item.quantidadeComprada,
        medida: item.medida,
        quantidade: item.quantidade,
        isDone: item.finalizado,
        ultimoValor: item.ultimoValor,
        valorComprado: item.valorAtual
    ));
  }


  final PageState newState = state.clone();
  newState.toDos = initToDos;

  return newState;
}
