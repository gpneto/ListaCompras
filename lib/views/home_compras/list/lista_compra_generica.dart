import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lista_compras/models/lista_compra_usuario.dart';
import 'package:lista_compras/models/lista_compras.dart';
import 'package:lista_compras/views/home_compras/lista_em_aberto/action.dart';
import 'package:lista_compras/widgets/CustomColors.dart';

import 'cart_item_lista_compras.dart';

class ListaComprasGeneric extends StatelessWidget {

  final List<ListaCompraUsuario> listaCompras;
  final Dispatch dispatch;
  final String title;

  const ListaComprasGeneric({
    Key key,
    @required this.listaCompras,
    this.dispatch,
    @required this.title
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    List<ListaCompraUsuario> fiveFirstCompras =  listaCompras.take(3).toList();

    return Container(
      margin: EdgeInsets.all(10),
      child: Container(
        color: CustomColors.GreyBackground,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 5),
                  child: Text(
                     title,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.TextSubHeader),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10, top: 5),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: Colors.blueAccent,
                    highlightColor: Colors.blueAccent,
                    splashColor: Colors.white60,
                    // onPressed: () => dispatch(ListaComprasAbertoCreator.seeAll(listaCompras)),
                    child: Text(
                      "Ver todos",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: (() {
                    return fiveFirstCompras.length > 0
                        ? Column(
                      children:
                      List.generate(fiveFirstCompras.length, (index) {

                        ListaCompraUsuario doc =  fiveFirstCompras[index];

                        return CardItemListaCompra( docRef: doc.documentReference,dispatch:
                        dispatch,refListaUsuario:  doc,);
                      }),
                    )
                        : Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text("No entries created"),
                    );
                  })(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}