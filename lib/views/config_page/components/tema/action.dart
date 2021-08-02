import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TemaAction { action }

class TemaActionCreator {
  static Action onAction() {
    return const Action(TemaAction.action);
  }
}
