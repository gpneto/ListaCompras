import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/item_lista_compra.dart';

import 'lista_compra_usuario.dart';


class ListaCompra  {


   ListaCompraUsuario listaCompraUsuario;
   String id;
   String nome;
   Timestamp data;
   int totalProdutos;
   int totalSeledcionados;
   List<ItemListaCompra> listaProdutos;

   ListaCompra({this.listaCompraUsuario, this.id,this.nome, this.data, this
       .totalProdutos, this
       .totalSeledcionados, this.listaProdutos});


}
