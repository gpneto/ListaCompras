import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/views/config_page/components/brilho/state.dart';
import 'package:lista_compras/views/config_page/components/contato/state.dart';
import 'package:lista_compras/views/config_page/components/menus/state.dart';
import 'package:lista_compras/views/config_page/components/tema/component.dart';
import 'package:lista_compras/views/config_page/components/tema/state.dart';
import 'package:lista_compras/views/config_page/components/user_info/component.dart';
import 'package:lista_compras/views/config_page/components/user_info/state.dart';

import 'components/brilho/component.dart';
import 'components/contato/component.dart';
import 'components/menus/component.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ConfigPage extends Page<AccountState, Map<String, dynamic>> with TickerProviderMixin {
  ConfigPage()
      : super(
    shouldUpdate: (oldState, newState) {
      return false;
    },

          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
        dependencies: Dependencies<AccountState>(
        adapter: null,
        slots: <String, Dependent<AccountState>>{
          'userInfo': UserInfoConnector() + UserInfoComponent(),
          'contato': ContatoStateConnector() + ContatoComponent(),
          'menus': MenusStateConnector() + MenusComponent(),
          'brilho': BrilhoStateConnector() + BrilhoComponent(),
          'tema': TemaStateConnector() + TemaComponent()
        }),
          middleware: <Middleware<AccountState>>[],
        );
}
