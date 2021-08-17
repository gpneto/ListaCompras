import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:intl/intl.dart';
import 'package:lista_compras/models/lista_compras.dart';
import 'package:lista_compras/views/home_compras/list/cart_item_lista_compras.dart';
import 'package:lista_compras/views/home_compras/list/lista_compra_generica.dart';
import 'package:lista_compras/views/home_compras/lista_em_aberto/state.dart';

import 'action.dart';

Widget buildView(
    ListaComprasAbertaState state,
  Dispatch dispatch,
  ViewService viewService,
) {

  return Column(
    children: <Widget>[
      ListaComprasGeneric(listaCompras: state.listasComprasEmAberto, dispatch: dispatch, title: "Compas em Aberto",),
      ListaComprasGeneric(listaCompras: state.listasComprasArquivadas, dispatch: dispatch,title: "Compas em Finalizadas",)
    ],
  );
}


