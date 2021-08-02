import 'package:fish_redux/fish_redux.dart';

enum MainPageAction { action }

class MainPageActionCreator {
  static Action onAction() {
    return const Action(MainPageAction.action);
  }


}
