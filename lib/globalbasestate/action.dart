import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/app_user.dart';
import 'package:lista_compras/models/base_api_model/user_premium_model.dart';
import 'package:lista_compras/widgets/menu_item.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';


enum GlobalAction { changeThemeColor, changeLocale, setUser, setUserPremium, tabchanged, setPages, setTheme }

class GlobalActionCreator {
  static Action onchangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }

  static Action changeLocale(Locale l) {
    return Action(GlobalAction.changeLocale, payload: l);
  }

  static Action setUser(AppUser user) {
    return Action(GlobalAction.setUser, payload: user);
  }

  static Action setUserPremium(UserPremiumData premiumData) {
    return Action(GlobalAction.setUserPremium, payload: premiumData);
  }

  static Action onTabChanged(int index) {
    return Action(GlobalAction.tabchanged, payload: index);
  }

  static Action setPages(bool change) {
    return Action(GlobalAction.setPages, payload: change);
  }

  static Action setTheme(TargetPlatformNative theme) {
    return Action(GlobalAction.setTheme, payload: theme);
  }
}
