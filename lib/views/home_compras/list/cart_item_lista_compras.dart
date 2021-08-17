import 'dart:ffi';
import 'dart:math';

import 'package:ai_progress/ai_progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:lista_compras/models/lista_compra_usuario.dart';

import 'package:lista_compras/models/lista_compras.dart';

import 'package:lista_compras/views/todo_list_page/page.dart';
import 'package:lista_compras/widgets/CustomColors.dart';

class CardItemListaCompra extends StatelessWidget {
  final ListaCompraUsuario refListaUsuario;
  final DocumentReference docRef;
  final Dispatch dispatch;

  const CardItemListaCompra({Key key, this.docRef, this.dispatch, this.refListaUsuario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {


    return new StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: docRef.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.data() == null)
          return new Center(
              child: new CircularProgressIndicator());


        ListaCompra lista= ListaCompra(
            listaCompraUsuario: refListaUsuario,
            id:snapshot.data.id,
            nome: snapshot.data.data()["nome"],
            totalSeledcionados: snapshot.data.data()["total_selecionado"] ?? 0,
            totalProdutos: snapshot.data.data()["total_itens"] ?? 0,
            data: snapshot.data.data()["data"]);

        return GestureDetector(
          onTap:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            // return CompraDetailPagePage().buildPage({'listaCompra': entry});
            return ToDoListPage().buildPage({'lista': lista});
          })),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [CustomColors.GreenIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    lista.nome,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: CustomColors.TextHeader,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 7, right: 7),
                                    child: Text(
                                      DateFormat('dd/MM/yyy')
                                          .format(lista.data.toDate()),
                                      style:  TextStyle(
                                          color: CustomColors.TextHeader,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Itens (${lista.totalSeledcionados}/${lista.totalProdutos})",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: CustomColors.TextGrey),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(45),
                                            bottomLeft: Radius.circular(45),
                                            topRight: Radius.circular(45),
                                            bottomRight: Radius.circular(45),
                                          )),
                                    ),
                                    width: 200,
                                    height: 8.0,
                                    child:
                                    lista.totalProdutos > 0 ?
                                    AirStepStateProgressIndicator(
                                      size: Size(20, 20),
                                      stepCount: lista.totalProdutos,
                                      stepValue: lista.totalSeledcionados,
                                      valueColor: CustomColors.GreenAccent,
                                      pathColor:  CustomColors.GreenShadow,
                                      pathStrokeWidth: 30.0,
                                      valueStrokeWidth: 30.0,
                                    ) : Container(),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // onTap: () => dispatch(
              //   EntryActionCreator.onEditarEntry(entry),
              // ),
            ),
          ),
        );
      },
    );


  }
}
