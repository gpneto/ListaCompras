import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:lista_compras/data/FirebaseServiceDados.dart';
import 'package:lista_compras/models/item_lista_compra.dart';
import 'package:lista_compras/models/lista_compras.dart';
import 'package:lista_compras/views/add_produto/action.dart';
import 'package:toast/toast.dart';

import 'action.dart';
import 'list_adapter/action.dart' as list_action;
import 'state.dart';
import 'todo_component/component.dart';

Effect<PageState> buildEffect() {
  return combineEffects(<Object, Effect<PageState>>{
    Lifecycle.initState: _init,
    PageAction.onAdd: _onAdd,
    PageAction.onArquivarLista: _onArquivar,
    PageAction.onCompartilharLista: _onCompartilharLista,
  });
}

void _init(Action action, Context<PageState> ctx) async {
  await FirebaseServiceDados.consultaListaComprasFirebase(ctx.state
      .listaCompra.id)
      .listen((event) async {
    // Get data from docs and convert map to List

    await event.reference
        .collection("produtos")
        .snapshots()
        .listen((produtos) async {


      final allData = produtos.docs
          .map((e) => ItemListaCompra(
          id: e.id,
              produtoNome: e.get("nome"),
              medida: e.data()["medida"],
              ultimoValor: e.data()["valor"],
              quantidade: e.get("quantidade") ?? 0,
              finalizado: e.data()["selecionado"] ?? false,
              valorAtual: e.data()["valorCompra"] == null ? null : double.tryParse(e.data()["valorCompra"].toString()),
              quantidadeComprada: e.data()["quantidadeComprada"]))
          .toList();

      ListaCompra listaCompra = ListaCompra(
          id: event.id,
          nome: event.get("nome"),
          data: Timestamp.fromDate(DateTime.now()),
          listaProdutos: allData);

      ctx.dispatch(PageActionCreator.initToDosAction(listaCompra));
    });
  });
}

void _onAdd(Action action, Context<PageState> ctx) {
  Navigator.of(ctx.context).pushNamed('add_produto',
      arguments: {"idLista": ctx.state.listaCompra.id}).then((dynamic toDo) {
    // ctx.dispatch(list_action.ToDoListActionCreator.add(toDo));
  });
}




void _onArquivar(Action action, Context<PageState> ctx) async {
  final String select = await showDialog<String>(
      context: ctx.context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text('Arquivar a lista "${ctx.state.listaCompra.nome}"?'),
          actions: <Widget>[
            GestureDetector(
              child: const Text(
                'Não',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () => Navigator.of(buildContext).pop(),
            ),
            GestureDetector(
              child: const Text('Sim', style: TextStyle(fontSize: 16.0)),
              onTap: () => Navigator.of(buildContext).pop('Yes'),
            )
          ],
        );
      });

  if (select == 'Yes') {
    // ctx.state;
    FirebaseServiceDados.arquivarListaCompra(ctx.state.listaCompra);
  }
}


void _onCompartilharLista(Action action, Context<PageState> ctx) async {

  TextEditingController email =
  TextEditingController();


  final String select = await showDialog<String>(
      context: ctx.context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text('Informe o e-mail do usuário'),
          content: Container(child: TextFormField(
            controller: email,
          ),),
          actions: <Widget>[


            GestureDetector(
              child: const Text(
                'Cancelar',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () => Navigator.of(buildContext).pop(),
            ),
            GestureDetector(
              child: const Text('Compratilhar', style: TextStyle(fontSize:
              16.0)),
              onTap: () => Navigator.of(buildContext).pop('Yes'),
            )
          ],
        );
      });

  if (select == 'Yes') {
    // ctx.state;
    bool existe =  await FirebaseServiceDados.compartilharLista(ctx.state, email
        .value.text);

    if(!existe){
      Toast.show('Não existe este e-mail', ctx
          .context,
          duration: 3, gravity: Toast.BOTTOM);
    }else{
      Toast.show('Compartilhado com Sucesso!', ctx
          .context,
          duration: 3, gravity: Toast.BOTTOM);
    }
  }
}