import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/app.dart';
import 'package:lista_compras/widgets/info_list_section.dart';
import 'package:lista_compras/widgets/prefs.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(TemaState state, Dispatch dispatch, ViewService viewService) {





  return InfoListSection(
      title: 'Tema',
      child:  _Tema()
  );
}


class _Tema extends StatefulWidget {


  @override
  _TemaState createState() => _TemaState();
}

class _TemaState extends State<_Tema> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var temaIos = CupertinoSwitch(
      value: defaultTargetPlatformNative == TargetPlatformNative.iOS,
      onChanged: (bool value) {

        setState(() {
          Prefs.singleton().setThemeNative(TargetPlatformNative.iOS.toString());
        });
        // defaultTargetPlatformNative = TargetPlatformNative.iOS;

        // AppHome.restartApp(context);


      },
    );

    var temaIosColumn  = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "iOS Nativo",
              style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),
            ),
            temaIos
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );


    var temaAndroid = CupertinoSwitch(
      value: defaultTargetPlatformNative == TargetPlatformNative.android,
      onChanged: (bool value) {

        // defaultTargetPlatformNative = TargetPlatformNative.android;
        setState(() {
          Prefs.singleton().setThemeNative(TargetPlatformNative.android.toString());
        });

        // AppHome.restartApp(context);

      },
    );

    var temaAndroidColumn  = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Android Nativo",
              style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),
            ),
            temaAndroid
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );


    var temaApp = CupertinoSwitch(
      value: defaultTargetPlatformNative == TargetPlatformNative.app,
      onChanged: (bool value) {
        setState(() {
          Prefs.singleton().setThemeNative(TargetPlatformNative.app.toString());
        });

        // AppHome.restartApp(viewService.context);

      },
    );

    var temaAppColumn  = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Padrão",
              style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),
            ),
            temaApp
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );


    return Column(
      children: <Widget>[
        temaAppColumn,
        temaIosColumn,
        temaAndroidColumn
      ],
    );

  }
}