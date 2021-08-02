import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TemaState> buildReducer() {
  return asReducer(
    <Object, Reducer<TemaState>>{
      TemaAction.action: _onAction,
    },
  );
}

TemaState _onAction(TemaState state, Action action) {
  final TemaState newState = state.clone();
  return newState;
}
