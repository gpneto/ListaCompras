import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/data/FirebaseServiceDados.dart';
import 'package:lista_compras/models/produto.dart';
import 'package:lista_compras/views/todo_list_page/todo_component/component.dart';

import 'action.dart';
import 'state.dart';

Effect<AddProdutoState> buildEffect() {
  return combineEffects(<Object, Effect<AddProdutoState>>{
    Lifecycle.initState: _onInit,
    AddProdutoAction.addProduto: _onAdd,
  });
}

void _onInit(Action action, Context<AddProdutoState> ctx) async {
  await FirebaseServiceDados.consultaProdutosFirebase().listen((event) {
    // Get data from docs and convert map to List
    final allData = event.docs
        .map((e) => Produto(
            id: e.id,
            produtoNome: e.get("nome"),
            medida: e.get("medida"),
            ultimoValor: e.get("valor"),
            ))
        .toList();
    ctx.dispatch(AddProdutoActionCreator.setListaProdutos(allData));
  });
}

void _onAdd(Action action, Context<AddProdutoState> ctx) async {
  ToDoState produto = action.payload;

  if (produto.uniqueId == null) {
    produto.uniqueId = await _adicionadProdutoAoUsuarioERetornaId(produto);
  }
  _adicionadProdutoALista(produto);
}

Future<String> _adicionadProdutoAoUsuarioERetornaId(ToDoState produto) async {
  return (await FirebaseServiceDados.saveProdutoNoUsuario(produto)).id;
}

Future<void> _adicionadProdutoALista(ToDoState produto) async {
  return (await FirebaseServiceDados.saveProdutoNaLista(produto));
}
