import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MenusState> buildReducer() {
  return asReducer(
    <Object, Reducer<MenusState>>{
      MenusAction.action: _onAction,
    },
  );
}

MenusState _onAction(MenusState state, Action action) {
  final MenusState newState = state.clone();
  return newState;
}
