import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AddProdutoAction { action }

class AddProdutoActionCreator {
  static Action onAction() {
    return const Action(AddProdutoAction.action);
  }
}
