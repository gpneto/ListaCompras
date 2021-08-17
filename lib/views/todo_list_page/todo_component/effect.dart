import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:lista_compras/data/FirebaseServiceDados.dart';

import 'action.dart';
import 'state.dart';

Effect<ToDoState> buildEffect() {
  return combineEffects(<Object, Effect<ToDoState>>{
    ToDoAction.edit: _edit,
    ToDoAction.onEdit: _onEdit,
    ToDoAction.onRemove: _onRemove,
    ToDoAction.remove: _remove,
    ToDoAction.done: _markDone
  });
}

void _markDone(Action action, Context<ToDoState> ctx) async{
  final ToDoState uniqueId = action.payload;
  uniqueId.isDone = !uniqueId.isDone;
  await FirebaseServiceDados.saveProdutoLista(uniqueId);

}


void _edit(Action action, Context<ToDoState> ctx) async{
  final ToDoState uniqueId = action.payload;
  await FirebaseServiceDados.saveProdutoLista(uniqueId);

}


void _onEdit(Action action, Context<ToDoState> ctx) {
  if (action.payload == ctx.state.uniqueId) {

    Navigator.of(ctx.context)
        .pushNamed('todo_edit', arguments: ctx.state)
        .then((dynamic toDo) {
      if (toDo != null) {
        ctx.dispatch(ToDoActionCreator.editAction(toDo));
      }
    });
  }
}

void _onRemove(Action action, Context<ToDoState> ctx) async {
  final String select = await showDialog<String>(
      context: ctx.context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text('Remover o produto "${ctx.state.produtoNome}" da Lista?'),
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
    ctx.dispatch(ToDoActionCreator.removeAction(ctx.state));
  }
}

void _remove(Action action, Context<ToDoState> ctx) async{
  final ToDoState unique = action.payload;
  await FirebaseServiceDados.removerProdutoDaLista(unique);

}
