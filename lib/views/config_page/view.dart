import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lista_compras/app.dart';
import 'package:lista_compras/style/themestyle.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';

import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AccountState state, Dispatch dispatch, ViewService viewService) {


  return Builder(
    key:  UniqueKey(),
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);

      return Scaffold(
        drawer: Scaffold.hasDrawer(context)  ?  Scaffold.of(context).widget.drawer : null,
        // appBar: Scaffold.hasDrawer(context) ?  AppBar(title: defaultTargetPlatformNative != TargetPlatformNative.android ?  null :  new Text('Configurações')) : null,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
            child:Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.grey, Colors.grey[100]],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: new CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      title:  new Text('Configurações'),
                      iconTheme: IconThemeData(color: Colors.green),
                    ),

                    new SliverList(
                      delegate: new SliverChildListDelegate(
                        <Widget>[
                          viewService.buildComponent('userInfo'),
                          viewService.buildComponent('contato'),
                          viewService.buildComponent('menus'),
                          viewService.buildComponent('tema'),
                          SafeArea(
                            top: false,
                            bottom: defaultTargetPlatformNative == TargetPlatformNative.android ? false : true,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: viewService.buildComponent('brilho'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

        ),
      );
    },
  );
}
