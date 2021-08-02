import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:lista_compras/globalbasestate/action.dart';
import 'package:lista_compras/globalbasestate/store.dart';
import 'package:lista_compras/routes/routes.dart';
import 'package:lista_compras/views/config_page/action.dart';
import 'state.dart';

Effect<AccountState> buildEffect() {
  return combineEffects(<Object, Effect<AccountState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose,
    ConfigPageAction.logout: _onLogout
  });
}


void _onInit(Action action, Context<AccountState> ctx) {
  final Object ticker = ctx.stfState;
  ctx.state.screenController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 600));

}

void _onLogout(Action action, Context<AccountState> ctx) async{
  FirebaseAuth.instance.signOut();

  GlobalStore.store.dispatch(GlobalActionCreator.setUser(null));

  //Rediciona para tela de Login

  await Navigator.of(ctx.context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, __, ___) {
        return Routes.routes.buildPage('loginPage', null);
      },
      settings: RouteSettings(name: 'mainpage')));
}

void _onBuild(Action action, Context<AccountState> ctx) {
  ctx.state.screenController.forward();
  // if(ctx.state.selectedIndexPage != 2){
  //   ctx.state.screenController.reverse();
  // }
}

void _onDispose(Action action, Context<AccountState> ctx) {
  ctx.state.screenController.dispose();

}