import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/views/config_page/state.dart';

class BrilhoState implements Cloneable<BrilhoState> {

  @override
  BrilhoState clone() {
    return BrilhoState();
  }
}


class BrilhoStateConnector extends ConnOp<AccountState, BrilhoState> {
  @override
  BrilhoState get(AccountState state) {
    BrilhoState substate = BrilhoState();


    return substate;
  }
}
