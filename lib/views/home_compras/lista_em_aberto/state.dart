import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/lista_compra_usuario.dart';
import 'package:lista_compras/models/lista_compras.dart';
import 'package:lista_compras/views/home_compras/state.dart';

class ListaComprasAbertaState implements Cloneable<ListaComprasAbertaState> {

  List<ListaCompraUsuario> listasComprasEmAberto;

  List<ListaCompraUsuario> listasComprasArquivadas;


  ListaComprasAbertaState({this.listasComprasEmAberto});

  @override
  ListaComprasAbertaState clone() {
    return ListaComprasAbertaState()..listasComprasEmAberto = listasComprasEmAberto
    ..listasComprasArquivadas = listasComprasArquivadas;
  }

}
class  ListaComprasEmAbertoConnector
    extends ConnOp<HomeComprasState, ListaComprasAbertaState> {
  @override
  ListaComprasAbertaState get(HomeComprasState state) {
    ListaComprasAbertaState substate = new ListaComprasAbertaState();
    substate.listasComprasEmAberto = state.listaComprasEmAberto ?? [];
    substate.listasComprasArquivadas = state.listaComprasFinalizadas ?? [];
    return substate;
  }
}
