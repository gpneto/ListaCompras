import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ContatoState> buildReducer() {
  return asReducer(
    <Object, Reducer<ContatoState>>{
      ContatoAction.action: _onAction,
    },
  );
}

ContatoState _onAction(ContatoState state, Action action) {
  final ContatoState newState = state.clone();
  return newState;
}
