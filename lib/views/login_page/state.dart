import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:lista_compras/globalbasestate/state.dart';
import 'package:lista_compras/models/app_user.dart';
import 'package:lista_compras/widgets/menu_item.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';


class LoginPageState implements GlobalBaseState, Cloneable<LoginPageState> {
  String account = '';
  String pwd = '';
  bool emailLogin;
  TextEditingController accountTextController;
  TextEditingController passWordTextController;
  TextEditingController phoneTextController;
  TextEditingController codeTextContraller;
  AnimationController animationController;
  AnimationController submitAnimationController;
  FocusNode accountFocusNode;
  FocusNode pwdFocusNode;
  String countryCode;


  @override
  LoginPageState clone() {
    return LoginPageState()
      ..account = account
      ..pwd = pwd
      ..emailLogin = emailLogin
      ..accountFocusNode = accountFocusNode
      ..pwdFocusNode = pwdFocusNode
      ..animationController = animationController
      ..submitAnimationController = submitAnimationController
      ..accountTextController = accountTextController
      ..passWordTextController = passWordTextController
      ..phoneTextController = phoneTextController
      ..codeTextContraller = codeTextContraller
      ..countryCode = countryCode;
  }

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
  bool configPage;

  @override
  TargetPlatformNative defaultTargetPlatformNative;
}

LoginPageState initState(Map<String, dynamic> args) {
  return LoginPageState();
}
