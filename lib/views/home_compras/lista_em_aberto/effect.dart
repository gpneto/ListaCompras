import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:lista_compras/models/lista_compras.dart';
import 'package:lista_compras/views/home_compras/lista_em_aberto/action.dart';
import 'package:lista_compras/views/home_compras/lista_em_aberto/state.dart';





Effect<ListaComprasAbertaState> buildEffect() {
  return combineEffects(<Object, Effect<ListaComprasAbertaState>>{
    ListaComprasAbertoAction.onAddAction: _onAdd,
    ListaComprasAbertoAction.seeAll: _seeAllOpen,
  });
}

void _onAdd(Action action, Context<ListaComprasAbertaState> ctx) {
  // Navigator.of(ctx.context)
  //     .pushNamed(AppRoute.entry_edit, arguments: null)
  //     .then((dynamic toDo) {
  //   if (toDo != null &&
  //       (toDo.title?.isNotEmpty == true || toDo.desc?.isNotEmpty == true)) {
  //     // ctx.dispatch(list_action.ToDoListActionCreator.add(toDo));
  //   }
  // });
}


void _seeAllOpen(Action action, Context<ListaComprasAbertaState> ctx) async{
  final List<ListaCompra> lista = action.payload;
  await Navigator.of(ctx.context).push(MaterialPageRoute(builder: (context) {
    // return ListEntriesPage().buildPage({'listaCompras': lista});
  }));

}

