import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/style/themestyle.dart';

import 'package:lista_compras/widgets/CustomColors.dart';
import 'package:lista_compras/widgets/constants.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HomeComprasState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Scaffold(
      drawer: Scaffold.hasDrawer(context)
          ? Scaffold.of(context).widget.drawer
          : null,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: viewService.buildComponent('userInfo')),
      body: Container(
        color: CustomColors.GreyBackground,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(child: viewService.buildComponent('listaCompras')),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          onPressed: () => openAlertBoxEdit(context, dispatch),
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  });
}

Color myColor = Color(0xff00bfa5);

openAlertBoxEdit(
    BuildContext context, Dispatch dispatch,) {
  TextEditingController controllerNome =
  TextEditingController();

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Nova Lista",
                      style: TextStyle(fontSize: 24.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10),
                  child: Column(
                    children: [
                      Text(
                        "Nome da Lista",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.TextSubHeader),
                      ),
                      TextFormField(
                        controller: controllerNome
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {

                    dispatch(HomeComprasActionCreator.addNovaLista
                      (controllerNome.value.text));
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: myColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0)),
                    ),
                    child: Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}