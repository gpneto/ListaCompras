import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/globalbasestate/state.dart';
import 'package:lista_compras/models/app_user.dart';
import 'package:lista_compras/routes/routes.dart';
import 'package:lista_compras/widgets/menu_item.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';


class MainPageState implements GlobalBaseState, Cloneable<MainPageState> {



  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  MainPageState clone() {
    return MainPageState()
      ..pages = pages
      ..selectedIndexPage = selectedIndexPage
      ..scaffoldKey = scaffoldKey
      ..locale = locale
    ..user = user;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  AppUser user;

  @override
  int selectedIndexPage;

  @override
  List<ItemMenu> pages;

  @override
  bool configPage;

  @override
  TargetPlatformNative defaultTargetPlatformNative;
}

MainPageState initState(Map<String, dynamic> args) {
  return MainPageState()..pages = Routes.menuItens;
}
