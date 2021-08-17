import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/lista_compras.dart';


enum ListaComprasAbertoAction { onAddAction, seeAll }

class ListaComprasAbertoCreator {
  static Action onAddAction() {
    return const Action(ListaComprasAbertoAction.onAddAction);
  }

  static Action seeAll(List<DocumentReference> lista) {
    return  Action(ListaComprasAbertoAction.seeAll, payload: lista);
  }


}
