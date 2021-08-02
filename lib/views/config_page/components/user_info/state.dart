import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:lista_compras/models/app_user.dart';
import 'package:lista_compras/views/config_page/state.dart';

class UserInfoState implements Cloneable<UserInfoState> {


  AnimationController screenController;

  int selectedIndexPage ;

  AppUser user;

  @override
  UserInfoState clone() {
    return UserInfoState() ..user = user
    ..screenController = screenController
    ..selectedIndexPage = selectedIndexPage;
  }
}




class UserInfoConnector extends ConnOp<AccountState, UserInfoState> {
  @override
  UserInfoState get(AccountState state) {
    UserInfoState substate = UserInfoState();
    substate.user = state.user;
    substate.screenController = state.screenController;
    substate.selectedIndexPage = state.selectedIndexPage;

    return substate;
  }
}
