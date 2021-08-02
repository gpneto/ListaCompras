import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MenusAction { action }

class MenusActionCreator {
  static Action onAction() {
    return const Action(MenusAction.action);
  }
}
