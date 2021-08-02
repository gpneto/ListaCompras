import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/widgets/info_list_section.dart';
import 'package:lista_compras/widgets/prefs.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    BrilhoState state, Dispatch dispatch, ViewService viewService) {

  return InfoListSection(
      title: 'Brilho',
      child: _Bilho());
}


class _Bilho extends StatefulWidget {


  @override
  _BrilhoState createState() => _BrilhoState();
}

class _BrilhoState extends State<_Bilho> {

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



    var themeDarkColumn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Dark",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).textTheme.bodyText1.color),
            ),
            CupertinoSwitch(
              value: Prefs.singleton().getTheme() == Themes.DARK.toString(),
              onChanged: (bool value) {
                setState(() {
                  Prefs.singleton().setTheme(Themes.DARK.toString());
                });

              },
            )
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );

    var themeLIGHTColumn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Light",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).textTheme.bodyText1.color),
            ),
            CupertinoSwitch(
              value: Prefs.singleton().getTheme() == Themes.LIGHT.toString(),
              onChanged: (bool value) {
                setState(() {
                  Prefs.singleton().setTheme(Themes.LIGHT.toString());
                });

              },
            )
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );

    var themeSystemColumn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "System",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).textTheme.bodyText1.color),
            ),
            CupertinoSwitch(
              value: Prefs.singleton().getTheme() == Themes.SYSTEM.toString(),
              onChanged: (bool value) {
                setState(() {
                  Prefs.singleton().setTheme(Themes.SYSTEM.toString());
                });

              },
            )
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );


    return Column(
      children: <Widget>[
        themeSystemColumn,
        themeDarkColumn,
        themeLIGHTColumn,
      ],
    );

  }
}