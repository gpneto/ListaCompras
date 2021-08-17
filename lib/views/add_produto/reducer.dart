import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/produto.dart';
import 'package:lista_compras/views/todo_list_page/todo_component/component.dart';

import 'action.dart';
import 'state.dart';

Reducer<AddProdutoState> buildReducer() {
  return asReducer(
    <Object, Reducer<AddProdutoState>>{
      AddProdutoAction.selectProduto: _selectProduto,
      AddProdutoAction.setListaProdutos: _setLista,
    },
  );
}

AddProdutoState _selectProduto(AddProdutoState state, Action action) {
  Produto produto = action.payload;
  final AddProdutoState newState = state.clone()..produto = ToDoState
    (uniqueId: produto.id, produtoNome: produto.produtoNome, ultimoValor:
  produto.ultimoValor, medida: produto.medida, idLista:  state.idLista);
  return newState;
}



AddProdutoState _setLista(AddProdutoState state, Action action) {
  List<Produto> produto = action.payload;
  final AddProdutoState newState = state.clone()..produtosCadastrados = produto;
  return newState;
}
