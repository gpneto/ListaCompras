import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/item_lista_compra.dart';

import 'action.dart';
import 'state.dart';

Reducer<ToDoState> buildReducer() {
  return asReducer(<Object, Reducer<ToDoState>>{
  });
}



