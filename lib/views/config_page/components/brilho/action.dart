import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum BrilhoAction { action }

class BrilhoActionCreator {
  static Action onAction() {
    return const Action(BrilhoAction.action);
  }
}
