import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeComprasState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeComprasState>>{
      HomeComprasAction.finalizouBuscaListaEmAberto: _buscaListaEmAberto,
      HomeComprasAction.finalizouBuscaListaFinalizadas: _buscaListaFinalizadas,
    },
  );
}

HomeComprasState _buscaListaEmAberto(HomeComprasState state, Action action) {
  final HomeComprasState newState = state.clone();
  newState.listaComprasEmAberto = action.payload;
  return newState;
}


HomeComprasState _buscaListaFinalizadas(HomeComprasState state, Action action) {
  final HomeComprasState newState = state.clone();
  newState.listaComprasFinalizadas = action.payload;
  return newState;
}
