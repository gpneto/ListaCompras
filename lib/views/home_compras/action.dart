import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/lista_compra_usuario.dart';
import 'package:lista_compras/models/lista_compras.dart';


enum HomeComprasAction {  finalizouBuscaListaEmAberto,
  finalizouBuscaListaFinalizadas, addNovaLista }

class HomeComprasActionCreator {
  static Action finalizouBuscaListaEmAberto(List<ListaCompraUsuario>  listaEmAberto)=>
      Action(HomeComprasAction.finalizouBuscaListaEmAberto, payload: listaEmAberto);

  static Action finalizouBuscaListaFinalizadas(List<ListaCompraUsuario>  listaEmAberto)=>
      Action(HomeComprasAction.finalizouBuscaListaFinalizadas, payload: listaEmAberto);

  static Action addNovaLista(String nome)=>
      Action(HomeComprasAction.addNovaLista, payload: nome);
}
