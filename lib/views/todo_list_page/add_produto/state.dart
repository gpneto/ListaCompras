import 'package:fish_redux/fish_redux.dart';

class AddProdutoState implements Cloneable<AddProdutoState> {

  @override
  AddProdutoState clone() {
    return AddProdutoState();
  }
}

AddProdutoState initState(Map<String, dynamic> args) {
  return AddProdutoState();
}
