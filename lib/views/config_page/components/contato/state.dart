import 'package:fish_redux/fish_redux.dart';

import '../../state.dart';

class ContatoState implements Cloneable<ContatoState> {

  @override
  ContatoState clone() {
    return ContatoState();
  }
}


class ContatoStateConnector extends ConnOp<AccountState, ContatoState> {
  @override
  ContatoState get(AccountState state) {
    ContatoState substate = ContatoState();


    return substate;
  }
}
