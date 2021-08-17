import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:lista_compras/models/app_user.dart';
import 'package:lista_compras/views/config_page/state.dart';
import 'package:lista_compras/views/home_compras/state.dart';

class UserInfoState implements Cloneable<UserInfoState> {


  AnimationController screenController;

  int selectedIndexPage ;

  AppUser user;

  int totalListaAberto;

  @override
  UserInfoState clone() {
    return UserInfoState() ..user = user
    ..screenController = screenController
    ..selectedIndexPage = selectedIndexPage
    ..totalListaAberto = totalListaAberto;
  }
}




class UserInfoConnector extends ConnOp<HomeComprasState, UserInfoState> {
  @override
  UserInfoState get(HomeComprasState state) {
    UserInfoState substate = UserInfoState();
    substate.user = state.user;
    substate.totalListaAberto = state.listaComprasEmAberto.length;

    return substate;
  }
}
