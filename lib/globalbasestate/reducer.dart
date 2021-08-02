import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:lista_compras/generated/i18n.dart';
import 'package:lista_compras/models/app_user.dart';
import 'package:lista_compras/models/base_api_model/user_premium_model.dart';
import 'package:lista_compras/routes/routes.dart';
import 'package:lista_compras/widgets/menu_item.dart';
import 'package:lista_compras/widgets/prefs.dart';


import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeColor: _onchangeThemeColor,
      GlobalAction.changeLocale: _onChangeLocale,
      GlobalAction.setUser: _onSetUser,
      GlobalAction.setUserPremium: _onSetUserPremium,
      GlobalAction.tabchanged:_onTabChanged,
      GlobalAction.setPages: _setPages,
      GlobalAction.setTheme: _setTheme
    },
  );
}

List<Color> _colors = <Color>[
  Colors.green,
  Colors.red,
  Colors.black,
  Colors.blue
];

GlobalState _onchangeThemeColor(GlobalState state, Action action) {
  final Color next =
      _colors[((_colors.indexOf(state.themeColor) + 1) % _colors.length)];
  return state.clone()..themeColor = next;
}

GlobalState _onChangeLocale(GlobalState state, Action action) {
  final Locale l = action.payload;
  I18n.onLocaleChanged(l);
  return state.clone()..locale = l;
}

GlobalState _onSetUser(GlobalState state, Action action) {
  final AppUser user = action.payload;
  return state.clone()..user = user;
}

GlobalState _onSetUserPremium(GlobalState state, Action action) {
  final UserPremiumData _data = action.payload;
  final AppUser _user =
      AppUser(firebaseUser: state.user.firebaseUser, premium: _data);
  return state.clone()..user = _user;
}


GlobalState _onTabChanged(GlobalState state, Action action) {
  final int newindex=action.payload??0;
  final GlobalState newState = state.clone();
  newState.selectedIndexPage=newindex;
  newState.configPage = state.pages.indexWhere((element) => element.id == "config") == newindex;

  return newState;
}

GlobalState _setPages(GlobalState state, Action action) {
  //Primeiro verifica quais estão ativos

  List ordemMenus = Prefs.singleton().getOrdemMenu();
  List menusDisabilitados = Prefs.singleton().getMenusDisabled();

 List<ItemMenu> menusVisiveis =  Routes.menuItens.where((element) => !menusDisabilitados.contains(element.id)).toList();

 if(menusVisiveis.length < 2){
   menusVisiveis = Routes.menuItens;
   Prefs.singleton().removePref(Prefs.MENUS_DISABLED_PREF);
 }else{
   menusVisiveis.sort((a, b) =>
   ordemMenus.lastIndexOf(a.id).compareTo(ordemMenus.lastIndexOf(b.id)));

 }


  return state.clone()..pages =  menusVisiveis
  ..selectedIndexPage = action.payload ? menusVisiveis.indexWhere((element) => element.id == "config") : state.clone().selectedIndexPage ;
}

GlobalState _setTheme(GlobalState state, Action action) {
  return state.clone()..defaultTargetPlatformNative = action.payload;
}