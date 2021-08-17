import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/globalbasestate/state.dart';
import 'package:lista_compras/models/app_user.dart';
import 'package:lista_compras/models/lista_compra_usuario.dart';
import 'package:lista_compras/models/lista_compras.dart';
import 'package:lista_compras/widgets/menu_item.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';

class HomeComprasState implements  GlobalBaseState, Cloneable<HomeComprasState> {

  List<ListaCompraUsuario> listaComprasEmAberto;
  List<ListaCompraUsuario> listaComprasFinalizadas;


  @override
  HomeComprasState clone() {
    return HomeComprasState()
    ..listaComprasEmAberto = listaComprasEmAberto
    ..listaComprasFinalizadas = listaComprasFinalizadas
    ..user = user;
  }

  @override
  bool configPage;

  @override
  TargetPlatformNative defaultTargetPlatformNative;

  @override
  Locale locale;

  @override
  List<ItemMenu> pages;

  @override
  int selectedIndexPage;

  @override
  Color themeColor;

  @override
  AppUser user;
}

HomeComprasState initState(Map<String, dynamic> args) {
  return HomeComprasState()..listaComprasEmAberto = []
  ..listaComprasFinalizadas = [];
}
