import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lista_compras/globalbasestate/state.dart';
import 'package:lista_compras/models/app_user.dart';
import 'package:lista_compras/widgets/menu_item.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';


class DiscoverPageState
    implements GlobalBaseState, Cloneable<DiscoverPageState> {

  ScrollController scrollController;
  GlobalKey stackKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  bool sortDesc;
  bool isMovie;
  bool isbusy;
  double lVote;
  double rVote;

  @override
  DiscoverPageState clone() {
    return DiscoverPageState()

      ..scrollController = scrollController
      ..scaffoldKey = scaffoldKey
      ..stackKey = stackKey
      ..lVote = lVote
      ..rVote = rVote;




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

DiscoverPageState initState(Map<String, dynamic> args) {
  final DiscoverPageState state = DiscoverPageState();

  state.scaffoldKey = GlobalKey();
  state.stackKey = GlobalKey();
  state.sortDesc = true;
  state.isMovie = true;
  state.isbusy = false;
  state.lVote = 0.0;
  state.rVote = 10.0;

  return state;
}
