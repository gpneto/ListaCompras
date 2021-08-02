import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/app_user.dart';
import 'package:lista_compras/widgets/menu_item.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';


abstract class GlobalBaseState {

  int get selectedIndexPage;
  set selectedIndexPage(int selectedIndexPage);

  bool get configPage;
  set configPage(bool configPage);

  TargetPlatformNative get defaultTargetPlatformNative;
  set defaultTargetPlatformNative(TargetPlatformNative defaultTargetPlatformNative);


  Color get themeColor;
  set themeColor(Color color);

  Locale get locale;
  set locale(Locale locale);

  AppUser get user;
  set user(AppUser u);

  List<ItemMenu> get pages;
  set pages(List<ItemMenu> pages);

}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  AppUser user;

  @override
  int selectedIndexPage;

  @override
  List<ItemMenu> pages;

  @override
  GlobalState clone() {
    return GlobalState()
      ..themeColor = themeColor
      ..locale = locale
      ..user = user
      ..selectedIndexPage = selectedIndexPage
    ..pages = pages
    ..configPage = configPage;
  }

  @override
  bool configPage = false;

  @override
  TargetPlatformNative defaultTargetPlatformNative;


}
