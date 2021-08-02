import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/views/config_page/state.dart';

class MenusState implements Cloneable<MenusState> {

  @override
  MenusState clone() {
    return MenusState();
  }
}

class MenusStateConnector extends ConnOp<AccountState, MenusState> {
  @override
  MenusState get(AccountState state) {
    MenusState substate = MenusState();


    return substate;
  }
}