import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AddProdutoState> buildReducer() {
  return asReducer(
    <Object, Reducer<AddProdutoState>>{
      AddProdutoAction.action: _onAction,
    },
  );
}

AddProdutoState _onAction(AddProdutoState state, Action action) {
  final AddProdutoState newState = state.clone();
  return newState;
}
