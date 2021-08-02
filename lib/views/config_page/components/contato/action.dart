import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ContatoAction { action }

class ContatoActionCreator {
  static Action onAction() {
    return const Action(ContatoAction.action);
  }
}
