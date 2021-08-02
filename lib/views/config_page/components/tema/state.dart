import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/views/config_page/state.dart';

class TemaState implements Cloneable<TemaState> {

  @override
  TemaState clone() {
    return TemaState();
  }
}

class TemaStateConnector extends ConnOp<AccountState, TemaState> {
  @override
  TemaState get(AccountState state) {
    TemaState substate = TemaState();


    return substate;
  }
}
