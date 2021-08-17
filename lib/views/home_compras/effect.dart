import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';

import 'package:flutter/material.dart' hide Action;
import 'package:lista_compras/data/FirebaseServiceDados.dart';
import 'package:lista_compras/models/item_lista_compra.dart';
import 'package:lista_compras/models/lista_compra_usuario.dart';
import 'package:lista_compras/models/lista_compras.dart';
import 'package:lista_compras/views/todo_list_page/page.dart';

import 'action.dart';
import 'state.dart';

Effect<HomeComprasState> buildEffect() {
  return combineEffects(<Object, Effect<HomeComprasState>>{
    HomeComprasAction.addNovaLista: _addNovaLista,
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<HomeComprasState> ctx) {
  FirebaseServiceDados.consultaReferenciaListaComprasDoUsuarioFirebase()
      .listen((event) {
    List<ListaCompraUsuario> listaCompras = event.docs
        .map((e) => ListaCompraUsuario.fromJson(e.reference, e.data()))
        .toList();

    listaCompras.sort((a, b) => b.data.compareTo(a.data));

    ctx.dispatch(HomeComprasActionCreator.finalizouBuscaListaEmAberto(
        listaCompras
            .where((element) =>
                element.finalizado == null || element.finalizado == false)
            .toList()));

    ctx.dispatch(HomeComprasActionCreator.finalizouBuscaListaFinalizadas(
        listaCompras.where((element) => element.finalizado == true).toList()));
  });
  FirebaseServiceDados().listaComprarFinalizadasFromFirebase(ctx);
}

void _addNovaLista(Action action, Context<HomeComprasState> ctx) {
  String nome = action.payload;
  FirebaseServiceDados.addNovaListaNoUsuario(nome).then((value) =>
      Navigator.of(ctx.context).push(MaterialPageRoute(builder: (context) {
        return ToDoListPage().buildPage({'idLista': value.id});
      })));
}
