import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BrilhoState> buildReducer() {
  return asReducer(
    <Object, Reducer<BrilhoState>>{
      BrilhoAction.action: _onAction,
    },
  );
}

BrilhoState _onAction(BrilhoState state, Action action) {
  final BrilhoState newState = state.clone();
  return newState;
}
