import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/views/home_compras/lista_em_aberto/component.dart';
import 'package:lista_compras/views/home_compras/lista_em_aberto/state.dart';
import 'package:lista_compras/views/home_compras/user_info/component.dart';
import 'package:lista_compras/views/home_compras/user_info/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomeComprasPage extends Page<HomeComprasState, Map<String, dynamic>> {
  HomeComprasPage()
      : super(
    shouldUpdate: (oldState, newState) {
      return oldState.listaComprasEmAberto != newState.listaComprasEmAberto;
    },

    initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HomeComprasState>(
                adapter: null,
                slots: <String, Dependent<HomeComprasState>>{
                  'listaCompras': ListaComprasEmAbertoConnector() + ListaComprasEmAbertoComponent(),
                  'userInfo': UserInfoConnector() + UserInfoComponent(),
                }),
            middleware: <Middleware<HomeComprasState>>[
            ],);

}
