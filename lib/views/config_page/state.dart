import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lista_compras/globalbasestate/state.dart';
import 'package:lista_compras/models/app_user.dart';
import 'package:lista_compras/views/config_page/components/user_info/state.dart';
import 'package:lista_compras/widgets/menu_item.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';


class AccountState
    implements GlobalBaseState, Cloneable<AccountState> {

  UserInfoState userInfoState;


  AnimationController screenController;

  @override
  AccountState clone() {
    return AccountState() ..userInfoState = userInfoState
    ..screenController = screenController
    ;


  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  AppUser user;


  @override
  String getItemType(int index) => 'moviecell';


  @override
  void setItemData(int index, Object data) {}

  @override
  int selectedIndexPage;

  @override
  List<ItemMenu> pages;

  @override
  bool configPage;

  @override
  TargetPlatformNative defaultTargetPlatformNative;
}

AccountState initState(Map<String, dynamic> args) {
  final AccountState state = AccountState();
  state.userInfoState = UserInfoState();

  return state;
}
