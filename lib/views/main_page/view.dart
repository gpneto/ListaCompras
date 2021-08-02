import 'package:fish_redux/fish_redux.dart' as f;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/actions/adapt.dart';
import 'package:lista_compras/generated/i18n.dart';
import 'package:lista_compras/globalbasestate/action.dart';
import 'package:lista_compras/globalbasestate/store.dart';
import 'package:lista_compras/routes/routes.dart';
import 'package:lista_compras/views/config_page/page.dart';
import 'package:lista_compras/views/main_page/temas/android.dart';
import 'package:lista_compras/views/main_page/temas/custom.dart';
import 'package:lista_compras/views/main_page/temas/ios.dart';
import 'package:lista_compras/widgets/keepalive_widget.dart';
import 'package:lista_compras/widgets/platform_widget_native.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MainPageState state, f.Dispatch dispatch, f.ViewService viewService) {
  return  PlatformWidgetNative(
    // key: key,
    androidBuilder: buildViewAndroid(state,dispatch,viewService),
    iosBuilder: buildViewIos(state,dispatch,viewService),
    appBuilder: buildViewCuston(state,dispatch,viewService),
  );
}
