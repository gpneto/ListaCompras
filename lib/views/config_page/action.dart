import 'package:fish_redux/fish_redux.dart';


enum ConfigPageAction {
  logout
}

class ConfigPageActionCreator {

  static Action onLogout() {
    return const Action(ConfigPageAction.logout);
  }

}
